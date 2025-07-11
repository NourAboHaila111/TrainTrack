
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/sereen/Replay/cubit/replay_inquiry_cubit.dart';
import 'package:triantrak/sereen/auth/login/cubit/cubit.dart';
import 'package:triantrak/sereen/home/HomeScreen.dart';

import 'package:triantrak/sereen/auth/login/login.dart';
import 'package:triantrak/sereen/home/InquiriesView.dart';
import 'package:triantrak/sereen/home/cubit/HomeCubit.dart';
import 'package:triantrak/sereen/home/cubit/SearchCubit.dart';
import 'package:triantrak/shared/network/local/Cach_helper.dart';
import 'package:triantrak/shared/network/remote/dio_helper.dart';


import 'layout/AppThemes.dart';
import 'layout/cubit/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

   CachHelper.init();  // <--- مهم جداً
  final themeCubit = ThemeCubit();
   themeCubit.loadTheme();

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
        BlocProvider(create:(context) => LoginCubit(),),
        BlocProvider(create:(context) => ReplayInquiryCubit()),
        BlocProvider(create:(context) => SearchInquiryCubit()),
        BlocProvider(create:(context) => ThemeCubit()..loadTheme()),
        BlocProvider(create:(context) => InquiriesCubit()..fetchInquiries(token: CachHelper.getData(key: 'token'))),




        // BlocProvider(create: (context) => DetailsCubit(),)

      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
    builder: (context, themeMode) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TrainTrack',
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    themeMode: themeMode, // هذا السطر الآن صحيح
    home:LoginScreen(),
    );
    },
    ),);
  }
}


