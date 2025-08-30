// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../../layout/TrainDrawer.dart';
// import 'DwonloadExcel.dart';
// import 'cubit/reports_cubit.dart';
//
// class TrainersReportsScreen extends StatelessWidget {
//   final String startDate;
//   final String endDate;
//
//   const TrainersReportsScreen({
//     super.key,
//     required this.startDate,
//     required this.endDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ReportsCubit()..getTrainersReport(startDate: startDate, endDate: endDate),
//       child: Scaffold(
//       appBar: AppBar(
//     title: const Text("Trainers Reports"),
//     actions: [
//     BlocBuilder<ReportsCubit, ReportsState>(
//     builder: (context, state) {
//     return IconButton(
//     icon: const Icon(Icons.download),
//     tooltip: "Export as Excel",
//     onPressed: state is ReportsSystemSuccess
//     ? () async {
//     await exportSystemReport(state.systemReport,"Trainers");
//     ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text("Report exported successfully!")),
//     );
//     }
//         : null,
//     );
//     },
//     ),
//
//     ],
//     ),
//         drawer: TrainDrawer(),
//         body: BlocBuilder<ReportsCubit, ReportsState>(
//           builder: (context, state) {
//             if (state is ReportsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ReportsTrainersSuccess) {
//               return _buildTrainersReport(context, state.trainersReport);
//             } else if (state is ReportsError) {
//               return Center(child: Text("Error: ${state.error}"));
//             }
//             return const Center(child: Text("No Data"));
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTrainersReport(BuildContext context, List<dynamic> trainers) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Text("Trainers Performance", style: Theme.of(context).textTheme.titleLarge),
//           const SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.7,
//             child: LineChart(
//               LineChartData(
//                 gridData: FlGridData(show: true),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: true, interval: 1),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (double value, meta) {
//                         int index = value.toInt();
//                         if (index < 0 || index >= trainers.length) return const SizedBox();
//                         return Text(trainers[index]["username"], style: const TextStyle(fontSize: 10));
//                       },
//                     ),
//                   ),
//                 ),
//                 borderData: FlBorderData(show: true),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: List.generate(trainers.length, (i) =>
//                         FlSpot(i.toDouble(), trainers[i]["opened_inquiries"].toDouble())),
//                     isCurved: true,
//                     color: Colors.orange,
//                     barWidth: 3,
//                     dotData: FlDotData(show: true),
//                   ),
//                   LineChartBarData(
//                     spots: List.generate(trainers.length, (i) =>
//                         FlSpot(i.toDouble(), trainers[i]["closed_inquiries"].toDouble())),
//                     isCurved: true,
//                     color: Colors.green,
//                     barWidth: 3,
//                     dotData: FlDotData(show: true),
//                   ),
//                   LineChartBarData(
//                     spots: List.generate(trainers.length, (i) =>
//                         FlSpot(i.toDouble(), trainers[i]["pending_inquiries"].toDouble())),
//                     isCurved: true,
//                     color: Colors.red,
//                     barWidth: 3,
//                     dotData: FlDotData(show: true),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.separated(
//               itemBuilder: (_, index) {
//                 final t = trainers[index];
//                 return Card(
//                   elevation: 2,
//                   child: ListTile(
//                     title: Text("${t["username"]}"),
//                     subtitle: Text(
//                       "Opened: ${t["opened_inquiries"]} | "
//                           "Closed: ${t["closed_inquiries"]} | "
//                           "Pending: ${t["pending_inquiries"]}",
//                     ),
//                     trailing: Text(
//                       "Avg: ${t["avg_closing_hours"] ?? "-"}",
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (_, __) => const SizedBox(height: 8),
//               itemCount: trainers.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/TrainDrawer.dart';
import '../../shared/components/AppColors.dart';
import 'DwonloadExcel.dart';
import 'cubit/reports_cubit.dart';
import 'cubit/reports_state.dart';

class TrainersReportsScreen extends StatelessWidget {
  final String startDate;
  final String endDate;

  const TrainersReportsScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsCubit()
        ..getTrainersReport(startDate: startDate, endDate: endDate),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Trainers Reports"),
          actions: [
            BlocBuilder<ReportsCubit, ReportsState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.download),
                  tooltip: "Export Trainers Report",
                  onPressed: () async {
                    try {
                      await ReportsCubit.of(context).downloadReport(
                          url: "/reports/trainerExcel",
                        data: {"start_date": startDate, "end_date": endDate}, defaultFileName: "trainers.xlsx",
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Report exported successfully!")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed: $e")),
                      );
                    }
                  },
                );
              },
            )


          ],
        ),
        drawer: TrainDrawer(),
        body: BlocBuilder<ReportsCubit, ReportsState>(
          builder: (context, state) {
            if (state is ReportsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportsTrainersSuccess) {
              return _buildTrainersReport(context, state.trainersReport);
            } else if (state is ReportsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No Data"));
          },
        ),
      ),
    );
  }

  Widget _buildTrainersReport(
      BuildContext context, List<dynamic> trainers) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) {
        final t = trainers[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // ✅ أيقونة المدرب
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blue.withOpacity(0.15),
                child: const Icon(Icons.person,
                    size: 30, color: AppColor.primaryBlue),
              ),
              const SizedBox(width: 14),
              // ✅ بيانات المدرب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${t["username"]}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _statChip("Opened", t["opened_inquiries"], Colors.orange),
                        const SizedBox(width: 6),
                        _statChip("Closed", t["closed_inquiries"], Colors.green),
                        const SizedBox(width: 6),
                        _statChip("Pending", t["pending_inquiries"], Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              // ✅ متوسط الإغلاق
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Avg Closing",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                  Text(
                    "${t["avg_closing_hours"] ?? "-"} h",
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: trainers.length,
    );
  }

  Widget _statChip(String label, dynamic value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w500, color: color),
      ),
    );
  }
}
