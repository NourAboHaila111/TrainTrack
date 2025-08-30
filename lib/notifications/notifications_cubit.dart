
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/NotificationModel.dart';
import '../model/InquiryModel.dart';
import '../shared/network/local/Cach_helper.dart';
import '../shared/network/remote/dio_helper.dart';
import 'package:meta/meta.dart';

import 'NotificationService.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);
  List<NotificationModel> notifications = [];
  /// جلب الإشعارات من API
  Future<void> getMyNotifications() async {
    final token = CachHelper.getData(key: 'token');
    emit(NotificationsLoading());
    try {
      final response = await DioHelper.getData(
        url: '/notifications/myNotifications',
        token: token,
      );

      List<dynamic> data = [];
      if (response.data is List) {
        data = response.data;
      } else if (response.data is String) {
        data = jsonDecode(response.data);
      }

      emit(NotificationsLoaded(data));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  /// تعيين الإشعار كمقروء
  Future<void> markAsRead(int id) async {
    final token = CachHelper.getData(key: 'token');
    try {
      await DioHelper.getData(
        url: '/notifications/setRead/$id',
        token: token,
      );
    } catch (e) {
      print("❌ Failed to mark as read: $e");
    }
  }

  /// جلب تفاصيل استفسار بواسطة inquiryId
  Future<Inquiry> fetchInquiryById(int inquiryId) async {
    final token = CachHelper.getData(key: 'token');
    try {
      final response = await DioHelper.getData(
        url: '/inquiries/$inquiryId',
        token: token,
      );

      if (response.data != null) {
        final decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;
        return Inquiry.fromJson(decoded);
      } else {
        throw Exception("لا يمكن جلب تفاصيل الاستفسار");
      }
    } catch (e) {
      throw Exception("خطأ في جلب تفاصيل الاستفسار: $e");
    }
  }


}
