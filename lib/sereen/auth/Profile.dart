import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String department;
  final String role;
  final int totalFollowUps;
  final String performanceBadge;

  ProfileScreen({
    this.name = "محمد العلي",
    this.email = "mohammad@example.com",
    this.department = "قسم التدريب",
    this.role = "مدرب",
    this.totalFollowUps = 18,
    this.performanceBadge = "🏅 الأفضل هذا الأسبوع",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("الملف الشخصي"),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // صورة + الاسم + الوظيفة
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user.png'), // ضع صورة رمزية هنا
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 20),

            // كرت معلومات عامة
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _infoRow("📧 البريد الإلكتروني", email, theme),
                  Divider(),
                  _infoRow("🏢 القسم", department, theme),
                  Divider(),
                  _infoRow("🔄 عدد المتابعات", "$totalFollowUps", theme),
                  Divider(),
                  _infoRow("⭐ الأداء", performanceBadge, theme),
                ],
              ),
            ),
            SizedBox(height: 30),

            // زر تسجيل الخروج
            ElevatedButton.icon(
              onPressed: () {
                // تنفيذ تسجيل الخروج
              },
              icon: Icon(Icons.logout),
              label: Text("تسجيل الخروج"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ],
    );
  }
}
