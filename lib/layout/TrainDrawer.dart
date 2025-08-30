import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../sereen/Reporte/ReportsScreem.dart';
import '../../sereen/home/HomeScreen.dart';
import '../sereen/auth/profile/Profile.dart';
import '../sereen/auth/profile/cubit/ProfileCubit.dart';
import '../shared/components/AppColors.dart';
import 'cubit/theme_cubit.dart';


class TrainDrawer extends StatelessWidget {
  const TrainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.primaryYellow),
            child: Image.asset('assets/images/logo-2.png', width: 250, height: 100),
          ),
          _drawerItem(context, Icons.home, 'Home', () => navigateTo(context, HomeScreen(role: 'Trainer'))),
          _drawerItem(context, Icons.question_answer_outlined, 'Inquiries', () => navigateTo(context, HomeScreen(role: 'Trainer'))),
          _drawerItem(context, Icons.person, 'Profile', () => navigateTo(context, ProfileScreen())),
          _drawerItem(context, Icons.person, 'Reports', () => navigateTo(context, ReportsFilterScreen())),
          SwitchListTile(
            title: Text("Dark Theme", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            value: ThemeCubit.get(context).state == ThemeMode.dark,
            onChanged: (_) => ThemeCubit.get(context).toggleTheme(),
            secondary: Icon(Icons.brightness_6),
          ),
          // _drawerItem(
          //   context,
          //   Icons.logout_outlined,
          //   'Logout',
          //       () {
          //     ProfileCubit.get(context).logout(context); // استدعاء التابع مباشرة
          //   },
          // ),

        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
      onTap: onTap,
    );
  }
}
