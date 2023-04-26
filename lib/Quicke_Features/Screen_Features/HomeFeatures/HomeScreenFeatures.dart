import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/Categories/ProductScreen.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CourselSliderFeatures/CourselSliderFeaturesWidget.dart';

import '../Notification/NotificationScreen.dart';

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
          IconButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: NotificationScreen(),
                  withNavBar: false,
                );
              },
              icon: Icon(Icons.notifications_on))
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
            CourselSliderFeatures(context),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: ProductScreen(),
                                  withNavBar: false,
                                );
                              },
                              child: CategoriesFeatureWidget(
                                  image: "001-whisky", title: "Wiskhy"),
                            ),
                            CategoriesFeatureWidget(
                                image: "002-tequila", title: "Tequila"),
                            CategoriesFeatureWidget(
                                image: "003-cigarro", title: "Cigarro"),
                            CategoriesFeatureWidget(
                                image: "004-cigarrillos", title: "Cigarrillos"),
                            CategoriesFeatureWidget(
                                image: "005-ron", title: "Ron"),
                            CategoriesFeatureWidget(
                                image: "006-vodka", title: "Vodka"),
                            CategoriesFeatureWidget(
                                image: "007-cerveza", title: "Cerveza"),
                            CategoriesFeatureWidget(
                                image: "008-vaso-de-plastico", title: "Vaso"),
                            CategoriesFeatureWidget(
                                image: "009-softdrinks", title: "SoftDrink"),
                            CategoriesFeatureWidget(
                                image: "010-bag", title: "Bag"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Wiskhy",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ron",
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
              ],
            ),
            CourselSliderFeatures(context),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vodka",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vino",
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
          ],
        ),
      ),
    );
  }
}

Widget _products() {
  return Container(
    width: width * 0.43,
    height: height * 0.3,
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
