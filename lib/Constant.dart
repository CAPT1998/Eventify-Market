import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Color appColor = Color(0XFF00ADF4);
Color greyColor = Color(0XFF393E51);
Color greenColor = Color(0XFF2FBD6A);
Color purpleColor = Color(0XFF6927FF);
Color yellowColor = Color(0XFFFFD84A);
Color blueColor = Color(0XFF2473F2);
Color lightGreyColor = Color.fromARGB(255, 230, 230, 230);
Color darkPurpleColor = Color(0XFF4A49EA);

double height = height;
double width = width;



Widget ErrorFlushbar(BuildContext context, String title, String message) {
  return Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.close,
      size: 28.0,
      color: Colors.red,
    ),
    margin: EdgeInsets.all(6.0),
    backgroundColor: Colors.black,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(15),
    duration: Duration(milliseconds: 1900),
    leftBarIndicatorColor: Colors.red,
  )..show(context);
}

Widget SuccessFlushbar(BuildContext context, String title, String message) {
  return Flushbar(
    title: title,
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Color(0xFF217D41),
    ),
    margin: EdgeInsets.all(6.0),
    backgroundColor: Colors.black,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(15),
    duration: Duration(milliseconds: 1900),
    leftBarIndicatorColor: Color(0xFF217D41),
  )..show(context);
}
