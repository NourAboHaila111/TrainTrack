import 'package:flutter/material.dart';

import '../../shared/components/AppColors.dart';

class Replayinquiriesscreen extends StatelessWidget {
  final TextEditingController answerController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Inquiries",textAlign:TextAlign.start, style: TextStyle(color: AppColor.primaryBlue,fontSize: 20,fontWeight:FontWeight.w600),),


      ),
      backgroundColor: AppColor.secondaryGrye,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
             Text(" Inquiries detalis",textAlign:TextAlign.start, style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.w400),),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 250,
                width: 350,

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: AppColor.primaryWhait,),
                child:ListView(children: [],) ,)),
              SizedBox(height: 30,),
              Text(" your answer",textAlign:TextAlign.start, style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.w400),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 250, // ارتفاع الحقل
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.primaryWhait,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: answerController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // عدد غير محدود من الأسطر
                  expands: true, // يملأ كامل المساحة المتوفرة داخل الـ Container
                  style: TextStyle(fontSize: 16),
                  textAlignVertical: TextAlignVertical.top, // يبدأ من الأعلى
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'write here...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryBlue, width: 2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
