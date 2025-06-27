import 'package:flutter/material.dart';

import '../../shared/components/AppColors.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> categories = ['All', '  Open', '  Close', 'Pending',];
  int selectedIndex = 0; // أول عنصر هو المختار


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // نفّذ الإجراء المطلوب هنا، مثلاً تحميل بيانات التصنيف
              // controller.gotoitems(controller.catogry, index);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: isSelected
                    ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3, color: AppColor.primaryBlue),
                  ),
                )
                    : null,
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'font1',
                      color:isSelected?  AppColor.primaryBlue:AppColor.primaryGrye ,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
