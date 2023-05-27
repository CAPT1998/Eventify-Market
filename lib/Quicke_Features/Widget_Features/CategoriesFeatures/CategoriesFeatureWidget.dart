import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickie_event/Constant.dart';

Widget CategoriesFeatureWidget({ String? image, String? title}) {
  return AnimatedContainer(
    padding: EdgeInsets.all( 10),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    duration: Duration(milliseconds: 200),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Image.network(
                image!,
                errorBuilder:
                    (context, url, error) =>
                    Image.asset(
                      "assets/img/placeholder.jpg",
                      fit: BoxFit.cover,
                      height: height * 0.1,
                    ),
              )),
        ),
         SizedBox(height: 10,),
         Expanded(
           flex: 1,
           child: Text(
              "$title",
              overflow: TextOverflow.ellipsis,

        ),
         ),
      ],
    ),
  );
}

/*ClipRRect(
            borderRadius:
            BorderRadius.circular(20),
            child: Image.network(
              image,
              height: height * 0.2,
              fit: BoxFit.fill,
              errorBuilder:
                  (context, url, error) =>
                  Image.asset(
                    "assets/img/placeholder.jpg",
                    fit: BoxFit.cover,
                    height: height * 0.2,
                  ),
            )),*/
