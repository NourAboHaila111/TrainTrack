import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/reports_bloc.dart';
import 'cubit/reports_state.dart';


class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportsBloc()..add(LoadPersonalReports()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Reports"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Personal Reports"),
                Tab(text: "Department Reports"),
              ],
              onTap: (index) {
                final bloc = BlocProvider.of<ReportsBloc>(context);
                if (index == 0) {
                  bloc.add(LoadPersonalReports());
                } else {
                  bloc.add(LoadDepartmentReports());
                }
              },
            ),
          ),
          body: TabBarView(
            children: [
              ReportsView(),
              ReportsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state is ReportsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ReportsLoaded) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Month: ${state.currentMonth}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Total Queries: ${state.totalQueries}", style: TextStyle(fontSize: 16)),
                Text("Answered Queries: ${state.answeredQueries}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.reportDetails.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final report = state.reportDetails[index];
                      return Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              report.title,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              report.value.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is ReportsError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("Select a report type"));
      },
    );
  }
}
