//
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../model/SectionModel.dart';
// import '../../../../../model/follow_upModel.dart';
// import '../../../../../shared/network/local/Cach_helper.dart';
// import '../../../../../shared/network/remote/dio_helper.dart';
//
// part 'follow_up_state.dart';
//
// class FollowUpCubit extends Cubit<FollowUpState> {
//   FollowUpCubit() : super(FollowUpInitial());
//
//   static FollowUpCubit of(context) => BlocProvider.of(context);
//
//   List<FollowUp> followups = [];
//   List<SectionModel> sections = [];
//
//   /// جلب الأقسام
//   Future<void> getSections() async {
//     emit(FollowUpLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//       final response = await DioHelper.getData(
//         url: '/sections',
//         token: token,
//       );
//
//       if (response.statusCode == 200 && response.data is List) {
//         sections = (response.data as List)
//             .map((e) => SectionModel.fromJson(e))
//             .toList();
//         emit(FollowUpSectionsLoaded(sections));
//       } else {
//         sections = [];
//         emit(FollowUpError('فشل تحميل الأقسام'));
//       }
//     } catch (e) {
//       emit(FollowUpError('فشل تحميل الأقسام'));
//     }
//   }
//
//   /// جلب المتابعات حسب الاستفسار
//   Future<void> getFollowupsByInquiryId(int inquiryId) async {
//     emit(FollowUpLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//       final response = await DioHelper.getData(
//         url: '/followupsrequest/$inquiryId',
//         token: token,
//       );
//
//       if (response.statusCode == 200 && response.data is List) {
//         followups = (response.data as List)
//             .map((e) => FollowUp.fromJson(e))
//             .toList();
//         emit(FollowUpListLoaded(followups));
//         print("...............Follow-up ${followups.toString()}");
//       } else {
//         followups = [];
//         emit(FollowUpError('Not Found Follow Up'));
//         print("...............Follow-up ${followups.toString()}");
//       }
//     } catch (e) {
//       emit(FollowUpError('Not Found Follow Up'));
//       print("...............Follow-up ${e.toString()}");
//     }
//   }
//
//   /// إنشاء متابعة جديدة
//   Future<void> createFollowUp({
//     required int inquiryId,
//     required int status,
//     required int sectionId,
//     String? message,
//     List<PlatformFile>? attachments, // ← نمرر الملفات هنا (من file_picker)
//   }) async {
//     emit(FollowUpLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//
//       // تجهيز الملفات إذا موجودة
//       List<MultipartFile> files = [];
//       if (attachments != null && attachments.isNotEmpty) {
//         for (var file in attachments) {
//           files.add(
//             await MultipartFile.fromFile(
//               file.path!,
//               filename: file.name,
//             ),
//           );
//         }
//       }
//
//       // تجهيز FormData
//       FormData formData = FormData.fromMap({
//         "inquiry_id": inquiryId,
//         "status": status,
//         "section_id": sectionId,
//         if (message != null && message.isNotEmpty) "message": message,
//         if (files.isNotEmpty) "attachments[]": files, // ← مصفوفة المرفقات
//       });
//
//       final response = await DioHelper.postData(
//         url: '/followups',
//         data: formData,
//         token: token,
//       );
//
//       if (response.statusCode == 201 || response.statusCode == 200) {
//         await getFollowupsByInquiryId(inquiryId);
//         emit(FollowUpSuccess('The follow-up was created successfully.'));
//       } else {
//         emit(FollowUpError('Follow-up creation failed'));
//       }
//     } catch (e) {
//       print("...............Follow-up creation failed${e.toString()}");
//       emit(FollowUpError('Follow-up creation failed${e.toString()}'));
//     }
//   }
//
//   /// تحديث متابعة
//   Future<void> updateFollowUp({
//     required int followupId,
//     required int status,
//     required int sectionId,
//     required int inquiryId,
//     String? message,
//     List<PlatformFile>? attachments,
//   }) async {
//     emit(FollowUpLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//
//       // تجهيز البيانات كـ FormData
//       final formData = FormData.fromMap({
//         "status": status,
//         "section_id": sectionId,
//         if (message != null && message.isNotEmpty) "message": message,
//         if (attachments != null && attachments.isNotEmpty)
//           "attachments": [
//             for (var file in attachments)
//               await MultipartFile.fromFile(file.path!, filename: file.name),
//           ],
//       });
//
//       final response = await DioHelper.postData(
//         url: '/followups/$followupId',
//         data: formData,
//         token: token,
//        // isFormData: true, // ⚡ تأكد أن DioHelper يدعم هذا الخيار
//       );
//
//       if (response.statusCode == 200) {
//         await getFollowupsByInquiryId(inquiryId);
//         emit(FollowUpSuccess('تم تحديث المتابعة بنجاح'));
//       } else {
//         emit(FollowUpError('فشل تحديث المتابعة'));
//       }
//     } catch (e) {
//       emit(FollowUpError('فشل تحديث المتابعة'));
//     }}
//   /// حذف متابعة
//   Future<void> deleteFollowUp({
//     required int followupId,
//     required int inquiryId,
//   }) async {
//     emit(FollowUpLoading());
//     try {
//       final token = CachHelper.getData(key: 'token');
//       final response = await DioHelper.deleteData(
//         url: '/followups/$followupId',
//         token: token,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 204) {
//         await getFollowupsByInquiryId(inquiryId);
//         emit(FollowUpSuccess('تم حذف المتابعة بنجاح'));
//       } else {
//         emit(FollowUpError('فشل حذف المتابعة'));
//       }
//     } catch (e) {
//       emit(FollowUpError('فشل حذف المتابعة'));
//     }
//   }
//   /// إرجاع user id الحالي من الكاش (int?) أو null إذا غير موجود
//   int? getCurrentUserId() {
//     final raw = CachHelper.getData(key: 'user_id'); // تخزين user_id يجب أن يتم عند Login
//     if (raw == null) return null;
//     if (raw is int) return raw;
//     return int.tryParse(raw.toString());
//   }
//
//   /// هل المستخدم الحالي قادر على تعديل/حذف follow-up معين؟
//   bool canModify(int followUpId) {
//     final curUserId = getCurrentUserId();
//     if (curUserId == null) return false;
//
//     try {
//       final fu = followups.firstWhere((f) => f.id == followUpId);
//       // افترض أن موديل FollowUp يحتوي حقل userId
//       return fu.id == curUserId || isCurrentUserAdmin();
//     } catch (_) {
//       return false;
//     }
//   }
// }
//
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../model/SectionModel.dart';
import '../../../../../model/follow_upModel.dart';
import '../../../../../shared/network/local/Cach_helper.dart';
import '../../../../../shared/network/remote/dio_helper.dart';

