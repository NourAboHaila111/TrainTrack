//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../shared/components/AppColors.dart';
// import '../../../../shared/components/components.dart';
// import '../../../shared/network/local/Cach_helper.dart';
// import '../../home/HomeScreen.dart';
// import 'cubit/cubit.dart';
// import 'cubit/state.dart';
// import 'forgetPassword.dart';
//
//
//
// class LoginScreen extends StatelessWidget {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginSuccess) {
//             final role = CachHelper.getData(key: 'role');
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => HomeScreen(role: role)),
//                   (route) => false, // هذا يمنع الرجوع لأي شاشة سابقة
//             );
//
//           } else if (state is LoginFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           final cubit = LoginCubit.get(context);
//
//           return Scaffold(
//             backgroundColor: AppColor.primaryYellow,
//             body: Stack(
//
//               children: [
//                 // Positioned.fill(
//                 //   child: Image.asset(
//                 //     'assets/images/back1.jpg', // 🟡 غيّر إلى مسار صورتك
//                 //     fit: BoxFit.cover,              // لتملأ الشاشة بالكامل
//                 //   ),
//                 // ),
//                 SingleChildScrollView(
//
//                   child: Column(
//                     crossAxisAlignment:CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.all(32.0),
//                         child: Text(
//                           "Welcome to TrainTrack",
//                           style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
//                         ),
//                       ),
//                      // Image.asset('assets/images/logo-2.png', width: 150, height: 120),
//
//                       // Padding(
//                       //   padding: const EdgeInsets.only(right: 200),
//                       //   child: Image.asset('assets/images/logo-2.png', width: 300, height: 120),
//                       // ),
//                       // // SizedBox(height: 10),
//                       // // Text(
//                       // //   "Welcome to TrainTrack",
//                       // //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
//                       // // ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 200),
//                         child: Image.asset('assets/images/logo-2.png', width: 300, height: 120),
//                       ),
//                       // SizedBox(height: 10),
//                       // Text(
//                       //   "Welcome to TrainTrack",
//                       //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
//                       // ),
//                       SizedBox(height: 10),
//                       Container(
//                         height: 700,
//                         width: 450,
//
//                         padding: EdgeInsets.all(25),
//                         decoration: BoxDecoration(
//                           color: AppColor.mybabyellow,
//                           border: Border.all(color: AppColor.primaryYellow, width: 3),
//                           borderRadius: BorderRadius.only(
//                             //bottomLeft: Radius.circular(970),
//                             topLeft: Radius.circular(200),
//                           ),
//                           boxShadow: [
//                             BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
//                           ],
//                         ),
//                         child: Form(
//                           key: formKey,
//                           child: Column(
//                             children: [
//                               // SizedBox(height: 50),
//                               //  Image.asset('assets/images/logo-2.png', width: 300, height: 120),
//                               // // SizedBox(height: 10),
//                               // // Text(
//                               // //   "Welcome to TrainTrack",
//                               // //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
//                               // // ),
//                               SizedBox(height:100 ),
//                               Container(
//                                 width: double.infinity,
//                                 child: Column(
//
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                    // Image.asset('assets/images/petopia.png'),
//                                     Text(
//                                       '   LOGIN:',
//                                     style:   TextStyle(
//                                           color: Colors.grey
//                                       ),
//                                        //style: Theme.of(context).textTheme.headline3
//                                     ),
//                                     Text(
//                                       '   login now to browse our hot offers',
//                                       style: TextStyle(
//                                          color: Colors.grey
//                                        ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                               // defaultFormField(
//                               //   controller: emailController,
//                               //   type: TextInputType.emailAddress,
//                               //   label: 'Email',
//                               //   prefix: Icons.email_outlined,
//                               //   validate: (_) => null,
//                               // ),
//                               defaultFormField(
//                                 controller: emailController,
//                                 type: TextInputType.emailAddress,
//                                 validate:(value){
//                                   if (value!.isEmpty)
//                                     return 'please enter email adress';
//                                 },
//                                 label: 'Email',
//                                 prefix: Icons.email,
//                               ),
//                               SizedBox(height: 20),
//                               // defaultFormField(
//                               //   controller: passwordController,
//                               //   type: TextInputType.visiblePassword,
//                               //   label: 'Password',
//                               //   prefix: Icons.lock_outline,
//                               //   validate: (_) => null,
//                               //   obscuretext: true,
//                               // ),
//                               defaultFormField(
//                                 controller: passwordController,
//                                 type: TextInputType.visiblePassword,
//                                 validate: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Password is required';
//                                   } else if (value.length < 6) {
//                                     return 'Password must be at least 6 characters';
//                                   }
//                                   return null;
//                                 },
//                                 onsubmit: (value) {
//                                   LoginCubit.get(context).userLogin(
//                                     email: emailController.text.trim(),
//                                     password: passwordController.text.trim(),
//                                   );
//                                 },
//                                 label: 'Password',
//                                 prefix: Icons.lock_clock_outlined,
//                                 suffix: cubit.suffix,
//                                 obscuretext: cubit.isPasswordVisible,
//                                 suffixpressed: () {
//                                   cubit.changePasswordVisibility();
//                                 },
//                               ),
//
//                               SizedBox(height: 50),
//                               state is LoginLoading
//                                   ? CircularProgressIndicator()
//                                   : ElevatedButton(
//                                 onPressed: () {
//                                           if(formKey.currentState!.validate()){
//                                   cubit.userLogin(
//                                     email: emailController.text.trim(),
//                                     password: passwordController.text.trim(),
//                                   );}
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColor.primaryBlue,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                                   padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
//                                 ),
//                                 child: Text("Login", style: TextStyle(fontSize: 18,color: Colors.white)),
//                               ),
//                               SizedBox(height: 15),
//                               TextButton(
//                                 onPressed: () {
//                                   navigateTo(context, ForgetPasswordScreen());
//                                   },
//                                 child: Text(
//                                   "Forgot password?",
//                                   style: TextStyle(color: AppColor.primaryBlue),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/AppColors.dart';
import '../../../../shared/components/components.dart';
import '../../../shared/network/local/Cach_helper.dart';
import '../../home/HomeScreen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'forgetPassword.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            final role = CachHelper.getData(key: 'role');
            // ✅ الانتقال لشاشة HomeScreen وإزالة كل الشاشات السابقة
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(role: role)),
                  (route) => false,
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.primaryYellow,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      "Welcome to TrainTrack",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryBlue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: Image.asset('assets/images/logo-2.png', width: 300, height: 120),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 700,
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColor.mybabyellow,
                      border: Border.all(color: AppColor.primaryYellow, width: 3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) return 'please enter email address';
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email,
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value == null || value.isEmpty) return 'Password is required';
                              if (value.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                            onsubmit: (value) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            },
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                            suffix: cubit.suffix,
                            obscuretext: cubit.isPasswordVisible,
                            suffixpressed: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                          SizedBox(height: 50),
                          state is LoginLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryBlue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                            ),
                            child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, ForgetPasswordScreen());
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: AppColor.primaryBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
