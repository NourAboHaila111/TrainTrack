
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/sereen/auth/login/cubit/cubit.dart';
import 'package:triantrak/sereen/home/HomeScreen.dart';

import 'package:triantrak/sereen/auth/login/login.dart';
import 'package:triantrak/shared/network/local/Cach_helper.dart';
import 'package:triantrak/shared/network/remote/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

   CachHelper.init();  // <--- مهم جداً

  DioHelper.init();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
 /// Widget StartWidget = LoginScreen();

  MyApp();



  // Locale _locale = new Locale('en','US');
  //
  // void _changeLanguage(Locale locale){
  //   _locale = locale;
  //
  // }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => LoginCubit(),)

        // BlocProvider(create: (context) => DetailsCubit(),)

      ],
      child: MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'TrainTrack',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a blue toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
              useMaterial3: true,
            ),
            home:  LoginScreen()
          // Test(changeLanguage:(p0) => Locale("en","")),
        ) ,

    );
  }
}


