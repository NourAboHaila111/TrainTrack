import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:triantrak/sereen/Replay/View%20Follow-ups.dart';
import 'package:triantrak/sereen/Replay/cubit/followUp/dart/follow_up_cubit.dart';
import 'package:triantrak/sereen/Replay/cubit/replay_inquiry_cubit.dart';
import 'package:triantrak/sereen/Reporte/cubit/reports_cubit.dart';
import 'package:triantrak/sereen/auth/login/cubit/cubit.dart';
import 'package:triantrak/sereen/auth/profile/cubit/ProfileCubit.dart';
import 'package:triantrak/sereen/home/Favourite/FavouriteCubit.dart';
import 'package:triantrak/sereen/home/HomeScreen.dart';

import 'package:triantrak/sereen/auth/login/login.dart';
import 'package:triantrak/sereen/home/InquiriesView.dart';
import 'package:triantrak/sereen/home/cubit/HomeCubit.dart';
import 'package:triantrak/sereen/home/cubit/SearchCubit.dart';
import 'package:triantrak/shared/network/local/Cach_helper.dart';
import 'package:triantrak/shared/network/remote/dio_helper.dart';

import 'layout/AppThemes.dart';
import 'layout/cubit/theme_cubit.dart';
import 'notifications/NotificationService.dart';
import 'notifications/notifications_cubit.dart';
import 'sereen/Reporte/ReportsScreem.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CachHelper.init();
  final themeCubit = ThemeCubit();
  themeCubit.loadTheme();

  DioHelper.init();
  //CachHelper.init();
  /// ✅ استدعاء NotificationService مرة واحدة فقط عند تشغيل التطبيق
  NotificationService().init();
   // 🟡 لازم قبل أي استدعاء

  final token = CachHelper.getData(key: 'token');

  Widget startWidget;
  if (token != null) {
    startWidget = HomeScreen(role: CachHelper.getData(key: 'role'));
  } else {
    startWidget = LoginScreen();
  }

  runApp(MyApp(startWidget: startWidget));
}


class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => FollowUpCubit()),
        BlocProvider(create: (context) => ReplayInquiryCubit()),
        BlocProvider(create: (context) => SearchInquiryCubit()),
        BlocProvider(create: (context) => ReportsCubit()),
        BlocProvider(create: (context) => FavouriteCubit()),
        BlocProvider(create: (context) => NotificationsCubit()..getMyNotifications()),
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
        BlocProvider(
          create: (context) => InquiriesCubit()
            ..fetchInquiries(token: CachHelper.getData(key: 'token')),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TrainTrack',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}


