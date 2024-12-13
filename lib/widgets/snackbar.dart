import 'package:flutter/material.dart';
import 'package:snap/colorTheme.dart';
import 'package:snap/essentials.dart';

openPrimarySnackBar(context, String text, {color = AppColors.dark}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: Duration(milliseconds: 2500),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: e.text(text,color: Colors.white,align: TextAlign.left),
          ),
        ],
      ),
  ));
}
