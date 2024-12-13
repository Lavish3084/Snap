import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:snap/colorTheme.dart';
import 'package:snap/main.dart';


class Essentials{
  static appBar({title,actions=null,leading=false,double height=50,center=false}){
    return AppBar(title: Image.asset('assets/images/logo-white.png',height: 30,),centerTitle: center,toolbarHeight: height,
      leading: (leading)?IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.disableGreyColor), // Icon for the back button
        onPressed: () {
          Navigator.pop(navigatorKey.currentContext!); // This will pop the current route off the navigator stack
        },
      ):null,
      forceMaterialTransparency: false,
      actions: actions,
      backgroundColor: Colors.black,
      foregroundColor: Colors.black,);
  }
  static logo({padding=3.0,double width=120}){
    return Padding(padding: EdgeInsets.only(top: padding),child: Image.asset('assets/images/logo-white.png',width: width,),);
  }

}

class Helpers{
  static dateToEpoch(v){
    DateTime parsedDate = DateTime.parse(v);
    int epochTime = parsedDate.millisecondsSinceEpoch;
    return epochTime;
  }
}

class e{
  static spacer({double height=10.0,double width=0}){
    return SizedBox(height: height,width: width,);
  }
  static title(e,{double fontSize=18.0,align=TextAlign.center,double height=1.8}){
    return Text(e,textAlign: align,style: TextStyle(fontFamily: 'Poppins',fontSize: fontSize,fontWeight: FontWeight.w600,height: height),);
  }
  static text(e,{double fontSize=14.0,align=TextAlign.left,color=AppColors.disableGreyColor,weight=FontWeight.w500}){
    return Text(e,textAlign: align,style: TextStyle(fontFamily: 'Poppins',fontSize: fontSize,color:color,fontWeight: weight));
  }
  static subtitle(e,{double fontSize=16.0,align=TextAlign.center,color=AppColors.disableGreyColor,weight=FontWeight.w500,double height=1.7}){
    return Text(e,textAlign: align,style: TextStyle(fontFamily: 'Poppins',fontSize: fontSize,color:color,fontWeight: weight,height: height));
  }

  static dropdown(title, {controller, options,onChange}) {
    final dropdownOptions = ["select a value", ...(options ?? [])];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: e.text(
            title,
            align: TextAlign.left,
            weight: FontWeight.bold,
          ),
        ),
        e.spacer(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 12,right: 8, top: 3, bottom: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.borderGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: dropdownOptions.contains(controller.text)
                  ? controller.text
                  : "select a value",
              items: dropdownOptions.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: e.text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                onChange(newValue);
              },
              isExpanded: true,
              underline: SizedBox(), // To remove the underline
            ),
          ),
        ),
      ],
    );
  }


  static Widget card(text,{padding=const EdgeInsets.only(top: 7, bottom: 7, left: 14, right: 14)}){
    return Container(
      margin: EdgeInsets.only(left: 2,right: 2,bottom: 2),
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: .5, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 1), // Shadow position
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: AppColors.borderGrey, ),
      ),
      child: e.text(text, color: Colors.blueGrey, weight: FontWeight.w600,),
    );
  }

  static PopupMenuItem menuItem(t,{icon}){
    return PopupMenuItem(
      child: ListTile(
        leading: (icon!=null)?Icon(icon, color: Colors.blueGrey):null,
        title: Text(
          t,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  static container(child,{double h=12,double elevation=2.0,double radius=12.0,double v=12,color=Colors.white}){
    return Container(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.only(top: 3,bottom: 3),
          color: color,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: v,right: v,bottom: h,top: h),
            child: child,)),
    );
  }

  static goTo(ctx,page){
    return Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=>page));
  }

  static replace(ctx,page){
    return Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>page),(_)=>false);
  }

  static button(e, {onPress,color=AppColors.primaryColorBlack,textColor=Colors.black,double height=54.0,load=false}) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, height)),
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            side: BorderSide.none, // Removes the border
          ),
        ),
      ),
      onPressed: (!load)?onPress:(){},
      child: load?LoadingAnimationWidget.threeRotatingDots(
        color: textColor,
        size: 32,
      ):text(e,color: textColor,fontSize: 14),
    );
  }

  static button2(t, {onPress,double width=double.infinity,color=AppColors.dark,double padding=14,double radius=12}){
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: padding, bottom: padding),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 8, // Blur radius
              offset: Offset(0, 3), // Shadow position
            ),
          ],
          border: Border.all(
            color: color, // Border color
            width: 1.5, // Border width
          ),
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: e.text(t,align: TextAlign.center,color: color,weight: FontWeight.w600),
      ),
    );
  }

  static pickDate(context,{controller}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  static bottomSheet(children,{double horizontal=0,}){
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, controller) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(22)),
              child: ListView(children: [
                Center(child: Container(margin: EdgeInsets.only(top: 16),width: 140,height: 5,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(40)),)),
                ...children
              ],));
        },
      ),
    );
  }
}