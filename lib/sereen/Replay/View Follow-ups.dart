//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:file_picker/file_picker.dart'; // لا تنسى تضيف الباكدج
// import '../../layout/TrainDrawer.dart';
// import '../../model/follow_upModel.dart';
// import '../../shared/components/AppColors.dart';
// import 'cubit/followUp/dart/follow_up_cubit.dart';
//
// class ViewFollowUpScreen extends StatelessWidget {
//   final int inquiryId;
//   const ViewFollowUpScreen({Key? key, required this.inquiryId})
//       : super(key: key);
//
//   Widget _buildColumn(
//       String title, Color color, List<FollowUp> items, BuildContext context) {
//     final cubit = FollowUpCubit.of(context);
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         color: color.withOpacity(0.05),
//         child: Column(
//           children: [
//             Text(title,
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//
//                     fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//             const SizedBox(height: 10),
//             Expanded(
//               child: items.isEmpty
//                   ? Center(
//                   child: Text("Not found", style: TextStyle(color: color)))
//                   : ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(item.response ?? ''),
//                       subtitle: Text(
//                         "section: ${item.sectionName ?? '-'}\nDate: ${item.createdAt ?? ''}",
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                       trailing: Wrap(
//                         spacing: 8,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit,
//                                 color: AppColor.primaryBlue),
//                             onPressed: () {
//                               _showFollowUpDialog(context,
//                                   followUp: item);
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete,
//                                 color: AppColor.primaryRed),
//                             onPressed: () {
//                               cubit.deleteFollowUp(
//                                   followupId: item.id,
//                                   inquiryId: inquiryId);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showFollowUpDialog(BuildContext context, {FollowUp? followUp}) {
//     final cubit = FollowUpCubit.of(context);
//     final msgController =
//     TextEditingController(text: followUp?.response ?? '');
//
//     int? selectedSectionId = followUp?.sectionId;
//     int status = followUp?.status ?? 0;
//
//     List<PlatformFile> selectedAttachments = [];
//
//     showDialog(
//       context: context,
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(followUp == null ? "Create Follow-Up" : "Edit Follow-Up"),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButton<int>(
//                       value: selectedSectionId,
//                       hint: const Text("Select Section"),
//                       onChanged: (val) {
//                         setState(() => selectedSectionId = val);
//                       },
//                       items: cubit.sections
//                           .map((s) => DropdownMenuItem(
//                         value: s.id,
//                         child: Text(s.name),
//                       ))
//                           .toList(),
//                     ),
//                     DropdownButton<int>(
//                       value: status,
//                       onChanged: (val) {
//                         if (val != null) setState(() => status = val);
//                       },
//                       items: const [
//                         DropdownMenuItem(value: 0, child: Text("Open")),
//                         DropdownMenuItem(value: 1, child: Text("In Progress")),
//                         DropdownMenuItem(value: 2, child: Text("Closed")),
//                       ],
//                     ),
//                     TextField(
//                       controller: msgController,
//                       decoration: const InputDecoration(labelText: "Message"),
//                     ),
//                     const SizedBox(height: 12),
//                     OutlinedButton.icon(
//                       icon: const Icon(Icons.attach_file),
//                       label: const Text("Add Attachments"),
//                       onPressed: () async {
//                         final result =
//                         await FilePicker.platform.pickFiles(allowMultiple: true);
//                         if (result != null) {
//                           setState(() {
//                             selectedAttachments = result.files;
//                           });
//                         }
//                       },
//                     ),
//                     if (selectedAttachments.isNotEmpty)
//                       Column(
//                         children: selectedAttachments
//                             .map((f) =>
//                             Text(f.name, style: const TextStyle(fontSize: 12)))
//                             .toList(),
//                       ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); // فقط إغلاق
//                   },
//                   child: const Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (selectedSectionId == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Please select a section")),
//                       );
//                       return;
//                     }
//
//                     if (followUp == null) {
//                       cubit.createFollowUp(
//                         inquiryId: inquiryId,
//                         status: status,
//                         sectionId: selectedSectionId!,
//                         message: msgController.text,
//                         attachments: selectedAttachments,
//                       );
//                     } else {
//                       cubit.updateFollowUp(
//                         followupId: followUp.id,
//                         status: status,
//                         sectionId: selectedSectionId!,
//                         inquiryId: inquiryId,
//                         message: msgController.text,
//                         attachments: selectedAttachments,
//                       );
//                     }
//                     Navigator.pop(context); // إغلاق فقط
//                   },
//                   child: const Text("Save"),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = FollowUpCubit.of(context);
//     cubit.getSections();
//     cubit.getFollowupsByInquiryId(inquiryId);
//
//     return BlocListener<FollowUpCubit, FollowUpState>(
//       listener: (context, state) {
//         if (state is FollowUpSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: const [
//                   Icon(Icons.check_circle, color: Colors.white),
//                   SizedBox(width: 8),
//                   Text("The follow-up was created successfully."),
//                 ],
//               ),
//               backgroundColor: Colors.green,
//             ),
//           );
//           cubit.getFollowupsByInquiryId(inquiryId);
//         } else if (state is FollowUpError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: const [
//                   Icon(Icons.error, color: Colors.white),
//                   SizedBox(width: 8),
//                   Text("Follow-up creation failed"),
//                 ],
//               ),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       child: BlocBuilder<FollowUpCubit, FollowUpState>(
//         builder: (context, state) {
//           final open = cubit.followups.where((f) => f.status == 0).toList();
//           final inProgress =
//           cubit.followups.where((f) => f.status == 1).toList();
//           final closed =
//           cubit.followups.where((f) => f.status == 2).toList();
//
//           return Scaffold(
//             drawer: TrainDrawer(),
//             appBar: AppBar(
//               title: const Text("Follow Up"),
//             ),
//             floatingActionButton: FloatingActionButton(
//               backgroundColor: AppColor.primaryYellow,
//               child: const Icon(Icons.add, color: Colors.white),
//               onPressed: () => _showFollowUpDialog(context),
//             ),
//             body: state is FollowUpLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildColumn("Open", Colors.green, open, context),
//                 _buildColumn(
//                     "In Progress", AppColor.primaryBlue, inProgress, context),
//                 _buildColumn("Closed", AppColor.primaryRed, closed, context),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../layout/TrainDrawer.dart';
import '../../model/follow_upModel.dart';
import '../../shared/components/AppColors.dart';
import 'cubit/followUp/dart/follow_up_cubit.dart';

class ViewFollowUpScreen extends StatelessWidget {
  final int inquiryId;
  const ViewFollowUpScreen({Key? key, required this.inquiryId}) : super(key: key);

  Widget _buildColumn(
      String title, Color color, List<FollowUp> items, BuildContext context) {
    final cubit = FollowUpCubit.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            const Divider(),
            Expanded(
              child: items.isEmpty
                  ? Center(child: Text("No follow-ups", style: TextStyle(color: color)))
                  : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color,
                        child: const Icon(Icons.comment, color: Colors.white),
                      ),
                      title: Text(item.response ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Section: ${item.sectionName ?? '-'}"),
                          Text("Date: ${item.createdAt ?? ''}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: AppColor.primaryBlue),
                            onPressed: () {
                              cubit.canModify(item.id)
                                  ? _showFollowUpDialog(context, followUp: item)
                                  : _showPermissionDenied(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: AppColor.primaryRed),
                            onPressed: () {
                              if (cubit.canModify(item.id)) {
                                cubit.deleteFollowUp(
                                    followupId: item.id, inquiryId: inquiryId);
                              } else {
                                _showPermissionDenied(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPermissionDenied(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("❌You do not have the authority to edit or delete this follow-up"),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showFollowUpDialog(BuildContext context, {FollowUp? followUp}) {
    final cubit = FollowUpCubit.of(context);
    final msgController = TextEditingController(text: followUp?.response ?? '');
    int? selectedSectionId = followUp?.sectionId;
    int status = followUp?.status ?? 0;
    List<PlatformFile> selectedAttachments = [];

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                followUp == null ? "➕ Create Follow-Up" : "✏️ Edit Follow-Up",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<int>(
                      isExpanded: true,
                      value: selectedSectionId,
                      hint: const Text("Select Section"),
                      onChanged: (val) => setState(() => selectedSectionId = val),
                      items: cubit.sections
                          .map((s) => DropdownMenuItem(
                        value: s.id,
                        child: Text(s.name),
                      ))
                          .toList(),
                    ),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: status,
                      onChanged: (val) => setState(() => status = val!),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("Open")),
                        DropdownMenuItem(value: 1, child: Text("In Progress")),
                        DropdownMenuItem(value: 2, child: Text("Closed")),
                      ],
                    ),
                    TextField(
                      controller: msgController,
                      decoration: const InputDecoration(labelText: "Message"),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Add Attachments"),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                        if (result != null) {
                          setState(() => selectedAttachments = result.files);
                        }
                      },
                    ),
                    if (selectedAttachments.isNotEmpty)
                      Wrap(
                        children: selectedAttachments
                            .map((f) => Chip(label: Text(f.name)))
                            .toList(),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryBlue),
                  onPressed: () {
                    if (selectedSectionId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a section")),
                      );
                      return;
                    }
                    if (followUp == null) {
                      cubit.createFollowUp(
                        inquiryId: inquiryId,
                        status: status,
                        sectionId: selectedSectionId!,
                        message: msgController.text,
                        attachments: selectedAttachments,
                      );
                    } else {
                      cubit.updateFollowUp(
                        followupId: followUp.id,
                        status: status,
                        sectionId: selectedSectionId!,
                        inquiryId: inquiryId,
                        message: msgController.text,
                        attachments: selectedAttachments,
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = FollowUpCubit.of(context);
    cubit.getSections();
    cubit.getFollowupsByInquiryId(inquiryId);

    return BlocListener<FollowUpCubit, FollowUpState>(
      listener: (context, state) {
        if (state is FollowUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Follow-up updated successfully!"), backgroundColor: Colors.green),
          );
          cubit.getFollowupsByInquiryId(inquiryId);
        } else if (state is FollowUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("❌ Operation failed"), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocBuilder<FollowUpCubit, FollowUpState>(
        builder: (context, state) {
          final open = cubit.followups.where((f) => f.status == 0).toList();
          final inProgress = cubit.followups.where((f) => f.status == 1).toList();
          final closed = cubit.followups.where((f) => f.status == 2).toList();

          return Scaffold(
            drawer: TrainDrawer(),
            appBar: AppBar(title: const Text("Follow Up")),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primaryYellow,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _showFollowUpDialog(context),
            ),
            body: state is FollowUpLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              children: [
                _buildColumn("Open", Colors.green, open, context),
                _buildColumn("In Progress", AppColor.primaryBlue, inProgress, context),
                _buildColumn("Closed", AppColor.primaryRed, closed, context),
              ],
            ),
          );
        },
      ),
    );
  }
}
