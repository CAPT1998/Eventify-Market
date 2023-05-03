import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../../Quicke_Events/Widgets/SizedBoxWidget.dart';

class SearchFeatureScreen extends StatefulWidget {
  const SearchFeatureScreen({super.key});

  @override
  State<SearchFeatureScreen> createState() => _SearchFeatureScreenState();
}

class _SearchFeatureScreenState extends State<SearchFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeWidget(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: textfieldProduct(
                      context: context,
                      name: "Search events",
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Icon(Icons.qr_code_scanner_rounded)
                ],
              ),
              
              SizedBox(
                height: 20,
              ),
              _NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
              _NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
              _NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _NearWidget(
    {required String img, required String title, dynamic color}) {
  return Container(
    // height: height * 0.13,
    width: width,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 5,
    ),
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
          spreadRadius: 0,
          blurRadius: 2,
          offset: Offset(0, 2),
          color: Colors.grey.withOpacity(0.5))
    ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  color: Colors.grey.withOpacity(0.5))
            ]),
            child: Image.asset(
              "assets/img/Bitmap.png",
              height: height * 0.08,
            )),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Name",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Description".toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\$ 10",
              style: TextStyle(
                color: Color(0XFF00ADF4),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Phone".toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
