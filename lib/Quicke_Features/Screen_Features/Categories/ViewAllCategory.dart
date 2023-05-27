import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';

import '../../providers/HomeProviders.dart';

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
          child: Consumer<HomeProvider>(builder: (context, person, child) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
              ),
              itemCount: person.getMyCategories!.data!.length,
              itemBuilder: (context, i) {
                return CategoriesFeatureWidget(
                    image:person.getMyCategories
                        ?.data![i].media !=null && person.getMyCategories!.data![i].media!.isNotEmpty ?
                    person.getMyCategories
                        ?.data![i].media![0].url
                        .toString():"abc",
                    title: person.getMyCategories
                        ?.data![i].name
                        .toString());
              },
            );
          }),
        ),
      ),
    );
  }
}
