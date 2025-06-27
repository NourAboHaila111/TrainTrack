//
//
//
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:triantrak/shared/components/AppColors.dart';
//
// import '../../shared/components/components.dart';
// import '../home/HomeScreen.dart';
// import 'cubit/cubit.dart';
// import 'cubit/state.dart';
//
// class LoginScreen extends StatelessWidget {
//
//   late var EmailController=TextEditingController();
//   late var PasswordController=TextEditingController();
//   var formKey=GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoginCubit(),
//       child: BlocConsumer<LoginCubit,LoginState>(
//         listener: (context, state){
//           // if(state is LoginSuccessState)
//           // {
//           //   if(state.loginModel!.status! && state.loginModel!.status!=null)
//           //   {
//           //     print(state.loginModel!.message);
//           //     // print(state.loginModel!.data!.token);
//           //     // token = state.loginModel!.data!.token;
//           //     CachHelper.SaveData(
//           //       key: 'token',
//           //       value: state.loginModel!.accessToken,
//           //     ).then((value) async{
//           //       ScaffoldMessenger.of(context).showSnackBar(
//           //         defaultSnackbar(
//           //             text: state.loginModel!.message!,
//           //             state: stateColor.SUCCESS),
//           //       );
//           //       token=state.loginModel!.accessToken;
//           //       ProfileCubit.get(context).setUserInfo(state.loginModel!.user!.nameEn,state.loginModel!.user!.nameAr,state.loginModel!.user!.image,state.loginModel!.user!.email,state.loginModel!.user!.id,state.loginModel!.user!.fcmToken);
//           //       print("myToken:"+token.toString());
//           //
//           //       //String fcm_token=CachHelper.getData(key: 'fcm_token');
//           //       // print(fcm_token);
//           //       await FirebaseApi.initNotifications();
//           //       // FirebaseApi.listenToMessages();
//           //
//           //       return navigateTo(context, PetopiaLayout());
//           //     });
//           //
//           //
//           //     // print(token);
//           //
//           //   }else if(state.loginModel!.message=='صيغة البريد الإلكتروني غير صحيحة' || state.loginModel!.message=='الباسوورد خاطئ' )
//           //   {
//           //     ScaffoldMessenger.of(context).showSnackBar(
//           //         defaultSnackbar(
//           //             text: state.loginModel!.message!,
//           //             state: stateColor.WARNING)
//           //     );
//           //   }else
//           //     ScaffoldMessenger.of(context).showSnackBar(
//           //         defaultSnackbar(
//           //             text: state.loginModel!.message!,
//           //             state: stateColor.ERROR)
//           //     );
//           // }
//         },
//         builder: (context, state) => Scaffold(
//           backgroundColor: AppColor.primaryYellow,
//           body:Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                   key: formKey,
//                   child: Center(
//                     child: Column(
//
//
//                       children: [
//                         SizedBox(height: 30,),
//                         // TweenAnimationBuilder(
//                         //   duration: const Duration(seconds: 1),
//                         //   tween: Tween(begin: 0.0, end: 1.0),
//                         //   builder: (context, value, child) {
//                         //     return Transform(
//                         //       transform: Matrix4.identity()
//                         //         ..scale(value) // تكبير
//                         //         ..rotateZ(value * 0.05), // دوران بسيط
//                         //       child: Opacity(
//                         //         opacity: value,
//                         //         child: Text(
//                         //           "Welcome to TrainTrack",
//                         //           style: TextStyle(
//                         //             fontSize: 28,
//                         //             fontWeight: FontWeight.bold,
//                         //             color: AppColor.primaryWhait,
//                         //             shadows: [
//                         //             Shadow(
//                         //             blurRadius: 10,
//                         //             color: Colors.blue,
//                         //             offset: Offset(0, 0),)
//                         //             ],
//                         //           ),
//                         //           textAlign: TextAlign.center,
//                         //         ),
//                         //       ),
//                         //     );
//                         //   },
//                         // ),
//                         Text(
//                           "Welcome to TrainTrack",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.primaryWhait,
//                           ),
//                           textAlign: TextAlign.center,
//                         )
//                             .animate()
//                             .fadeIn()
//                             .scaleXY(end: 1.1, begin: 0.8) // تكبير طفيف
//                             .moveY(begin: 30, curve: Curves.easeOutBack),
//
//                         SizedBox(height: 30,),
//
//                         Container(
//                           height: 700,
//                           width: 500, // يمكنك تغييره حسب الحاجة
//                           padding: EdgeInsets.all(30),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                               color: AppColor.primaryBlue, // اللون الأصفر المطلوب
//                               width: 3,
//                             ),
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 10,
//                                 offset: Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                             Column(
//                             children: [
//                             ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image.asset(
//                               'assets/images/logo-2.png',
//                               width: 220,
//                               height: 160,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                      // SizedBox(height: 10),
//
//                       ],
//                     ),
//
//                                 // Image.asset(
//                                 //   'assets/images/logo-2.png',
//                                 //   width: 300,
//                                 //   height: 150,
//                                 //   fit: BoxFit.contain,
//                                 // ),
//                                 SizedBox(height: 60),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Sigin:",textAlign: TextAlign.start,),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: 10),
//                                 defaultFormField(
//                                   controller: EmailController,
//                                   type: TextInputType.text,
//                                   validate: (value) {
//                                     if (value!.isEmpty) return 'please enter email address';
//                                     return null;
//                                   },
//                                   label: 'Email',
//                                   prefix: Icons.email,
//                                 ),
//                                 SizedBox(height: 30),
//
//                                 defaultFormField(
//                                   controller: PasswordController,
//                                   type: TextInputType.visiblePassword,
//                                   validate: (value) {
//                                     if (value!.isEmpty) return 'password is too short';
//                                     return null;
//                                   },
//                                   onsubmit: (value) {
//                                     // تنفيذ تسجيل الدخول
//                                   },
//                                   label: 'Password',
//                                   prefix: Icons.lock_clock_outlined,
//                                   suffix: LoginCubit.get(context).Suffix,
//                                   obscuretext: LoginCubit.get(context).isPassword,
//                                   suffixpressed: () {
//                                     // تغيير حالة إظهار كلمة المرور
//                                   },
//                                 ),
//                                 //SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     defaultTextButton(
//                                       textcolor:Colors.grey,
//                                       function: () {
//                                         navigateTo(context, HomeScreen());
//                                       },
//                                       text: 'Forget password',
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 60),
//                                 ConditionalBuilder(
//                                   condition: state is! LoginLoadingState,
//                                   builder: (context) => defaultButton(
//                                     BackGround: AppColor.primaryBlue,
//                                     width: 150,
//                                     function: () {
//     if(formKey.currentState!.validate()){
//     LoginCubit.get(context).userLogin(email: EmailController.text, password: PasswordController.text);
//
//     }
//     },
//
//
//                                     text: 'singin',
//
//                                   ),
//                                   fallback: (context) => Center(child: CircularProgressIndicator()),
//
//                                 ),
//
//                                 SizedBox(height: 30),
//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.center,
//                                 //   children: [
//                                 //     defaultTextButton(
//                                 //       textcolor: AppColor.primaryBlue,
//                                 //       function: () {
//                                 //         navigateTo(context, HomeScreen());
//                                 //       },
//                                 //       text: 'forget password',
//                                 //     ),
//                                 //   ],
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                   ,
//                 ),
//               ),
//             ),
//           ) ,
//         ),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(role: role,)));
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.primaryWhait,
            body: Stack(

              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/back1.jpg', // 🟡 غيّر إلى مسار صورتك
                    fit: BoxFit.cover,              // لتملأ الشاشة بالكامل
                  ),
                ),
                SingleChildScrollView(

                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          "Welcome to TrainTrack",
                          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
                        ),
                      ),
                     // Image.asset('assets/images/logo-2.png', width: 150, height: 120),

                      Container(
                        height: 750,
                        width: 450,

                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: AppColor.mybabyellow,
                          border: Border.all(color: AppColor.primaryYellow, width: 3),
                          borderRadius: BorderRadius.only(
                            //bottomLeft: Radius.circular(970),
                            topLeft: Radius.circular(270),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                               Image.asset('assets/images/logo-2.png', width: 300, height: 120),
                              // SizedBox(height: 10),
                              // Text(
                              //   "Welcome to TrainTrack",
                              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.primaryBlue),
                              // ),
                              SizedBox(height:5/0 ),
                              Container(
                                width: double.infinity,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   // Image.asset('assets/images/petopia.png'),
                                    Text(
                                      '   LOGIN:',
                                      // style: Theme.of(context).textTheme.headline3
                                    ),
                                    Text(
                                      '   login now to browse our hot offers',
                                      // style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      //     color: Colors.grey
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // defaultFormField(
                              //   controller: emailController,
                              //   type: TextInputType.emailAddress,
                              //   label: 'Email',
                              //   prefix: Icons.email_outlined,
                              //   validate: (_) => null,
                              // ),
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate:(value){
                                  if (value!.isEmpty)
                                    return 'please enter email adress';
                                },
                                label: 'Email',
                                prefix: Icons.email,
                              ),
                              SizedBox(height: 20),
                              // defaultFormField(
                              //   controller: passwordController,
                              //   type: TextInputType.visiblePassword,
                              //   label: 'Password',
                              //   prefix: Icons.lock_outline,
                              //   validate: (_) => null,
                              //   obscuretext: true,
                              // ),
                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
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
                                          if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );}
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                                ),
                                child: Text("Login", style: TextStyle(fontSize: 18,color: Colors.white)),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
