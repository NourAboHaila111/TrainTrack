// login_state.dart




// login_cubit.dart

// login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:triantrak/sereen/auth/login/cubit/state.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/local/Cach_helper.dart';
import '../../../../shared/network/remote/End_point.dart';
import '../check_forget_code.dart';
import '../../../../model/LoginModel.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((response) {
      final loginModel = LoginModel.fromJson(response.data);
      // حفظ التوكن والرول في الكاش
      CachHelper.SaveData(key: 'token', value: loginModel.token);
      CachHelper.SaveData(key: 'role', value: loginModel.user.role.name);
      emit(LoginSuccess(token: loginModel.token));
    })..catchError((error) {
      print("Error during login: $error");
      if (error is DioError) {
        final response = error.response;
        if (response != null) {
          print("Response status: ${response.statusCode}");
          print("Response body: ${response.data}");
          final message = response.data['message'] ?? 'Login failed';
          emit(LoginFailure(message: message));
        } else {
          emit(LoginFailure(message: 'No response from server'));
        }
      } else {
        emit(LoginFailure(message: error.toString()));
      }
    });
  }

  String? _validateCredentials(String email, String password) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
    if (email.isEmpty) return 'Email field is required';
    //if (!emailRegex.hasMatch(email)) return 'Invalid email format';
    if (password.isEmpty) return 'Password field is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    //if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Password must contain at least one uppercase letter';
   // if (!RegExp(r'[a-z]').hasMatch(password)) return 'Password must contain at least one lowercase letter';
   // if (!RegExp(r'[0-9]').hasMatch(password)) return 'Password must contain at least one number';
    return null;
  }

  void forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    emit(LoginLoading());

    try {
      final response = await DioHelper.postData(
        url: FORGET_PASSWORD,
        data: {
          'email': email,
        },
      );

      final message = response.data['message'] ?? "Code sent successfully";

      emit(ForgetPasswordSuccess(message: message));

      // الانتقال إلى واجهة تحقق الكود مع تمرير الإيميل
      navigateTo(context, CheckCodeScreen(email: email));

    } catch (error) {
      if (error is DioError && error.response != null) {
        final msg = error.response?.data["message"] ?? "Something went wrong";
        emit(LoginFailure(message: msg));
      } else {
        emit(LoginFailure(message: error.toString()));
      }
    }
  }


// login_cubit.dart

  void checkForgetCode({
    required String email,
    required String code,
  }) async {
    emit(CheckCodeLoading());

    try {
      final response = await DioHelper.postData(
        url: CHECK_FORGET_CODE,
        data: {
          "email": email,
          "code": code,
        },
      );

      final message = response.data['message'] ?? "Code is valid";
      emit(CheckCodeSuccess(message));
    } catch (error) {
      if (error is DioError) {
        final msg = error.response?.data["message"] ?? "Invalid code";
        emit(CheckCodeError(msg));
      } else {
        emit(CheckCodeError(error.toString()));
      }
    }
  }
  void resetPassword({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) {
    emit(ResetPasswordLoading());

    DioHelper.postData(
      url: '/reset_password',
      data: {
        'email': email,
        'code': code,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    ).then((response) {
      emit(ResetPasswordSuccess(message: response.data['message']));
    }).catchError((error) {
      final message = error.response?.data['message'] ?? 'Reset failed';
      emit(ResetPasswordError(error: message));
    });
  }
  bool isPasswordVisible = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    suffix = isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityChanged());
  }
}
