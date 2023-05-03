import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: appColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: textfieldProduct(
                          context: context,
                          name: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.document_scanner_outlined,
                            color: appColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                      _products(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _products() {
  return Container(
    width: width * 0.43,
    // height: height * 0.3,
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Color(0XFFA2AAB8).withOpacity(0.25),
          )
        ]),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/img/Bitmap.png",
              width: width * 0.42,
              height: height * 0.15,
              fit: BoxFit.contain,
            ),
            Positioned(
                right: 5,
                top: 5,
                child: FavoriteButton(
                  iconSize: 40,
                  isFavorite: true,
                  valueChanged: (_isFavorite) {
                    print('Is Favorite $_isFavorite)');
                  },
                ))
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          width: width * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Samsung 4K LED Ultarafine Tv",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "\$320.00",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "-30%",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF12B39A),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.remove_circle_outline,
                  color: Color(0XFFB8BCBF),
                ),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.add_circle_outline_outlined,
                  color: Color(0XFFB8BCBF),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
