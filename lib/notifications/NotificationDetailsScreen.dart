// import 'package:flutter/material.dart';
//
// import 'package:url_launcher/url_launcher.dart';
//
// import '../model/InquiryModel.dart';
//
// class InquiryDetailsScreen extends StatelessWidget {
//   final Inquiry inquiry;
//
//   const InquiryDetailsScreen({super.key, required this.inquiry});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("تفاصيل الاستفسار")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Text(
//               inquiry.title,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             Text(inquiry.body, style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 12),
//             Text("من: ${inquiry.userName}"),
//             const SizedBox(height: 8),
//             Text("التاريخ: ${inquiry.createdAt.split("T").first}"),
//             const SizedBox(height: 20),
//
//             // المرفقات
//             if (inquiry.attachments.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("المرفقات:", style: TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     height: 100,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: inquiry.attachments.length,
//                       separatorBuilder: (_, __) => const SizedBox(width: 10),
//                       itemBuilder: (context, index) {
//                         final att = inquiry.attachments[index];
//                         if (att.type == "image") {
//                           return Image.network(att.fileUrl,
//                               width: 100, height: 100, fit: BoxFit.cover);
//                         } else {
//                           return GestureDetector(
//                             onTap: () async {
//                               final url = Uri.parse(att.fileUrl);
//                               if (await canLaunchUrl(url)) {
//                                 await launchUrl(url,
//                                     mode: LaunchMode.externalApplication);
//                               }
//                             },
//                             child: Container(
//                               width: 100,
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade400),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(Icons.insert_drive_file, color: Colors.red),
//                                   Text(att.type.toUpperCase()),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:triantrak/layout/TrainDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/InquiryModel.dart';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';


import '../model/InquiryModel.dart';
import '../../shared/components/components.dart';
import '../sereen/Replay/ReplayInquiriesScreen.dart';
import '../shared/components/AppColors.dart'; // علشان navigateTo()

class InquiryDetailsScreen extends StatelessWidget {
  final Inquiry inquiry;

  const InquiryDetailsScreen({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context) {
    final imageAttachments =
    inquiry.attachments.where((a) => a.type == "image").toList();
    final fileAttachments =
    inquiry.attachments.where((a) => a.type != "image").toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inquiry Details"),
        backgroundColor: AppColor.primaryYellow,
        elevation: 0,
      ),
      drawer: TrainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 🟡 عنوان الاستفسار
            Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColor.mybabyellowDark // لون للدارك
                  : AppColor.mybabyellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inquiry.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Text(inquiry.body,
                        style: const TextStyle(fontSize: 14, height: 1.4)),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("From: ${inquiry.userName}",
                            style: const TextStyle(color: Colors.grey)),
                        Text(
                          inquiry.createdAt.split("T").first,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🟡 الصور
            if (imageAttachments.isNotEmpty) ...[
              const Text("Images:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageAttachments.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final att = imageAttachments[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ImageViewerScreen(
                              images: imageAttachments.map((e) => e.fileUrl).toList(),
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          att.fileUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 🟡 الملفات
            if (fileAttachments.isNotEmpty) ...[
              const Text("Files:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Column(
                children: fileAttachments.map((att) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.insert_drive_file,
                          color: AppColor.primaryBlue),
                      title: Text(att.type.toUpperCase()),
                      subtitle: Text(att.fileUrl,
                          overflow: TextOverflow.ellipsis),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () async {
                          try {
                            final url = Uri.parse(att.fileUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(  backgroundColor: AppColor.mypink, content: Text("Cannot open this file")),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(  backgroundColor: AppColor.primaryRed, content: Text("Error opening file: $e")),
                            );
                          }
                        }

                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),

      // 🟡 زر الرد أسفل الشاشة
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            navigateTo(
              context,
              ReplayInquiryScreen(
                inquiry: {
                  'id': inquiry.id.toString(),
                  'title': inquiry.title,
                  'status': inquiry.statusName,
                  'category': inquiry.categoryName,
                },
              ),
            );
          },
          icon: const Icon(Icons.reply, color: Colors.white),
          label: const Text("Reply",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryBlue,
            padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

/// شاشة عرض الصور (Zoom & Swipe)
class ImageViewerScreen extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const ImageViewerScreen(
      {super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: initialIndex);

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColor.mybabyellow),
      body: PhotoViewGallery.builder(
        pageController: controller,
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
