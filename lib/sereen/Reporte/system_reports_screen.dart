
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:triantrak/shared/components/AppColors.dart';

import 'cubit/reports_cubit.dart';
import '../../layout/TrainDrawer.dart';
import 'cubit/reports_state.dart';

class SystemReportsScreen extends StatelessWidget {
  final String startDate;
  final String endDate;

  const SystemReportsScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsCubit()
        ..getSystemReport(startDate: startDate, endDate: endDate),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("System Reports"),
          actions: [
              BlocBuilder<ReportsCubit, ReportsState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(Icons.download),
                    tooltip: "Export as Excel",
                    onPressed: state is ReportsSystemSuccess
                        ? () async {
                      await exportSystemReport(state.systemReport);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Report exported successfully!")),
                      );
                    }
                        : null,
                  );
                },
              ),

          ],
        ),
        drawer: TrainDrawer(),
        body: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportsSystemSuccess) {
              return _buildSystemReport(context, state.systemReport);
            } else if (state is ReportsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No Data"));
          },
        ),
      ),
    );
  }


  Widget _buildSystemReport(BuildContext context, Map<String, dynamic> report) {
    final open = report["opened_inquiries_count"] ?? 0;
    final closed = report["closed_inquiries_count"] ?? 0;
    final pending = report["pending_inquiries_count"] ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 16,
            children: [
              _statCard("Users", report["users_count"], Colors.blue),
              _statCard("Active Users", report["active_users_count"], Colors.teal),
              _statCard("Trainers", report["trainers_count"], Colors.green),
              _statCard("Active Trainers", report["active_trainers_count"], Colors.lightGreen),
              _statCard("Sections", report["sections_count"], Colors.orange),
              _statCard("Categories", report["categories_count"], Colors.deepOrange),
              _statCard("Inquiries", report["inquiries_count"], Colors.purple),
              _statCard("Reopened", report["reopened_inquiries_count"], Colors.blue),
              _statCard("Closed", closed, Colors.red),
              _statCard("Open", open, Colors.yellow.shade700),
              _statCard("Pending", pending, Colors.indigo),

            ],
          ),
          const SizedBox(height: 24),
          Text("Avg Closing: ${report["avg_closing"]}",
              style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ✅ جزء التوضيح (Legend)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(Colors.yellow.shade700, "Open ($open)"),
                  _buildLegendItem(Colors.red, "Closed ($closed)"),
                  _buildLegendItem(AppColor.primaryBlue, "Pending ($pending)"),
                ],
              ),

              // ✅ المخطط مع حجم محدد
              SizedBox(
                width: 180,  // حدد عرض مناسب
                height: 180,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 40,
                    sectionsSpace: 4,
                    sections: [
                      PieChartSectionData(
                        value: open.toDouble(),
                        color: Colors.yellow.shade700,
                        title: "",
                      ),
                      PieChartSectionData(
                        value: closed.toDouble(),
                        color: Colors.red,
                        title: "",
                      ),
                      PieChartSectionData(
                        value: pending.toDouble(),
                        color: AppColor.primaryBlue,
                        title: "",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  /// 🟦 كارت إحصائي
  Widget _statCard(String title, dynamic count, Color color) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 6),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }

  /// 📂 دالة حفظ ملف Excel
  Future<void> exportSystemReport(Map<String, dynamic> report) async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['System Report'] ?? excel['Sheet1']!;

    sheet.appendRow([
      TextCellValue("Metric"),
      TextCellValue("Value"),
    ]);

    report.forEach((key, value) {
      sheet.appendRow([
        TextCellValue(key.toString()),
        TextCellValue(value.toString()),
      ]);
    });

    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/system_report.xlsx";
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    XFile xfile = XFile(filePath);
    await Share.shareXFiles([xfile], text: 'System Report');
  }
}
