import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/AppColors.dart';
import 'cubit/HomeCubit.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<String> categories = ['All','Opened','Closed','Pending',];
  int selectedIndex = 0; // أول عنصر هو المختار


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
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
                BlocProvider.of<InquiriesCubit>(context).filterInquiries(categories[index]);

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
