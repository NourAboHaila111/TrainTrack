// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import '../model/NotificationModel.dart';
//
//
// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//
//   NotificationService._internal();
//
//   final ValueNotifier<List<NotificationModel>> notifications = ValueNotifier([]);
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
//   final FlutterLocalNotificationsPlugin _localNotifications =
//   FlutterLocalNotificationsPlugin();
//
//   final String apiKey = "7e128d7214eddf18c6d0";
//   final String cluster = "ap2";
//   final String channelName = "user-3"; // ✅ غير مسافة لـ - أو _ حسب السيرفر
//
//   Future<void> init() async {
//     await _initLocalNotifications();
//     await _initPusher();
//   }
//
//   Future<void> _initLocalNotifications() async {
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(android: androidInit);
//     await _localNotifications.initialize(initSettings);
//   }
//
//   Future<void> _showLocalNotification(String message) async {
//     const androidDetails = AndroidNotificationDetails(
//       'pusher_channel_id',
//       'Pusher Notifications',
//       channelDescription: 'Channel for real-time notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const details = NotificationDetails(android: androidDetails);
//
//     await _localNotifications.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       'إشعار جديد',
//       message,
//       details,
//     );
//   }
//
//   Future<void> _initPusher() async {
//     try {
//       await _pusher.init(
//         apiKey: apiKey,
//         cluster: cluster,
//         onConnectionStateChange: (current, prev) {
//           debugPrint("Pusher: $prev → $current");
//         },
//         onError: (message, code, e) {
//           debugPrint("Pusher error: $message, code: $code, exception: $e");
//         },
//       );
//
//       await _pusher.subscribe(
//         channelName: channelName,
//         onEvent: (event) {
//           if (event.data != null) {
//             final json = event.data!;
//             // 👇 هنا لازم تحول string إلى Map
//             final map = Map<String, dynamic>.from(jsonDecode(json));
//             final notif = NotificationModel.fromJson(map);
//
//             notifications.value = [...notifications.value, notif];
//             _showLocalNotification(notif.message);
//           }
//         },
//       );
//
//       await _pusher.connect();
//     } catch (e) {
//       debugPrint("Error initializing Pusher: $e");
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../model/NotificationModel.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final ValueNotifier<List<NotificationModel>> notifications = ValueNotifier([]);
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  final String apiKey = "7e128d7214eddf18c6d0";
  final String cluster = "ap2";
  final String channelName = "user-3";

  Future<void> init() async {
    await _initLocalNotifications();
    await _initPusher();
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (resp) {
        debugPrint("Notification clicked: ${resp.payload}");
      },
    );
  }

  Future<void> _showLocalNotification(String title, String message) async {
    const androidDetails = AndroidNotificationDetails(
      'pusher_channel_id',
      'Pusher Notifications',
      channelDescription: 'Realtime Notifications from Pusher',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      message,
      details,
    );
  }

  Future<void> _initPusher() async {
    try {
      await _pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: (current, prev) {
          debugPrint("Pusher connection: $prev → $current");
        },
        onError: (msg, code, e) {
          debugPrint("Pusher error: $msg, code: $code, exception: $e");
        },
      );

      await _pusher.subscribe(
        channelName: channelName,
        onEvent: (event) {
          debugPrint("📩 New Pusher Event: ${event.data}");

          if (event.data != null) {
            try {
              Map<String, dynamic> mapData;

              if (event.data is String) {
                mapData = jsonDecode(event.data!) as Map<String, dynamic>;
              } else if (event.data is Map) {
                mapData = Map<String, dynamic>.from(event.data as Map);
              } else {
                debugPrint("❌ Unknown Pusher data type: ${event.data.runtimeType}");
                return;
              }

              // ✅ التحقق من وجود مفتاح message
              if (!mapData.containsKey('message')) {
                mapData['message'] = 'لديك إشعار جديد';
              }

              // إعطاء قيم افتراضية لتجنب NullPointer
              mapData['id'] = mapData['id'] ?? DateTime.now().millisecondsSinceEpoch;
              mapData['inquiry_id'] = mapData['inquiry_id'] ?? 0;
              mapData['user_id'] = mapData['user_id'] ?? 0;
              mapData['title'] = mapData['title'] ?? 'إشعار جديد';
              mapData['status'] = mapData['status'] ?? 'unread';
              mapData['created_at'] = mapData['created_at'] ?? DateTime.now().toIso8601String();
              mapData['updated_at'] = mapData['updated_at'] ?? DateTime.now().toIso8601String();

              final notif = NotificationModel.fromJson(mapData);

              // تحديث قائمة الإشعارات داخل التطبيق
              notifications.value = [...notifications.value, notif];

              // عرض إشعار محلي
              _showLocalNotification(notif.title, notif.message);

            } catch (e) {
              debugPrint("❌ Error parsing notification: $e");
            }
          }
        },
      );

      await _pusher.connect();
    } catch (e) {
      debugPrint("❌ Error initializing Pusher: $e");
    }
  }
}
