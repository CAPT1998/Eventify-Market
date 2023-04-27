import 'package:flutter/material.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';

class ViewAllCategories extends StatefulWidget {
  const ViewAllCategories({super.key});

  @override
  State<ViewAllCategories> createState() => _ViewAllCategoriesState();
}

class _ViewAllCategoriesState extends State<ViewAllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoriesFeatureWidget(image: "001-whisky", title: "Wiskhy"),
                  CategoriesFeatureWidget(
                      image: "002-tequila", title: "Tequila"),
                  CategoriesFeatureWidget(
                      image: "003-cigarro", title: "Cigarro"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoriesFeatureWidget(
                      image: "004-cigarrillos", title: "Cigarrillos"),
                  CategoriesFeatureWidget(image: "005-ron", title: "Ron"),
                  CategoriesFeatureWidget(image: "006-vodka", title: "Vodka"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoriesFeatureWidget(
                      image: "007-cerveza", title: "Cerveza"),
                  CategoriesFeatureWidget(
                      image: "008-vaso-de-plastico", title: "Vaso"),
                  CategoriesFeatureWidget(
                      image: "009-softdrinks", title: "SoftDrink"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CategoriesFeatureWidget(image: "010-bag", title: "Bag"),
            ],
          ),
        ),
      ),
    );
  }
}
