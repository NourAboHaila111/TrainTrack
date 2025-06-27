import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../shared/components/AppColors.dart';
import '../../../shared/components/components.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'ResetPassword.dart';

class CheckCodeScreen extends StatelessWidget {
  final String email;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

   CheckCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: LoginCubit.get(context),
      child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is CheckCodeSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );

            } else if (state is CheckCodeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Verify Code"),
              backgroundColor: AppColor.primaryYellow,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(height: 150),
                    OtpTextField(

                      numberOfFields: 5,
                      borderColor: AppColor.primaryBlue,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {
                        // في حال تغيّر الكود
                      },
                      onSubmit: (String code) {
                        print("Code is $code");
                        LoginCubit.get(context).checkForgetCode(
                          email: email,
                          code: code.trim(),
                        );
                        navigateTo(context,ResetPasswordScreen (email: email,code: code.trim()));
                      },
                    ),
                    SizedBox(height: 70),
                    state is CheckCodeLoading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                          child: ElevatedButton(
                                                onPressed: () {

                            LoginCubit.get(context).checkForgetCode(
                              email: email,
                              code: codeController.text.trim(),
                            );
                          }
                                                ,
                                                style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryBlue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                ),
                                                child: Text("ReSent", style: TextStyle(fontSize: 18,color: Colors.white)),
                                              ),
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
