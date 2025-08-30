import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import '../../../shared/components/AppColors.dart';
import 'cubit/ProfileCubit.dart';
import 'cubit/ProfileState.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..fetchProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is ProfileLoggedOut) {
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ProfileLoaded) {
            final user = state.profile;
            return Scaffold(
              drawer: TrainDrawer(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                title: const Text("My Profile"),
                elevation: 0,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // صورة شخصية
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: AppColor.primaryBlue.withOpacity(0.2),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/images/avatar.jpg"),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // الاسم و الدور
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.roleId == 2 ? "Trainer" : "Employee",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        // وسام الأداء
                        _badgeCard("🏆 Best Performer of the Week"),
                        const SizedBox(height: 20),

                        // بيانات البروفايل
                        _infoTile(Icons.email, "Email", user.email),
                        //_infoTile(Icons.apartment, "Department ID", user.sectionId.toString()),
                        //_infoTile(Icons.badge, "User ID", user.id.toString()),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // أزرار أسفل
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _showUpdateDialog(context, user.name);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Update Profile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          ProfileCubit.get(context).logout(context); // تمرير الـ context
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Log Out"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text("No data available.")),
            );
          }
        },
      ),
    );
  }

  /// تعديل البروفايل Dialog
  void _showUpdateDialog(BuildContext context, String currentName) {
    final nameCtrl = TextEditingController(text: currentName);
    final passCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            TextField(controller: confirmCtrl, decoration: const InputDecoration(labelText: "Confirm Password"), obscureText: true),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              ProfileCubit.get(context).updateProfile(
                name: nameCtrl.text,
                password: passCtrl.text.isNotEmpty ? passCtrl.text : null,
                confirmPassword: confirmCtrl.text.isNotEmpty ? confirmCtrl.text : null,
              );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  /// بطاقة بيانات فردية
  Widget _infoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColor.primaryBlue.withOpacity(0.1),
            child: Icon(icon, color: AppColor.primaryBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// بطاقة الأداء
  Widget _badgeCard(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade400, Colors.orange.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, color: Colors.white, size: 26),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
