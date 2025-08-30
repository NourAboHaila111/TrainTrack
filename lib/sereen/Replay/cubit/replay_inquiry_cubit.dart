import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'replay_inquiry_state.dart';

class ReplayInquiryCubit extends Cubit<ReplayInquiryState> {
  ReplayInquiryCubit() : super(ReplayInquiryInitial());

  static ReplayInquiryCubit get(context) => BlocProvider.of(context);

  List<PlatformFile> selectedAttachments = [];

  // اختيار المرفقات
  Future<void> pickAttachments() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        selectedAttachments = result.files;
        emit(ReplayInquiryAttachmentsAdded(selectedAttachments));
      }
    } catch (e) {
      emit(ReplayInquiryError("Error picking attachments: $e"));
    }
  }

  // استدعاء API للرد على الاستفسار
  void replyToInquiry({
    required dynamic inquiryId,
    required String token,
    required String response,
  }) async {
    emit(ReplayInquiryLoading());

    int id;
    if (inquiryId is int) {
      id = inquiryId;
    } else if (inquiryId is String) {
      id = int.tryParse(inquiryId) ?? 0;
    } else {
      emit(ReplayInquiryError("Invalid inquiry number"));
      return;
    }

    if (id == 0) {
      emit(ReplayInquiryError("Invalid inquiry number"));
      return;
    }

    try {
      // تجهيز الملفات كمصفوفة attachments[]
      List<MultipartFile> files = [];
      for (var file in selectedAttachments) {
        files.add(await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        ));
      }

      FormData formData = FormData.fromMap({
        "inquiry_id": id,
        "response": response,
        "status_id": 3,
        if (files.isNotEmpty) "attachments[]": files, // ← لاحظ [] بالمفتاح
      });

      await DioHelper.postData(
        url: "/inquiries/reply",
        token: token,
        data: formData,
      );

      emit(ReplayInquirySuccess("Replied successfully"));
    } catch (e) {
      emit(ReplayInquiryError("An error occurred: ${e.toString()}"));
    }
  }

  void removeAttachment(PlatformFile file) {
    selectedAttachments.remove(file);
    emit(ReplayInquiryUpdated()); // حدث الـ UI
  }

}

