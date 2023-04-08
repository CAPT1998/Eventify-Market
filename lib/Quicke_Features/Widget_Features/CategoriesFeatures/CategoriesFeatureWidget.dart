import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickie_event/Constant.dart';

Widget CategoriesFeatureWidget({required String image,required String title}) {
  return AnimatedContainer(
    margin: EdgeInsets.only(right: 10),
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
        SvgPicture.asset("assets/categories/$image.svg",height: 40,),
        Text(
          "$title",
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
