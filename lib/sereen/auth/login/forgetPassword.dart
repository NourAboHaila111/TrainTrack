import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import 'check_forget_code.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
          );
          // الانتقال إلى واجهة التحقق بعد إرسال الكود بنجاح
          navigateTo(context, CheckCodeScreen (email: emailController.text.trim()));
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Forgot Password')),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'Enter your email address to receive a verification code.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  prefix: Icons.email,
                ),
                const SizedBox(height: 24),
                state is LoginLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    cubit.forgetPassword(email: emailController.text.trim(), context: context);
                  },
                  child: const Text("Send Code"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
