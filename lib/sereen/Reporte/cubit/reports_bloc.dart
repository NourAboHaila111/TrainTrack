import 'package:flutter_bloc/flutter_bloc.dart';
import 'ModelReoprts.dart';
import 'reports_state.dart';
import 'dart:async';

abstract class ReportsEvent {}

class LoadPersonalReports extends ReportsEvent {}

class LoadDepartmentReports extends ReportsEvent {}

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsInitial()) {
    on<LoadPersonalReports>(_onLoadPersonalReports);
    on<LoadDepartmentReports>(_onLoadDepartmentReports);
  }

  Future<void> _onLoadPersonalReports(LoadPersonalReports event, Emitter<ReportsState> emit) async {
    emit(ReportsLoading());

    try {
      // محاكاة تحميل البيانات
      await Future.delayed(Duration(seconds: 1));

      final currentMonth = "June";
      final totalQueries = 120;
      final answeredQueries = 95;
      final reportDetails = [
        ReportModel(title: "Closed", value: 70),
        ReportModel(title: "Open", value: 30),
        ReportModel(title: "Pending", value: 20),
      ];

      emit(ReportsLoaded(
        currentMonth: currentMonth,
        totalQueries: totalQueries,
        answeredQueries: answeredQueries,
        reportDetails: reportDetails,
      ));
    } catch (e) {
      emit(ReportsError("Failed to load personal reports"));
    }
  }

  Future<void> _onLoadDepartmentReports(LoadDepartmentReports event, Emitter<ReportsState> emit) async {
    emit(ReportsLoading());

    try {
      await Future.delayed(Duration(seconds: 1));

      final currentMonth = "June";
      final totalQueries = 220;
      final answeredQueries = 150;
      final reportDetails = [
        ReportModel(title: "Closed", value: 130),
        ReportModel(title: "Open", value: 60),
        ReportModel(title: "Pending", value: 30),
      ];

      emit(ReportsLoaded(
        currentMonth: currentMonth,
        totalQueries: totalQueries,
        answeredQueries: answeredQueries,
        reportDetails: reportDetails,
      ));
    } catch (e) {
      emit(ReportsError("Failed to load department reports"));
    }
  }
}
