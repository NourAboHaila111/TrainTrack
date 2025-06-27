import 'ModelReoprts.dart';

abstract class ReportsState {}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsError extends ReportsState {
  final String message;

  ReportsError(this.message);
}

// الحالة التي تُحمّل تقارير شخصية أو قسم وتشمل معلومات إضافية
class ReportsLoaded extends ReportsState {
  final String currentMonth;
  final int totalQueries;
  final int answeredQueries;
  final List<ReportModel> reportDetails;

  ReportsLoaded({
    required this.currentMonth,
    required this.totalQueries,
    required this.answeredQueries,
    required this.reportDetails,
  });
}
