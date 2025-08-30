// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:triantrak/layout/TrainDrawer.dart';
// import 'package:triantrak/shared/components/AppColors.dart';
// import '../../model/ReportPersonalModel.dart';
// import 'cubit/reports_cubit.dart';
// import 'cubit/reports_state.dart';
//
// class PersonalReportsScreen extends StatelessWidget {
//   final String startDate;
//   final String endDate;
//
//   const PersonalReportsScreen({
//     super.key,
//     required this.startDate,
//     required this.endDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ReportsCubit(),
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           drawer: TrainDrawer(),
//           appBar: AppBar(
//             title: const Text("My Reports"),
//             bottom: const TabBar(
//               indicatorColor: Colors.white,
//               tabs: [
//                 Tab(text: "Daily"),
//                 Tab(text: "Weekly"),
//                 Tab(text: "Monthly"),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               reportTab(
//                 context,
//
//                 apiUrl: "/reports/myDailyReport",
//                 excelUrl: "/reports/myDailyExcel",
//                 fileName: "daily_report.xlsx",
//                 data: {"start_date": startDate, "end_date": endDate},
//               ),
//               reportTab(
//                 context,
//
//                 apiUrl: "/reports/myWeeklyReport",
//                 excelUrl: "/reports/myWeeklyExcel",
//                 fileName: "weekly_report.xlsx",
//                 data: {"month": startDate.substring(0, 7)},
//               ),
//               reportTab(
//                 context,
//
//                 apiUrl: "/reports/myMonthlyReport",
//                 excelUrl: "/reports/myMonthlyExcel",
//                 fileName: "monthly_report.xlsx",
//                 data: {"year": startDate.substring(0, 4)},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget reportTab(
//       BuildContext context, {
//
//         required String apiUrl,
//         required String excelUrl,
//         required String fileName,
//         required Map<String, dynamic> data,
//       }) {
//     return BlocBuilder<ReportsCubit, ReportsState>(
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColor.primaryBlue),
//                             onPressed: () {
//                               ReportsCubit.of(context)
//                                   .getReport(url: apiUrl, data: data);
//                             },
//                             icon: const Icon(Icons.refresh),
//                             label: const Text("Load"),
//                           ),
//                           const SizedBox(width: 12),
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green.shade600),
//                             onPressed: () {
//                               ReportsCubit.of(context).downloadReport(
//                                 url: excelUrl,
//                                 data: data,
//                                 defaultFileName: fileName,
//                               );
//                             },
//                             icon: const Icon(Icons.download),
//                             label: const Text("Export Excel"),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       if (state is ReportsLoading)
//                         const Expanded(child: Center(child: CircularProgressIndicator()))
//                       else if (state is ReportsLoaded)
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // ✅ ملخص بالأرقام
//                                 Card(
//                                   color: Colors.blue.shade50,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12)),
//                                   margin: const EdgeInsets.symmetric(vertical: 8),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12),
//                                     child: Text(
//                                       "Summary → "
//                                           "Opened: ${state.reportDetails.fold(0, (s, e) => s + e.opened)} | "
//                                           "Closed: ${state.reportDetails.fold(0, (s, e) => s + e.closed)} | "
//                                           "Pending: ${state.reportDetails.fold(0, (s, e) => s + e.pending)} | "
//                                           "Reopened: ${state.reportDetails.fold(0, (s, e) => s + e.reopened)} | "
//                                           "Followups: ${state.reportDetails.fold(0, (s, e) => s + e.followups)}",
//                                       style:
//                                       const TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//
//                                 // ✅ الجدول
//                                 DataTable(
//                                   headingRowColor: MaterialStateProperty.resolveWith(
//                                           (states) => Colors.grey.shade200),
//                                   border: TableBorder.all(
//                                       color: Colors.grey.shade300, width: 1),
//                                   columns: const [
//                                     DataColumn(label: Text("Date")),
//                                     DataColumn(label: Text("Opened")),
//                                     DataColumn(label: Text("Closed")),
//                                     DataColumn(label: Text("Pending")),
//                                     DataColumn(label: Text("Reopened")),
//                                     DataColumn(label: Text("Followups")),
//                                   ],
//                                   rows: state.reportDetails.map((ReportModel e) {
//                                     return DataRow(cells: [
//                                       DataCell(Text(e.date)),
//                                       DataCell(Text(e.opened.toString(),
//                                           style: const TextStyle(color: Colors.blue))),
//                                       DataCell(Text(e.closed.toString(),
//                                           style:
//                                           const TextStyle(color: Colors.green))),
//                                       DataCell(Text(e.pending.toString(),
//                                           style:
//                                           const TextStyle(color: Colors.orange))),
//                                       DataCell(Text(e.reopened.toString(),
//                                           style: const TextStyle(color: Colors.red))),
//                                       DataCell(Text(e.followups.toString(),
//                                           style:
//                                           const TextStyle(color: Colors.purple))),
//                                     ]);
//                                   }).toList(),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       else if (state is ReportsError)
//                           Expanded(
//                             child: Center(
//                               child: Text(state.message,
//                                   style: const TextStyle(
//                                       color: Colors.red,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold)),
//                             ),
//                           )
//                         else
//                           const Expanded(
//                             child: Center(
//                                 child: Text("No data yet",
//                                     style: TextStyle(fontSize: 16))),
//                           ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import 'package:triantrak/shared/components/AppColors.dart';
import '../../model/ReportPersonalModel.dart';
import 'cubit/reports_cubit.dart';
import 'cubit/reports_state.dart';

