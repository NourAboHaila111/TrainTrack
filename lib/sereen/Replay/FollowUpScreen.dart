// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../model/SectionModel.dart';
// import '../../shared/components/AppColors.dart';
// import 'cubit/replay_inquiry_cubit.dart';
//
// class FollowUpScreen extends StatelessWidget {
//   final TextEditingController replyController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Follow-Up"),
//         backgroundColor:AppColor.primaryYellow ,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       backgroundColor: isDark ? Colors.black : Color(0xFFF6F6F6),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Text("Inquiry Title", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//
//             SizedBox(height: 10),
//
//             // Tag
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child:AnimatedSwitcher(
//                   duration: Duration(milliseconds: 300),
//                   child: DropdownButton<SectionModel>(
//                     key: ValueKey(state.selectedSection),
//                     value: state.selectedSection,
//                     onChanged: (val) {
//                       if (val != null) {
//                         context.read<ReplayInquiryCubit>().selectSection(val);
//                       }
//                     },
//                     hint:  Text("Training Section", style: TextStyle(color: AppColor.primaryBlue)),
//                     items: state.sections
//                         .map((sec) => DropdownMenuItem(
//                       value: sec,
//                       child: Text("${sec.name} (${sec.division})"),
//                     ))
//                         .toList(),
//                   ),
//                 ),
//
//             ),
//
//             SizedBox(height: 20),
//
//             // Status
//             Row(
//               children: [
//                 Icon(Icons.info_outline, color: Colors.orange),
//                 SizedBox(width: 8),
//                 Text("Status: Pending", style: TextStyle(fontSize: 16)),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             // Answer Field
//             Container(
//               height: 180,
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.8),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
//                 ],
//               ),
//               child: TextField(
//                 controller: replyController,
//                 maxLines: null,
//                 expands: true,
//                 decoration: InputDecoration.collapsed(
//                   hintText: "Write your response...",
//                 ),
//               ),
//             ),
//
//             Spacer(),
//
//             // Button with animation
//             AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               width: double.infinity,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   colors: [Colors.blueAccent, Colors.lightBlue],
//                 ),
//               ),
//               child: MaterialButton(
//                 onPressed: () {
//                   // TODO: Send follow-up logic
//                   final reply = replyController.text.trim();
//                   if (reply.isNotEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Follow-Up Sent!")));
//                   }
//                 },
//                 child: Text(
//                   "Send Follow-Up",
//                   style: TextStyle(color: AppColor.primaryBlue, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/SectionModel.dart';
import '../../shared/components/AppColors.dart';
import '../../shared/network/local/Cach_helper.dart';
import 'cubit/replay_inquiry_cubit.dart';
import 'cubit/replay_inquiry_state.dart';

class FollowUpScreen extends StatelessWidget {
  final TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (_) {
        final cubit = ReplayInquiryCubit();
        cubit.fetchSections(CachHelper.getData(key: 'token'));
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Follow-Up"),
          backgroundColor: AppColor.primaryYellow,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: isDark ? Colors.black : Color(0xFFF6F6F6),
        body: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
          child: BlocConsumer<ReplayInquiryCubit, ReplayInquiryState>(
            listener: (context, state) {
              if (state is ReplayInquiryFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is ReplayInquirySectionsLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text("Inquiry Title", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),

                    SizedBox(height: 10),

                    // القسم
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: DropdownButton<SectionModel>(
                          key: ValueKey(state.selectedSection),
                          value: state.selectedSection,
                          onChanged: (val) {
                            if (val != null) {
                              context.read<ReplayInquiryCubit>().selectSection(val);
                            }
                          },
                          hint: Text("Training Section", style: TextStyle(color: AppColor.primaryBlue)),
                          items: state.sections
                              .map((sec) => DropdownMenuItem(
                            value: sec,
                            child: Text("${sec.name} (${sec.division})"),
                          ))
                              .toList(),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange),
                        SizedBox(width: 8),
                        Text("Status: Pending", style: TextStyle(fontSize: 16)),
                      ],
                    ),

                    SizedBox(height: 20),

                    Container(
                      height: 180,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                        ],
                      ),
                      child: TextField(
                        controller: replyController,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration.collapsed(
                          hintText: "Write your response...",
                        ),
                      ),
                    ),

                    Spacer(),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlue],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                          child: ElevatedButton(
                           // color: AppColor.primaryBlue,
                            onPressed: () {
                              final section = state.selectedSection;
                              final reply = replyController.text.trim();

                              if (section != null && reply.isNotEmpty) {
                                // هنا ترسل الطلب مثل createFollowUp
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Follow-Up Sent!")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select section and write reply")));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                "Send Follow-Up",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else if (state is ReplayInquiryLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text("Loading or error occurred"));
              }
            },
          ),
        ),
      ),
    );
  }
}
