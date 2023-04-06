import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickie_event/Constant.dart';

Widget CategoriesFeatureWidget() {
  return AnimatedContainer(
    width: width * 0.2,
    height: height * 0.1,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    duration: Duration(milliseconds: 200),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset("assets/categories/001-whisky.svg",height: 40,),
        Text(
          "Wiskhy",
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