part 'follow_up_state.dart';

class FollowUpCubit extends Cubit<FollowUpState> {
  FollowUpCubit() : super(FollowUpInitial());

  static FollowUpCubit of(context) => BlocProvider.of(context);

  List<FollowUp> followups = [];
  List<SectionModel> sections = [];

  /// Fetch sections
  Future<void> getSections() async {
    emit(FollowUpLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.getData(
        url: '/sections',
        token: token,
      );

      if (response.statusCode == 200 && response.data is List) {
        sections = (response.data as List)
            .map((e) => SectionModel.fromJson(e))
            .toList();
        emit(FollowUpSectionsLoaded(sections));
      } else {
        sections = [];
        emit(FollowUpError('Failed to load sections.'));
      }
    } catch (e) {
      emit(FollowUpError('An error occurred while loading sections.'));
    }
  }

  /// Fetch follow-ups by inquiry id
  Future<void> getFollowupsByInquiryId(int inquiryId) async {
    emit(FollowUpLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.getData(
        url: '/followupsrequest/$inquiryId',
        token: token,
      );

      if (response.statusCode == 200 && response.data is List) {
        followups = (response.data as List)
            .map((e) => FollowUp.fromJson(e))
            .toList();
        emit(FollowUpListLoaded(followups));
      } else {
        followups = [];
        emit(FollowUpError('No follow-ups found.'));
      }
    } catch (e) {
      emit(FollowUpError('Failed to load follow-ups.'));
    }
  }

