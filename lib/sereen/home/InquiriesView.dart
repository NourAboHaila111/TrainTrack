//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../model/InquiryModel.dart';
// import '../../shared/components/AppColors.dart';
// import '../../shared/components/components.dart';
// import '../Replay/ReplayInquiriesScreen.dart';
// import 'Timeline.dart';
// import 'cubit/HomeCubit.dart';
// import 'cubit/HomeState.dart';
//
// class QueryTable extends StatelessWidget {
//   const QueryTable({super.key});
//
//   // تحديد لون الحالة
//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'opened':
//         return AppColor.primaryBlue;
//       case 'closed':
//         return AppColor.primaryRed;
//       case 'pending':
//         return AppColor.mypink;
//       default:
//         return Colors.blueGrey;
//     }
//   }
//
//   // عرض الـ Dialog الخاص بالـ Timeline
//   void showTimelineDialog(BuildContext context, String currentStatus) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Inquiry Timeline"),
//         content: SizedBox(
//           width: double.maxFinite,
//           height: 400,
//           child: InquiryTimeline(currentStatus: currentStatus),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Close"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InquiriesCubit, InquiriesState>(
//       builder: (context, state) {
//         if (state is InquiriesLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is InquiriesError) {
//           return Center(child: Text('Error: ${state.message}'));
//         } else if (state is InquiriesLoaded) {
//           final List<Inquiry> data = state.inquiries;
//
//           return ListView.builder(
//             itemCount: data.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               final item = data[index];
//
//               return Card(
//                 elevation: 4,
//                 margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // عنوان الاستفسار
//                       Hero(
//                         tag: 'inquiry-title-$index',
//                         child: Material(
//                           color: Colors.transparent,
//                           child: Text(
//                             item.title,
//                             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//
//                       // حالة الاستفسار والفئة + زر الرد + عرض التايملاين
//                       Row(
//                         children: [
//                           // الحالة
//                           Chip(
//                             label: Text(item.status),
//                             backgroundColor: getStatusColor(item.status),
//                             labelStyle: const TextStyle(color: Colors.white),
//                           ),
//
//                           const SizedBox(width: 10),
//
//                           // الفئة
//                           Text(
//                             item.category,
//                             style: const TextStyle(fontSize: 14, color: AppColor.primaryGrye),
//                           ),
//
//                           const Spacer(),
//
//                           // زر الرد
//                           ElevatedButton(
//                             onPressed: () {
//                               navigateTo(
//                                 context,
//                                 Replayinquiriesscreen(
//                                   inquiry: {
//                                     'id': item.id.toString(),
//                                     'title': item.title,
//                                     'status': item.status,
//                                     'category': item.category,
//                                   },
//                                   tagIndex: index,
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Reply',
//                               style: TextStyle(fontWeight: FontWeight.w300),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.mybabyellow,
//                               foregroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//
//                           // زر التايملاين
//                           IconButton(
//                             icon: const Icon(Icons.timeline),
//                             tooltip: 'View Timeline',
//                             onPressed: () {
//                               showTimelineDialog(context, item.status);
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/InquiryModel.dart';
import '../../shared/components/AppColors.dart';
import '../../shared/components/components.dart';
import '../Replay/ReplayInquiriesScreen.dart';
import 'Timeline.dart';
import 'cubit/HomeCubit.dart';
import 'cubit/HomeState.dart';

class QueryTable extends StatelessWidget {
  final List<Inquiry>? inquiries;

  const QueryTable({super.key, this.inquiries});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'opened':
        return AppColor.primaryBlue;
      case 'closed':
        return AppColor.primaryRed;
      case 'pending':
        return AppColor.mypink;
      default:
        return Colors.blueGrey;
    }
  }

  void showTimelineDialog(BuildContext context, String currentStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Inquiry Timeline"),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: InquiryTimeline(currentStatus: currentStatus),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (inquiries != null) {
      return buildInquiryList(inquiries!);
    }

    return BlocBuilder<InquiriesCubit, InquiriesState>(
      builder: (context, state) {
        if (state is InquiriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InquiriesError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is InquiriesLoaded) {
          return buildInquiryList(state.inquiries);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildInquiryList(List<Inquiry> data) {
    if (data.isEmpty) {
      return const Center(child: Text("لا توجد استفسارات مطابقة."));
    }

    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'inquiry-title-$index',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      item.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(item.status),
                      backgroundColor: getStatusColor(item.status),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.category,
                      style: const TextStyle(fontSize: 14, color: AppColor.primaryGrye),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        navigateTo(
                          context,
                          Replayinquiriesscreen(
                            inquiry: {
                              'id': item.id.toString(),
                              'title': item.title,
                              'status': item.status,
                              'category': item.category,
                            },
                            tagIndex: index,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mybabyellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Reply', style: TextStyle(fontWeight: FontWeight.w300)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.timeline),
                      tooltip: 'View Timeline',
                      onPressed: () {
                        showTimelineDialog(context, item.status);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
