import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:triantrak/sereen/Reporte/cubit/reports_state.dart';
import '../../../model/ReportPersonalModel.dart';
import '../../../shared/network/local/Cach_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

// ---------------- STATES ----------------


// ---------------- CUBIT ----------------
class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());

  static ReportsCubit of(context) => BlocProvider.of(context);

  Future<void> getSystemReport({
    required String startDate,
    required String endDate,
  }) async {
    emit(ReportsLoading());
    try {
      final token = CachHelper.getData(key: 'token');

      final response = await DioHelper.postData(
        url: "/reports/system/",
        data: {"start_date": startDate, "end_date": endDate},
        token: token,
      );

      print("📊 Full system report response: ${response.data}");

      dynamic rawReport = response.data;

      // إذا كانت الاستجابة String → نعمل decode
      if (rawReport is String) {
        rawReport = jsonDecode(rawReport);
      }

      if (rawReport == null) {
        if (!isClosed) emit(ReportsError("System report is null"));
        return;
      }

      if (rawReport is Map<String, dynamic>) {
        if (!isClosed) emit(ReportsSystemSuccess(rawReport));
      } else {
        if (!isClosed) {
          emit(ReportsError(
              "Unexpected system_report format: ${rawReport.runtimeType}"));
        }
      }
    } on DioError catch (e) {
      print("❌ DioError: ${e.response?.data}");
      if (!isClosed) {
        emit(ReportsError(
            e.response?.data.toString() ?? e.message ?? "Unknown Dio error"));
      }
    } catch (e) {
      print("❌ Exception: $e");
      if (!isClosed) emit(ReportsError(e.toString()));
    }
  }


  Future<void> getTrainersReport({
    required String startDate,
    required String endDate,

  }) async {
    emit(ReportsLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.postData(
        url: "/reports/trainers/",
        data: {"start_date": startDate, "end_date": endDate},
        token: token,
      );
      emit(ReportsTrainersSuccess(response.data));
    } on DioError catch (e) {
      emit(ReportsError(e.response?.data.toString() ?? e.message!));
    } catch (e) {
      emit(ReportsError(e.toString()));
    }}

  Future<void> downloadTrainerExcel({
    required String startDate,
    required String endDate,
  }) async {
    final token = CachHelper.getData(key: 'token');
    emit(ReportsLoading());

    try {
      // طلب الملف بصيغة bytes
      final response = await DioHelper.postData1(
        url: "/reports/trainerExcel",
        data: {"start_date": startDate, "end_date": endDate},
        token: token,
        options: Options(responseType: ResponseType.bytes),
      );

      // تأكد من الحصول على bytes
      List<int> fileBytes;

      if (response.data is List<int>) {
        fileBytes = response.data;
      } else if (response.data is String) {
        fileBytes = response.data.codeUnits; // تحويل string إلى bytes
      } else if (response.data is Map) {
        throw Exception("Server returned JSON instead of Excel file: ${response.data}");
      } else {
        throw Exception("Unsupported response type: ${response.data.runtimeType}");
      }

      // اختيار مكان الحفظ
      String? selectedPath = await FilePicker.platform.saveFile(
        dialogTitle: "Save Trainer Report",
        fileName: "trainer_report.xlsx",
      );

      if (selectedPath == null) {
        emit(ReportsError("File save cancelled"));
        return;
      }

      final file = File(selectedPath);
      await file.writeAsBytes(fileBytes); // ✔️ bytes

      await OpenFilex.open(file.path);

      emit(ReportsInitial());
    } catch (e) {
      print("❌ Download failed: $e");
      emit(ReportsError(e.toString()));
    }
  }



  Future<void> getReport({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    emit(ReportsLoading());
    try {
      final token = CachHelper.getData(key: 'token');

      final response = await DioHelper.postData(
        url: url,
        data: data,
        token: token,
      );

      List<dynamic> raw = response.data;
      final reports = raw.map((e) => ReportModel.fromJson(e)).toList();

      emit(ReportsLoaded(
        currentMonth: data.toString(),
        totalQueries: reports.fold(0, (s, e) => s + e.opened),
        answeredQueries: reports.fold(0, (s, e) => s + e.closed),
        reportDetails: reports,
      ) as ReportsState);
    } catch (e) {
      emit(ReportsError(e.toString()));
    }
  }

  Future<void> downloadReport({
    required String url,
    required Map<String, dynamic> data,
    required String defaultFileName,
  }) async {
    if (!isClosed) emit(ReportsLoading());

    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.postData1(
        url: url,
        data: data,
        token: token,
        options: Options(responseType: ResponseType.bytes),
      );

      List<int> bytes = response.data;

      // ✅ تحديد مجلد التخزين المناسب
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$defaultFileName";

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      await OpenFilex.open(file.path);

      if (!isClosed) emit(ReportsSuccess(filePath: filePath));
    } catch (e) {
      if (!isClosed) emit(ReportsError("Download failed: $e"));
      print("❌ Download failed: $e");
    }
  }

}



