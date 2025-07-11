
import 'package:flutter/material.dart';

import 'AppColors.dart';
// import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  required double width,
  Color? BackGround = null,
  Color? fontColor,
  required void Function() function,
  required String text,
}) => Container(
  decoration: BoxDecoration(
    color: BackGround != null ? BackGround :null,
    gradient: BackGround == null ? LinearGradient(
      colors: [
        Color.fromRGBO(70, 110, 181, 1),
        Color.fromRGBO(60, 0, 128, 0.6),
      ],
      begin: Alignment.topLeft,
      end: Alignment.topRight,
    ):null,
    borderRadius: BorderRadius.circular(15.0),
  ),
  width: width,
  child: MaterialButton(
    textColor: fontColor,
    onPressed:function,
    child: Text(text.toUpperCase(),style: TextStyle(color: AppColor.primaryWhait),),
  ),
);
//

Widget defaultinsideButton({
  required double width,
  Color? background,
  Color ? fontColor,
  required void Function() function,
  required String text,

}) => Container(
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(15.0),
  ),
  width: width,
  child: MaterialButton(
    textColor: fontColor,
    onPressed:function,
    child: Text(text.toUpperCase(),),
  ),
);

Widget defaultTextButton({
  required Function() ? function,
  required String text,
  required Color textcolor,
})=>TextButton(
  onPressed: function,
  child:Text(
    text,
    style: TextStyle(
      color: textcolor,
      //fontWeight: FontWeight,
      fontSize: 15,
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  void Function(String)? onsubmit,
  void Function(String)? onchange,
  bool obscuretext=false,
  String? Function(String?)? validate,
  required String label,
  String ? labelText,
  required IconData prefix,
  void Function()? prefixpressed,
  IconData? suffix,
  void Function()? suffixpressed,
  void Function()? onTap,
  Color? color,
  bool? filled,
  Color? fillColor,
  String ? initialValue

})=>TextFormField(
  initialValue: initialValue,
  controller:  controller,
  onFieldSubmitted: onsubmit,
  onChanged: onchange,
  obscureText: obscuretext,
  keyboardType: type,
  validator: validate,
  onTap: onTap,
  decoration:InputDecoration(
    labelText:labelText ,
    hintText: label,
    prefixIcon: prefix != null ? IconButton(
      onPressed:prefixpressed,
      icon: Icon(
        prefix,
      ),
    ) :null,
    suffixIcon:suffix != null? IconButton(
      onPressed:suffixpressed,
      icon: Icon(
        suffix,
      ),
    ) :null,
    border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      // borderSide: BorderSide.none ,
    ),
    fillColor: fillColor,
    filled: filled,
  ),
);

enum stateColor {ERROR,SUCCESS,WARNING}
Color setStateColor(state){
  Color ? color  ;
  switch (state)
  {
    case stateColor.SUCCESS :
      color = Colors.green;
      break;
    case stateColor.ERROR:
      color = Colors.red;
      break;
    case stateColor.WARNING:
      color = Colors.yellow;
      break;
    default:
      color=Colors.white;
  }
  return color ;
}
SnackBar defaultSnackbar({
  required String text,
  required stateColor state
})=>
    SnackBar(
      content:Center(child: Text( text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,)) ,),
      duration: Duration(seconds: 3),
      backgroundColor: setStateColor(state),
      elevation: 8,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );


void navigateAndFinish(context, Widget,)=>
    Navigator.pushAndRemoveUntil
      (
      context,
      MaterialPageRoute(
          builder: (context)=>Widget),
          (route)
      {
        return false;
      },
    );

Widget myDivider () =>  Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 30,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[400],
  ),
);
Widget Homecard({

  Color? iconColor,
  IconData? icon1,
  //String? text,
 // required void Function() function,
  required String text,
  required String textnum,
}) => Container(
  height: 50,
  width: 100,
  child:Row(
    children: [
      SizedBox(width: 5,),
      Icon(icon1 ,color: iconColor,size: 40,),
      //SizedBox(width: 10,),
      Column(
        children: [
          //SizedBox(height: 18,),
          Text(text,textAlign:TextAlign.center, style: TextStyle(fontSize: 8,fontWeight:FontWeight.w300),),
         // SizedBox(height: 10,),
          Text(textnum,textAlign:TextAlign.center, style: TextStyle(fontSize: 13,fontWeight:FontWeight.w300),),
        ],
      ),
    ],
  ) ,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    //color: AppColor.primaryWhait,
     border: Border.all(color: AppColor.secondaryGrye, width: 2),
  ),
);

void  navigateTo(context,Widget)=> Navigator.push(
  context,
  MaterialPageRoute(
      builder:(context) => Widget
  ),
);
// Future<bool?> showToast2(String message, String state) async {
//   Color bgColor;
//   switch (state) {
//     case 'success':
//       bgColor = Colors.green;
//       break;
//     case 'error':
//       bgColor = Colors.red;
//       break;
//     case 'warning':
//       bgColor = Colors.orange;
//       break;
//     default:
//       bgColor = Colors.blueGrey;
//   }
//
//   return Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: bgColor,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }
// //
// void showToast({
//   required String text,
//   required ToastStates states,
// })=> Fluttertoast.showToast(
//   msg:text,
//   toastLength: Toast.LENGTH_LONG,
//   gravity: ToastGravity.BOTTOM,
//   timeInSecForIosWeb: 5,
//   backgroundColor:chooseToastColor(states),
//   textColor: Colors.white,
//   fontSize: 16.0,
// );
//
// // //
// enum ToastStates{SUCCESS,ERROR,WARING}
//
//
// Color? chooseToastColor(ToastStates state)
// {
//   Color? color;
//   switch(state){
//     case ToastStates.SUCCESS:
//       color= Colors.green;
//       break;
//     case ToastStates.ERROR:
//       color= Colors.red;
//       break;
//     case ToastStates.WARING:
//       color= Colors.amber;
//       break;
//   }
//   return color;
// }


Widget buildArticalItem(artical,context)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30) ,
          image: DecorationImage(
              image:artical['urlToImage']!=null ? NetworkImage('${artical['urlToImage']}') : NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkRQlBc2mf3iGQ3nWCt46Z5UA15-gGDromOiPz7w5QZw&s'),
              fit:BoxFit.fill
          ),
        ),

      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              //AppCubit.get(context).ismode==true?
              Text(
                '${artical['title']}',
                //style:Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${artical['description']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],),
        ),
      ),
    ],
  ),
);


// Widget articalBuilder(list,context,{issearch=false}) => ConditionalBuilder(
//   condition: list.length>0 ,
//   builder: (context) => ListView.separated(
//     physics: BouncingScrollPhysics(),
//     itemBuilder: (context, index) => buildArticalItem(list[index],context),
//     separatorBuilder: (context, index) =>myDivider() ,
//     itemCount: 10,
//   ),
//   fallback: (context) => issearch ?Container():Center(
//     child: CircularProgressIndicator(),
//   ),
// );

Widget reausableMaterialButton({
  required void Function()? function,
  double? width,
  double ?height,
  required String text,
  Color? color,
  required Color? colortext,
}) =>
    Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: MaterialButton(
          onPressed: function,
          child: Text(
            text.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colortext,
              fontSize: 17,
            ),
          ),
        ));
//apikey=a67dcaee15cd4028803d5aaed502617a