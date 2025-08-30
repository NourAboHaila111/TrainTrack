// import 'package:flutter/material.dart';
// import '../model/NotificationModel.dart';
// import 'NotificationDetailsScreen.dart';
// import 'notifications_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               NotificationsCubit.get(context).getMyNotifications();
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<NotificationsCubit, NotificationsState>(
//         builder: (context, state) {
//           if (state is NotificationsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is NotificationsError) {
//             return Center(child: Text("error: ${state.message}"));
//           }
//
//           if (state is NotificationsLoaded) {
//             final notifications = state.notifications
//                 .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
//                 .toList();
//
//             if (notifications.isEmpty) {
//               return const Center(child: Text("لا يوجد إشعارات بعد"));
//             }
//
//             return ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 final notif = notifications[index];
//
//                 return Card(
//                   color: notif.isRead
//                       ? Colors.grey.shade100
//                       : Colors.yellow.shade50,
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () async {
//                       // تعيين الإشعار كمقروء
//                       if (!notif.isRead) {
//                         await NotificationsCubit.get(context)
//                             .markAsRead(notif.id.toString());
//                       }
//
//                       // جلب تفاصيل الاستفسار
//                       final inquiry = await NotificationsCubit.get(context)
//                           .fetchInquiryById(notif.inquiryId);
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               InquiryDetailsScreen(inquiry: inquiry),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(14),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             notif.message,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontWeight: notif.isRead
//                                     ? FontWeight.normal
//                                     : FontWeight.bold),
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("من: ${notif.userName ?? 'غير معروف'}"),
//                               Text(notif.createdAt.split("T").first),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//
//           return const SizedBox();
//         },
//       ),
//     );
//   }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import 'package:triantrak/shared/components/AppColors.dart';
import '../model/NotificationModel.dart';
import 'notifications_cubit.dart';
import 'NotificationDetailsScreen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استدعاء جلب الإشعارات عند بناء الواجهة
    NotificationsCubit.get(context).getMyNotifications();

    return Scaffold(
      drawer: TrainDrawer(),
      appBar: AppBar(
        title: const Text(" Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              NotificationsCubit.get(context).getMyNotifications();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationsError) {
            return Center(child: Text("حدث خطأ: ${state.message}"));
          } else if (state is NotificationsLoaded) {
            final notifications = state.data
                .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
                .toList();

            if (notifications.isEmpty) {
              return const Center(child: Text("لا يوجد إشعارات بعد"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return Card(
                  elevation: 3,
                  shadowColor: Colors.black12,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? (notif.isRead ? Colors.grey.shade800 : Colors.yellow.shade700) // دارك
                      : (notif.isRead ? Colors.grey.shade100 : Colors.yellow.shade200), // لايت

                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      backgroundColor: notif.isRead ? Colors.grey.shade300 : Colors.amber.shade200,
                      radius: 24,
                      child: Icon(
                        notif.isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                        color: notif.isRead ? AppColor.primaryBlue : Colors.orange,
                        size: 28,
                      ),
                    ),
                    title: Text(
                      "Notification",
                      style: TextStyle(
                        fontWeight: notif.isRead ? FontWeight.w500 : FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          notif.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "📅 ${notif.createdAt.split("T").first}", // التاريخ
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () async {
                      if (!notif.isRead) {
                        await NotificationsCubit.get(context).markAsRead(notif.id);
                      }

                      final inquiry = await NotificationsCubit.get(context)
                          .fetchInquiryById(notif.inquiryId);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InquiryDetailsScreen(inquiry: inquiry),
                        ),
                      );
                    },
                  ),
                );

              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

// }
