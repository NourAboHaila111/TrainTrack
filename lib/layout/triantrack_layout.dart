import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../sereen/Reporte/ReportsScreem.dart';
import '../sereen/home/HomeScreen.dart';
import '../sereen/home/HomeWidget.dart';
import '../sereen/home/InquiriesView.dart';
import '../shared/components/AppColors.dart';
import '../shared/components/components.dart';

class TrainerLayout extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
   String assetName = 'assets/images/logo.svg';


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final Widget svgIcon =SvgPicture.asset(
      'assets/images/logo.svg',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
    return Scaffold(
      backgroundColor: AppColor.secondaryGrye,
      appBar: AppBar(

        backgroundColor: AppColor.primaryYellow,
        title: Row(
          children: [
            Text("Home"
              ,
              style: TextStyle(color: Colors.white,fontSize: 25,fontWeight:FontWeight.w600),
            ),
            SizedBox(width: 90,),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: AppColor.secondaryGrye,),
             // color: AppColor.primaryWhait,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for inquiries',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 15,),
                  prefixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor:Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColor.primaryYellow),
              child: Column(
                children: [
                 // Image.asset('assets/images/logo.svg'),
       //// const String assetName = 'assets/images/logo.svg';
                  Image.asset(
                    'assets/images/logo-2.png',
                    width: 250,
                    height: 100,
                    fit: BoxFit.contain,
                  ),


                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,color:AppColor.primaryBlue),
              title: Text('Home', style: TextStyle(color: AppColor.primaryBlue,fontSize: 20,fontWeight:FontWeight.w500),),
              onTap: () {
                navigateTo(context, HomeScreen(role: 'Employee'));
              },
            ),
            ListTile(
              leading: Icon(Icons.person,color:AppColor.primaryBlue),
              title:Text(" Inquiries", style: TextStyle(color: AppColor.primaryBlue,fontSize: 20,fontWeight:FontWeight.w500),),

      onTap: () {
        navigateTo(context, HomeScreen(role: 'Employee'));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,color:AppColor.primaryBlue ,),
              title: Text('Reports', style: TextStyle(color: AppColor.primaryBlue,fontSize: 20,fontWeight:FontWeight.w500),),
              onTap: () {
                navigateTo(context, ReportsScreen());
              },
            ),
          ],
        ),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                //
                Homecard(text: 'pending inquiries', textnum: '5,666',iconColor: AppColor.mypink,
                    icon1: Icons.pending),
                SizedBox(width: 30,),
                Homecard(text: 'all inquiries', textnum: '6.777',iconColor: AppColor.primaryRed,
                icon1: Icons.query_builder),
              ],

            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(" Inquiries",textAlign:TextAlign.start, style: TextStyle(color: AppColor.primaryBlue,fontSize: 20,fontWeight:FontWeight.w600),),
          ),

          CategorySelector(),
Container(
  height: 500,
  color: AppColor.primaryWhait,
  child:ListView(children: [QueryTable()],) ,),
        ],
      ),
    );
  }
}

class EmployeeLayout extends StatelessWidget {
  final TextEditingController searchController;

  const EmployeeLayout({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryGrye,
      appBar: AppBar(
        backgroundColor: AppColor.primaryYellow,
        title: Row(
          children: [
            Text("Employee Home", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)),
            Spacer(),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.secondaryGrye,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search inquiries',
                  prefixIcon: Icon(Icons.search_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColor.primaryYellow),
              child: Image.asset('assets/images/logo-2.png', width: 250, height: 100),
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppColor.primaryBlue),
              title: Text('Home', style: TextStyle(color: AppColor.primaryBlue, fontSize: 20, fontWeight: FontWeight.w500)),
              onTap: () => navigateTo(context, HomeScreen(role: 'Employee')),
            ),
            ListTile(
              leading: Icon(Icons.person, color: AppColor.primaryBlue),
              title: Text("Inquiries", style: TextStyle(color: AppColor.primaryBlue, fontSize: 20, fontWeight: FontWeight.w500)),
              onTap: () => navigateTo(context, HomeScreen(role: 'Employee')),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: AppColor.primaryBlue),
              title: Text('Reports', style: TextStyle(color: AppColor.primaryBlue, fontSize: 20, fontWeight: FontWeight.w500)),
              onTap: () => navigateTo(context, ReportsScreen()),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Homecard(text: 'pending inquiries', textnum: '5,666', iconColor: AppColor.mypink, icon1: Icons.pending),
                SizedBox(width: 30),
                Homecard(text: 'all inquiries', textnum: '6.777', iconColor: AppColor.primaryRed, icon1: Icons.query_builder),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Inquiries", textAlign: TextAlign.start, style: TextStyle(color: AppColor.primaryBlue, fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          CategorySelector(),
          Container(height: 500, color: AppColor.primaryWhait, child: ListView(children: [QueryTable()])),
        ],
      ),
    );
  }
}
