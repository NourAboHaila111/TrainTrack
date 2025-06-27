import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/AppColors.dart';
import '../../../shared/components/components.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'login.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String code;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ResetPasswordScreen({required this.email, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: LoginCubit.get(context),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
              navigateTo(context, LoginScreen());
            } else if (state is CheckCodeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Reset Password"),
              backgroundColor: AppColor.primaryYellow,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: 'New Password',
                      obscuretext: true,
                      validate: (value) {
                        if (value!.isEmpty) return 'Enter new password';
                        if (value.length < 6) return 'At least 6 characters';
                        return null;
                      },   prefix: Icons.lock_outline,
                    ),
                    SizedBox(height: 20),
                    defaultFormField(
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      label: 'Confirm Password',
                      obscuretext: true,
                      validate: (value) {
                        if (value!.isEmpty) return 'Enter confirmation password';
                        if (value != passwordController.text) return 'Passwords do not match';
                        return null;
                      },   prefix: Icons.lock_outline,
                    ),
                    SizedBox(height: 30),
                    state is ResetPasswordLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).resetPassword(
                            email: email,

                            password: passwordController.text.trim(),
                            confirmPassword: confirmPasswordController.text.trim(), code: code, context:context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryBlue,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text("Reset", style: TextStyle(fontSize: 18,color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
