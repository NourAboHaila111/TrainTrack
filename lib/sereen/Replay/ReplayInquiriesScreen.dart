//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:triantrak/layout/TrainDrawer.dart';
// import 'package:triantrak/shared/components/AppColors.dart';
// import 'package:triantrak/shared/network/local/Cach_helper.dart';
// import 'View Follow-ups.dart';
// import 'cubit/replay_inquiry_cubit.dart';
// import 'cubit/replay_inquiry_state.dart';
//
// class ReplayInquiryScreen extends StatelessWidget {
//   final Map<String, dynamic> inquiry;
//   final TextEditingController replyController = TextEditingController();
//
//   ReplayInquiryScreen({required this.inquiry});
//
//   @override
//   Widget build(BuildContext context) {
//     final inquiryId = inquiry['id'];
//
//     return BlocProvider(
//       create: (_) => ReplayInquiryCubit(),
//       child: Scaffold(
//         drawer: TrainDrawer(),
//         appBar: AppBar(
//           title: Text("Reply to Inquiry"),
//           backgroundColor: AppColor.primaryYellow,
//         ),
//         body: BlocConsumer<ReplayInquiryCubit, ReplayInquiryState>(
//           listener: (context, state) {
//             if (state is ReplayInquirySuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Row(
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.white),
//                       SizedBox(width: 8),
//                       Expanded(child: Text(state.message)),
//                     ],
//                   ),
//                   backgroundColor: Colors.green,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               );
//               replyController.clear();
//             } else if (state is ReplayInquiryError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Row(
//                     children: [
//                       Icon(Icons.error, color: Colors.white),
//                       SizedBox(width: 8),
//                       Expanded(child: Text(state.message)),
//                     ],
//                   ),
//                   backgroundColor: Colors.red,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             final cubit = ReplayInquiryCubit.get(context);
//
//             if (state is ReplayInquiryLoading) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // كارد تفاصيل الاستفسار
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 20.0),
//                     child: Container(
//                       width: 400,
//                       height: 250,
//                       child: Card(
//                         margin: EdgeInsets.all(16),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         elevation: 4,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 inquiry['title'] ?? "No title",
//                                 style: TextStyle(
//                                     fontSize: 22, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 inquiry['body'] ?? "No body",
//                                 style: TextStyle(
//                                     fontSize: 14),
//                               ),
//                               SizedBox(height: 15),
//                               Text("Category: ${inquiry['category'] ?? '--'}",
//                                   style: TextStyle(fontSize: 18)),
//                               Text("Status: ${inquiry['status'] ?? '--'}",
//                                   style: TextStyle(fontSize: 18)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // إدخال الرد
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: TextField(
//                       controller: replyController,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         hintText: "Write Answer...",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         contentPadding: EdgeInsets.all(12),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 22),
//
//                   // زر إضافة مرفقات
//                   Padding(
//                     padding: const EdgeInsets.only(right: 166),
//                     child: OutlinedButton.icon(
//                       onPressed: () {
//                         cubit.pickAttachments();
//                       },
//                       icon: Icon(Icons.attach_file, color: AppColor.primaryBlue),
//                       label: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         child: Text(
//                           "Add attachment",
//                           style: TextStyle(
//                             color: AppColor.primaryBlue,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: AppColor.primaryBlue, width: 1.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       ),
//                     ),
//                   ),
//
//                   // عرض الملفات المختارة
//                   BlocBuilder<ReplayInquiryCubit, ReplayInquiryState>(
//                     builder: (context, state) {
//                       if (cubit.selectedAttachments.isEmpty) {
//                         return SizedBox.shrink();
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: cubit.selectedAttachments.map((file) {
//                             return Row(
//                               children: [
//                                 Icon(Icons.insert_drive_file, color: Colors.grey),
//                                 SizedBox(width: 8),
//                                 Expanded(
//                                     child: Text(file.name,
//                                         overflow: TextOverflow.ellipsis)),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     },
//                   ),
//
//                   SizedBox(height: 32),
//
//                   // زر إرسال الرد
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20, right: 220),
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         if (replyController.text.isNotEmpty) {
//                           cubit.replyToInquiry(
//                             inquiryId: inquiryId,
//                             token: CachHelper.getData(key: "token"),
//                             response: replyController.text,
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text("Please enter answer"),
//                               backgroundColor: Colors.orange,
//                             ),
//                           );
//                         }
//                       },
//                       icon: Icon(Icons.send, color: Colors.white),
//                       label: Text("Send"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.primaryBlue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 50),
//
//                   // زر عرض المتابعات
//                   Padding(
//                     padding: const EdgeInsets.only(right: 166),
//                     child: OutlinedButton.icon(
//                       onPressed: () {
//
//
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => ViewFollowUpScreen(inquiryId: int.parse(inquiry['id'].toString())), // ✅ int
//                             ),
//                           );
//
//                       },
//                       icon: Icon(Icons.list_alt, color: AppColor.primaryBlue),
//                       label: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         child: Text(
//                           "View follow up",
//                           style: TextStyle(
//                             color: AppColor.primaryBlue,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: AppColor.primaryBlue, width: 1.5),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import 'package:triantrak/shared/components/AppColors.dart';
import 'package:triantrak/shared/network/local/Cach_helper.dart';
import 'View Follow-ups.dart';
import 'cubit/replay_inquiry_cubit.dart';
import 'cubit/replay_inquiry_state.dart';

class ReplayInquiryScreen extends StatelessWidget {
  final Map<String, dynamic> inquiry;
  final TextEditingController replyController = TextEditingController();

  ReplayInquiryScreen({required this.inquiry});

  @override
  Widget build(BuildContext context) {
    final inquiryId = inquiry['id'];
    final List<dynamic> attachments = inquiry['attachments'] ?? []; // ✅ المرفقات القادمة

    return Scaffold(
      drawer: TrainDrawer(),
      appBar: AppBar(
        title: Text("Reply to Inquiry"),
        backgroundColor: AppColor.primaryYellow,
      ),
      body: BlocConsumer<ReplayInquiryCubit, ReplayInquiryState>(
        listener: (context, state) {
          if (state is ReplayInquirySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            replyController.clear();
          } else if (state is ReplayInquiryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = ReplayInquiryCubit.get(context);

          if (state is ReplayInquiryLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // ✅ تفاصيل الاستفسار
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inquiry['title'] ?? "No title",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            inquiry['body'] ?? "No body",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 15),
                          Text("Category: ${inquiry['category']?? '--'}",
                              style: TextStyle(fontSize: 16)),
                          // Text("User: ${inquiry['user']?['name']?? '--'}",
                          //     style: TextStyle(fontSize: 16)),
                          // Text(
                          //   "User: ${inquiry['user'] != null ? inquiry['user']['name'] ?? '--' : '--'}",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          // Text("assingee: ${inquiry['assignee_user']?['name'] ?? '--'}",
                          //     style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),

                // ✅ المرفقات القادمة من السيرفر
                if (attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("📎 Attachments:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: attachments.length,
                          itemBuilder: (context, index) {
                            final att = attachments[index];
                            final url = att['file_url'];
                            final type = att['type'];

                            if (type == "image") {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.shade400),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.insert_drive_file,
                                        color: Colors.blue, size: 40),
                                    SizedBox(height: 6),
                                    Text(
                                      type.toUpperCase(),
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                // ✅ إدخال الرد
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: replyController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write Answer...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(height: 22),

                // زر إضافة مرفقات محلية
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      cubit.pickAttachments();
                    },
                    icon: Icon(Icons.attach_file, color: AppColor.primaryBlue),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Add attachment",
                        style: TextStyle(
                          color: AppColor.primaryBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.primaryBlue, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),

          BlocBuilder<ReplayInquiryCubit, ReplayInquiryState>(
          builder: (context, state) {
          if (cubit.selectedAttachments.isEmpty) {
          return SizedBox.shrink();
          }
          return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cubit.selectedAttachments.map((file) {
          return Row(
          children: [
          Icon(Icons.insert_drive_file, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
          child: Text(
          file.name,
          overflow: TextOverflow.ellipsis,
          ),
          ),
          IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () {
          // استدعاء تابع إزالة الملف من الـ Cubit
          cubit.removeAttachment(file);
          },
          ),
          ],
          );
          }).toList(),
          ),
          );
          },
          ),


          SizedBox(height: 32),

                // زر إرسال الرد
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (replyController.text.isNotEmpty) {
                        cubit.replyToInquiry(
                          inquiryId: inquiryId,
                          token: CachHelper.getData(key: "token"),
                          response: replyController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter answer"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white),
                    label: Text("Send"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // زر عرض المتابعات
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewFollowUpScreen(
                              inquiryId: int.parse(inquiry['id'].toString())),
                        ),
                      );
                    },
                    icon: Icon(Icons.list_alt, color: AppColor.primaryBlue),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "View follow up",
                        style: TextStyle(
                          color: AppColor.primaryBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.primaryBlue, width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