class PersonalReportsScreen extends StatelessWidget {
  final String startDate;
  final String endDate;

  const PersonalReportsScreen({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsCubit(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: TrainDrawer(),
          appBar: AppBar(
            title: const Text("My Reports"),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Daily"),
                Tab(text: "Weekly"),
                Tab(text: "Monthly"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              reportTab(
                context,
                apiUrl: "/reports/myDailyReport",
                excelUrl: "/reports/myDailyExcel",
                fileName: "daily_report.xlsx",
                data: {"start_date": startDate, "end_date": endDate},
              ),
              reportTab(
                context,
                apiUrl: "/reports/myWeeklyReport",
                excelUrl: "/reports/myWeeklyExcel",
                fileName: "weekly_report.xlsx",
                data: {"month": startDate.substring(0, 7)},
              ),
              reportTab(
                context,
                apiUrl: "/reports/myMonthlyReport",
                excelUrl: "/reports/myMonthlyExcel",
                fileName: "monthly_report.xlsx",
                data: {"year": startDate.substring(0, 4)},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reportTab(
      BuildContext context, {
        required String apiUrl,
        required String excelUrl,
        required String fileName,
        required Map<String, dynamic> data,
      }) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ✅ أزرار التحكم
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryBlue),
                    onPressed: () {
                      ReportsCubit.of(context).getReport(url: apiUrl, data: data);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Load"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600),
                    onPressed: () {
                      ReportsCubit.of(context).downloadReport(
                        url: excelUrl,
                        data: data,
                        defaultFileName: fileName,
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Export Excel"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ✅ المحتوى (يتمدّد ويقبل تمرير بدون overflow)
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is ReportsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReportsLoaded) {
                      return ListView(
                        children: [
                          // ملخص
                          Card(
                            color: Colors.blue.shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                "Summary → "
                                    "Opened: ${state.reportDetails.fold(0, (s, e) => s + e.opened)} | "
                                    "Closed: ${state.reportDetails.fold(0, (s, e) => s + e.closed)} | "
                                    "Pending: ${state.reportDetails.fold(0, (s, e) => s + e.pending)} | "
                                    "Reopened: ${state.reportDetails.fold(0, (s, e) => s + e.reopened)} | "
                                    "Followups: ${state.reportDetails.fold(0, (s, e) => s + e.followups)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ),

                          // الجدول
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor:
                              MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey.shade200),
                              border: TableBorder.all(
                                  color: Colors.grey.shade300, width: 1),
                              columns: const [
                                DataColumn(label: Text("Date")),
                                DataColumn(label: Text("Opened")),
                                DataColumn(label: Text("Closed")),
                                DataColumn(label: Text("Pending")),
                                DataColumn(label: Text("Reopened")),
                                DataColumn(label: Text("Followups")),
                              ],
                              rows:
                              state.reportDetails.map((ReportModel e) {
                                return DataRow(cells: [
                                  DataCell(Text(e.date)),
                                  DataCell(Text(e.opened.toString(),
                                      style: const TextStyle(
                                          color: Colors.blue))),
                                  DataCell(Text(e.closed.toString(),
                                      style: const TextStyle(
                                          color: Colors.green))),
                                  DataCell(Text(e.pending.toString(),
                                      style: const TextStyle(
                                          color: Colors.orange))),
                                  DataCell(Text(e.reopened.toString(),
                                      style:
                                      const TextStyle(color: Colors.red))),
                                  DataCell(Text(e.followups.toString(),
                                      style: const TextStyle(
                                          color: Colors.purple))),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    } else if (state is ReportsError) {
                      return Center(
                        child: Text(state.message,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      );
                    } else {
                      return const Center(
                          child: Text("No data yet",
                              style: TextStyle(fontSize: 16)));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
