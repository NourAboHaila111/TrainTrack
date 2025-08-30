//
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:triantrak/shared/network/remote/dio_helper.dart';
//
// import '../../../../model/ProfileModel.dart';
// import '../../../../shared/network/local/Cach_helper.dart';
// import 'ProfileState.dart';
//
//
// class ProfileCubit extends Cubit<ProfileState> {
//   ProfileCubit() : super(ProfileInitial());
//
//   Future<void> fetchProfile() async {
//     emit(ProfileLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//
//       final response = await DioHelper.getData(
//         url: '/profile',
//         token: token,
//       );
//
//       final profile = ProfileModel.fromJson(response.data);
//       print("................${response.data}");
//       emit(ProfileLoaded(profile));
//     } catch (e) {
//       emit(ProfileError("Error ${e.toString()}"));
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:triantrak/shared/network/remote/dio_helper.dart';
import '../../../../model/ProfileModel.dart';
import '../../../../shared/network/local/Cach_helper.dart';
import '../../login/login.dart';
import 'ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? userProfile;

  /// جلب البروفايل
  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.getData(
        url: '/profile',
        token: token,
      );
      userProfile = ProfileModel.fromJson(response.data);
      print("...........................${response.data}");
      emit(ProfileLoaded(userProfile!));
    } catch (e) {
      emit(ProfileError("Error ${e.toString()}"));
    }
  }

  /// تحديث البروفايل
  Future<void> updateProfile({
    required String name,
    String? password,
    String? confirmPassword,
    String? imagePath, // لو عندك صورة
  }) async {
    emit(ProfileLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final formData = FormData.fromMap({
        'name': name,
        if (password != null && confirmPassword != null) ...{
          'password': password,
          'password_confirmation': confirmPassword,
        },
        if (imagePath != null) ...{
          'image': await MultipartFile.fromFile(imagePath,
              filename: imagePath.split('/').last),
        }
      });

      final response = await DioHelper.postData(
        url: '/updateMyProfile',
        data: formData,
        token: token,
      );

      // بعد التحديث نجلب البروفايل من جديد
      await fetchProfile();
      emit(ProfileSuccess(response.data['message']));
    } catch (e) {
      emit(ProfileError("Update failed: ${e.toString()}"));
    }
  }

  /// تسجيل الخروج
  Future<void> logout(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      await DioHelper.postData(
        url: '/logout',
        data: {},
        token: token,
      );

      await CachHelper.removeData(key: 'token'); // حذف التوكن
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) =>  LoginScreen()), // استبدل LoginScreen بواجهتك
            (route) => false, // إزالة كل الشاشات السابقة
      );
      emit(ProfileLoggedOut());
    } catch (e) {
      emit(ProfileError("Logout failed: ${e.toString()}"));
    }
  }
}
