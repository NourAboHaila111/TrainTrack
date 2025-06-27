import 'package:flutter/material.dart';
import 'package:triantrak/shared/components/AppColors.dart';

import '../../shared/components/components.dart';
import '../Replay/ReplayInquiriesScreen.dart';

class QueryTable extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Open',
      'category': 'ADS',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Open',
      'category': 'Cash Mobile',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Closed',
      'category': 'MTN Speed',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Pending',
      'category': 'MTN TV',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Pending',
      'category': 'iMTN',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Closed',
      'category': 'RBT',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Pending',
      'category': 'Roaming',
    },
    {
      'title': 'هل يتم تفعيل..',
      'status': 'Open',
      'category': 'Gift balance',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 25,
        headingRowColor: MaterialStateProperty.all(AppColor.primaryWhait),
        columns: const [
         // DataColumn(label: Text('ID',style:TextStyle(color: AppColor.primaryGrye),)),
          DataColumn(label: Text('Title',style:TextStyle(color: AppColor.primaryGrye),)),
          DataColumn(label: Text('Status',style:TextStyle(color: AppColor.primaryGrye),)),
          DataColumn(label: Text('Category',style:TextStyle(color: AppColor.primaryGrye),)),
          DataColumn(label: Text('Reply',style:TextStyle(color: AppColor.primaryGrye),)),

        ],
        rows: data.map((item) {
          return DataRow(cells: [
            //DataCell(Text(item['id']!)),
            DataCell(Text(item['title']!)),
            DataCell(Container(width: 65, decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),color: AppColor.primaryBlue),child: Text(item['status']!,style:TextStyle(color: AppColor.primaryWhait),textAlign: TextAlign.center,))),
            DataCell(Text(item['category']!)),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  navigateTo(context,Replayinquiriesscreen());
                  // Reassign action
                },
                child: Text('Reply'),
              ),
            ),

          ]);
        }).toList(),
      ),
    );
  }
}
