import 'package:meta/meta.dart';
import '../../../model/ReportPersonalModel.dart';

@immutable
abstract class ReportsState {}

// الحالة الابتدائية
class ReportsInitial extends ReportsState {}

// أثناء تحميل البيانات أو الملف
class ReportsLoading extends ReportsState {}

// حالة النجاح عند تحميل البيانات (جدول Reports)
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

// حالة النجاح عند تحميل تقرير النظام
class ReportsSystemSuccess extends ReportsState {
  final Map<String, dynamic> systemReport;
  ReportsSystemSuccess(this.systemReport);
}

// حالة النجاح عند تحميل تقرير المدربين
class ReportsTrainersSuccess extends ReportsState {
  final List<dynamic> trainersReport;
  ReportsTrainersSuccess(this.trainersReport);
}

// حالة النجاح عند تنزيل أي تقرير Excel
class ReportsSuccess extends ReportsState {
  final String filePath;
  ReportsSuccess({required this.filePath});
}

// حالة وجود خطأ
class ReportsError extends ReportsState {
  final String message;
  ReportsError(this.message);
}
