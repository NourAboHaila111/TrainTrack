


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../sereen/Reporte/ReportsScreem.dart';
import '../sereen/auth/Profile.dart';
import '../sereen/home/HomeScreen.dart';
import '../sereen/home/HomeWidget.dart';
import '../sereen/home/InquiriesView.dart';
import '../sereen/home/SearchBar.dart';
import '../sereen/home/cubit/SearchCubit.dart';
import '../sereen/home/cubit/SearchState.cubit.dart';
import '../shared/components/AppColors.dart';
import '../shared/components/components.dart';
import '../shared/network/local/Cach_helper.dart';
import 'TrainDrawer.dart';
import 'cubit/theme_cubit.dart';

// class TrainerLayout extends StatelessWidget {
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text("Trainer WorkSpace", style: Theme.of(context).appBarTheme.titleTextStyle),
//             Spacer(),
//             Icon(Icons.person_3_rounded),
//           ],
//         ),
//       ),
//       drawer: TrainDrawer(),
//       body: ListView(
//         children: [
//           SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Container(
//               height: 40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: isDark ? Colors.grey[800] : AppColor.secondaryGrye,
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   prefixIcon: Icon(Icons.search_outlined),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               children: [
//                 Homecard(text: 'Pending', textnum: '5,666', iconColor: AppColor.mypink, icon1: Icons.pending),
//                 SizedBox(width: 30),
//                 Homecard(text: 'All', textnum: '6,777', iconColor: AppColor.primaryRed, icon1: Icons.query_builder),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text("Inquiries", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
//           ),
//           CategorySelector(),
//           Container(
//             height: 500,
//             color: Theme.of(context).scaffoldBackgroundColor,
//             child: ListView(children: [QueryTable()]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   ListTile _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
//       onTap: onTap,
//     );
//   }
// }
class TrainerLayout extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Trainer WorkSpace", style: Theme.of(context).appBarTheme.titleTextStyle),
            Spacer(),
            Icon(Icons.person_3_rounded),
          ],
        ),
      ),
      drawer: TrainDrawer(),
      body: BlocProvider(
        create: (_) => SearchInquiryCubit(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 10),
              SearchBarWidget(
                searchController: searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<SearchInquiryCubit>().searchInquiries(query: value.trim(), token: CachHelper.getData(key: 'token'));
                  }
                },
              ),

              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Homecard(text: 'Pending', textnum: '5,666', iconColor: AppColor.mypink, icon1: Icons.pending),
                    SizedBox(width: 30),
                    Homecard(text: 'All', textnum: '6,777', iconColor: AppColor.primaryRed, icon1: Icons.query_builder),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text("Inquiries", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              ),
              SizedBox(height: 10),
              CategorySelector(),
              SizedBox(height: 10),
              BlocConsumer<SearchInquiryCubit, SearchInquiryState>(
                listener: (context, state) {
                  if (state is SearchInquiryFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SearchInquiryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchInquirySuccess) {
                    return Column(
                      children: state.inquiries.map((inquiry) {
                        return QueryTable();
                      }).toList(),
                    );
                  } else {
                    return QueryTable();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeLayout extends StatelessWidget {
  final TextEditingController searchController;
  const EmployeeLayout({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            Text("Employee WorkSpace", style: Theme.of(context).appBarTheme.titleTextStyle),
            Spacer(),
            Icon(Icons.person_3_rounded),

          ],
        ),
      ),
      drawer: TrainDrawer(),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? Colors.grey[800] : AppColor.secondaryGrye,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search ',
                  suffixStyle: TextStyle(color: AppColor.secondaryGrye),
                  prefixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Homecard(text: 'pending ', textnum: '5,666', iconColor: AppColor.mypink, icon1: Icons.pending),
                SizedBox(width: 30),
                Homecard(text: 'pending ', textnum: '5,666', iconColor: AppColor.mypink, icon1: Icons.pending),
                SizedBox(width: 30),
                Homecard(text: 'all inquiries', textnum: '6.777', iconColor: AppColor.primaryRed, icon1: Icons.query_builder),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Inquiries", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
          ),
          CategorySelector(),
          Container(height: 500, color: Theme.of(context).scaffoldBackgroundColor, child: ListView(children: [QueryTable()])),
        ],
      ),
    );
  }


}