  /// Create follow-up
  Future<void> createFollowUp({
    required int inquiryId,
    required int status,
    required int sectionId,
    String? message,
    List<PlatformFile>? attachments,
  }) async {
    emit(FollowUpLoading());
    try {
      final token = CachHelper.getData(key: 'token');

      List<MultipartFile> files = [];
      if (attachments != null && attachments.isNotEmpty) {
        for (var file in attachments) {
          files.add(
            await MultipartFile.fromFile(file.path!, filename: file.name),
          );
        }
      }

      FormData formData = FormData.fromMap({
        "inquiry_id": inquiryId,
        "status": status,
        "section_id": sectionId,
        if (message != null && message.isNotEmpty) "response": message,
        if (files.isNotEmpty) "attachments[]": files,
      });

      final response = await DioHelper.postData(
        url: '/followups',
        data: formData,
        token: token,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        await getFollowupsByInquiryId(inquiryId);
        emit(FollowUpSuccess('The follow-up was created successfully.'));
      } else {
        emit(FollowUpError('Follow-up creation failed.'));
      }
    } catch (e) {
      emit(FollowUpError('Follow-up creation failed: ${e.toString()}'));
    }
  }

  /// Update follow-up
  Future<void> updateFollowUp({
    required int followupId,
    required int status,
    required int sectionId,
    required int inquiryId,
    String? message,
    List<PlatformFile>? attachments,
  }) async {
    emit(FollowUpLoading());
    try {
      final token = CachHelper.getData(key: 'token');

      final formData = FormData.fromMap({
        "status": status,
        "section_id": sectionId,
        if (message != null && message.isNotEmpty) "message": message,
        if (attachments != null && attachments.isNotEmpty)
          "attachments": [
            for (var file in attachments)
              await MultipartFile.fromFile(file.path!, filename: file.name),
          ],
      });

      final response = await DioHelper.postData(
        url: '/followups/$followupId',
        data: formData,
        token: token,
      );

      if (response.statusCode == 200) {
        await getFollowupsByInquiryId(inquiryId);
        emit(FollowUpSuccess('The follow-up was updated successfully.'));
      } else if (response.statusCode == 403) {
        emit(FollowUpError("You don't have permission to update this follow-up."));
      } else {
        emit(FollowUpError('Follow-up update failed.'));
      }
    } catch (e) {
      emit(FollowUpError('Follow-up update failed: ${e.toString()}'));
    }
  }

  /// Delete follow-up
  Future<void> deleteFollowUp({
    required int followupId,
    required int inquiryId,
  }) async {
    emit(FollowUpLoading());
    try {
      final token = CachHelper.getData(key: 'token');
      final response = await DioHelper.deleteData(
        url: '/followups/$followupId',
        token: token,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await getFollowupsByInquiryId(inquiryId);
        emit(FollowUpSuccess('The follow-up was deleted successfully.'));
      } else if (response.statusCode == 403) {
        emit(FollowUpError("You don't have permission to delete this follow-up."));
      } else {
        emit(FollowUpError('Follow-up deletion failed.'));
      }
    } catch (e) {
      emit(FollowUpError('Follow-up deletion failed: ${e.toString()}'));
    }
  }

  /// Current user ID
  int? getCurrentUserId() {
    final raw = CachHelper.getData(key: 'user_id');
    if (raw == null) return null;
    if (raw is int) return raw;
    return int.tryParse(raw.toString());
  }

  /// Check if current user is admin
  bool isCurrentUserAdmin() {
    final role = CachHelper.getData(key: 'role');
    return role != null && role.toString().toLowerCase() == "admin";
  }

  /// /////////////////////////////////Check if current user can modify/delete follow-up
  bool canModify(int followUpId) {
    final curUserId = getCurrentUserId();
    if (curUserId == null) return false;

    try {

      final fu = followups.firstWhere((f) => f.id == followUpId);
      return fu.followerid == curUserId || isCurrentUserAdmin();
      // المستخدم فقط يقدر يعدل/يحذف إذا كان صاحب المتابعة أو أدمن
    } catch (_) {
      return false;
    }
  }

}

