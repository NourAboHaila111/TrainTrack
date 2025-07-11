
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/shared/components/AppColors.dart';
import 'package:triantrak/shared/components/components.dart';

import '../../layout/TrainDrawer.dart';
import '../../model/SectionModel.dart';
import '../../shared/network/local/Cach_helper.dart';
import 'FollowUpScreen.dart';
import 'cubit/replay_inquiry_cubit.dart';
import 'cubit/replay_inquiry_state.dart';

class Replayinquiriesscreen extends StatelessWidget {
  final Map<String, String> inquiry;
  final int tagIndex;

  final TextEditingController answerController = TextEditingController();

  Replayinquiriesscreen({required this.inquiry, required this.tagIndex});

  String _normalizeStatus(String status) {
    switch (status.toLowerCase()) {
      case 'opened':
        return 'Open';
      case 'closed':
        return 'Closed';
      case 'pending':
        return 'Pending';
      default:
        return 'Open';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initialStatus = _normalizeStatus(inquiry['status'] ?? 'Open');

    return BlocProvider(
      create: (_) {
        final cubit = ReplayInquiryCubit();
        cubit.emitStatus(initialStatus);
        cubit.fetchSections( CachHelper.getData(key:'token'),);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Inquiries")),
        drawer: TrainDrawer(),
        body: BlocConsumer<ReplayInquiryCubit, ReplayInquiryState>(
          listener: (context, state) {
            if (state is ReplayInquirySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is ReplayInquiryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is ReplayInquirySectionsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              inquiry['title'] ?? '',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.category, size: 18, color: Colors.grey),
                                SizedBox(width: 5),
                                Text("Category: ${inquiry['category'] ?? '--'}"),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.flag, size: 18, color: Colors.grey),
                                SizedBox(width: 5),
                                Text("Status: ${inquiry['status'] ?? '--'}"),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.confirmation_number, size: 18, color: Colors.grey),
                                SizedBox(width: 5),
                                Text("ID: ${inquiry['id'] ?? '--'}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    // AnimatedSwitcher(
                    //   duration: Duration(milliseconds: 300),
                    //   child: DropdownButton<SectionModel>(
                    //     key: ValueKey(state.selectedSection),
                    //     value: state.selectedSection,
                    //     onChanged: (val) {
                    //       if (val != null) {
                    //         context.read<ReplayInquiryCubit>().selectSection(val);
                    //       }
                    //     },
                    //     hint: Text("اختر القسم"),
                    //     items: state.sections
                    //         .map((sec) => DropdownMenuItem(
                    //       value: sec,
                    //       child: Text("${sec.name} (${sec.division})"),
                    //     ))
                    //         .toList(),
                    //   ),
                    // ),

                    SizedBox(height: 20),
                    TextField(
                      controller: answerController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "اكتب الرد...",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DropdownButton<String>(
                              key: ValueKey(state.selectedStatus),
                              value: state.selectedStatus,
                              dropdownColor: AppColor.primaryBlue,
                              onChanged: (val) {
                                if (val != null) {
                                  context.read<ReplayInquiryCubit>().emitStatus(val);
                                }
                              },
                              items: ['Open', 'Closed', 'Pending']
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e,)))
                                  .toList(),
                            ),

                          ),
                        ),

                        SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                          //   final section = state.selectedSection;
                          //   if (section != null) {
                          //     context.read<ReplayInquiryCubit>().createFollowUp(
                          //       inquiryId: int.tryParse(inquiry['id'] ?? '') ?? 0,
                          //       sectionId: section.id,
                          //       token: CachHelper.getData(key:'token'),
                          //       answer: answerController.text.trim(),
                          //       status: state.selectedStatus,
                          //     );
                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text("يرجى اختيار القسم")),
                          //     );
                          //   }
                          //
                            navigateTo(context, FollowUpScreen());
                          },
                          child: Text("follow up"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ReplayInquiryLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("جار التحميل أو حدث خطأ"));
            }
          },
        ),
      ),
    );
  }
}
