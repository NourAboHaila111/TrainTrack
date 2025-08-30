
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import 'package:triantrak/sereen/Reporte/system_reports_screen.dart';
import 'package:triantrak/sereen/Reporte/trainers_reports_screen.dart';
import 'package:triantrak/shared/components/AppColors.dart';
import 'PersonalReportsScreen.dart';

class ReportsFilterScreen extends StatefulWidget {
  @override
  _ReportsFilterScreenState createState() => _ReportsFilterScreenState();
}

class _ReportsFilterScreenState extends State<ReportsFilterScreen> {
  DateTime? startDate;
  DateTime? endDate;
  final dateFormat = DateFormat("yyyy-MM-dd");

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initialDate = isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now());
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (newDate != null) {
      setState(() {
        if (isStart) {
          startDate = newDate;
        } else {
          endDate = newDate;
        }
      });
    }
  }

  void _navigateToReports(BuildContext context, int tabIndex) {
    if (startDate == null || endDate == null) {
      _showSnackBar("⚠️ Please select both start and end dates", Colors.orange);
      return;
    }

    if (startDate!.isAfter(endDate!)) {
      _showSnackBar("❌ Start date cannot be after end date", Colors.red);
      return;
    }

    final start = dateFormat.format(startDate!);
    final end = dateFormat.format(endDate!);

    Widget targetScreen;
    if (tabIndex == 0) {
      targetScreen = SystemReportsScreen(startDate: start, endDate: end);
    } else if (tabIndex == 1) {
      targetScreen = TrainersReportsScreen(startDate: start, endDate: end);
    } else {
      targetScreen = PersonalReportsScreen(startDate: start, endDate: end);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => targetScreen),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TrainDrawer(),
      appBar: AppBar(
        title: const Text("Reports"),
        elevation: 0,
        backgroundColor: AppColor.primaryYellow,
      ),
      body: Stack(
        children: [
          // الخلفية
          Opacity(
            opacity: 0.7, // نسبة الشفافية (يمكن تعديلها)
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/chart.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // المحتوى فوق الخلفية
          Padding(
            padding: const EdgeInsets.all(80),
            child: Column(
              children: [
                _dateCard(
                  title: "Start Date",
                  date: startDate,
                  onTap: () => _pickDate(context, true),
                  icon: Icons.calendar_month,
                  color: AppColor.primaryYellow,
                ),
                const SizedBox(height: 20),
                _dateCard(
                  title: "End Date",
                  date: endDate,
                  onTap: () => _pickDate(context, false),
                  icon: Icons.event,
                  color: AppColor.primaryBlue,
                ),
                const SizedBox(height: 40),

                // الأزرار
                _reportButton("View System Reports", Icons.bar_chart, AppColor.primaryBlue, () => _navigateToReports(context, 0)),
                const SizedBox(height: 16),
                _reportButton("View Trainers Reports", Icons.people, AppColor.primaryBlue, () => _navigateToReports(context, 1)),
                const SizedBox(height: 16),
                _reportButton("View Personal Report", Icons.person, AppColor.primaryBlue, () => _navigateToReports(context, 2)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _dateCard({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$title: ${date != null ? dateFormat.format(date) : "Not selected"}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.edit_calendar, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _reportButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 4,
        ),
      ),
    );
  }
}
