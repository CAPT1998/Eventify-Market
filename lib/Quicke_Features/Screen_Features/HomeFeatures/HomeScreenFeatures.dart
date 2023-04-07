import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CourselSliderFeatures/CourselSliderFeaturesWidget.dart';

class HomeScreenFeatures extends StatefulWidget {
  const HomeScreenFeatures({super.key});

  @override
  State<HomeScreenFeatures> createState() => _HomeScreenFeaturesState();
}

class _HomeScreenFeaturesState extends State<HomeScreenFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "􀆬 MI CASA",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Express Shopping",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_on))
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColor,
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
            CourselSliderFeatures(),
           
            Stack(
              children: [
                Container(
                  height: height * 0.17,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0XFF00ADF4).withOpacity(0.5),
                      Color(0XFFFFFFFF).withOpacity(0.0),
                    ],
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categorias",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Ver Todos",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF828588),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoriesFeatureWidget(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
