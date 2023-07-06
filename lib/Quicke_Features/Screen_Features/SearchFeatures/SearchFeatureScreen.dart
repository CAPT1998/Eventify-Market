import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../../Quicke_Events/Widgets/SizedBoxWidget.dart';
import '../../Model/ProductDetailResponseModel.dart';
import '../../Model/ProductScreenResponseModel.dart';
import '../../providers/HomeProviders.dart';
import '../barcodescannerFeatures/scanner.dart';

class SearchFeatureScreen extends StatefulWidget {
   String productId;
   SearchFeatureScreen(this.productId,{super.key});

  @override
  State<SearchFeatureScreen> createState() => _SearchFeatureScreenState();
}

class _SearchFeatureScreenState extends State<SearchFeatureScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> _filteredListReviews2 = [];
  List<Categories> _filteredListReviews = [];

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
                    width: width * 0.7,
                    child: textfieldProduct(
                      context: context,
                      name: "Search events",
                      onChanged: (value) {
                        _filteredListReviews2 =
                            Provider.of<HomeProvider>(context, listen: false)
                                .getProductDetailScreenData!
                                .product!;
                        _filteredListReviews =
                            Provider.of<HomeProvider>(context, listen: false)
                                .getProductScreenData!
                                .data!
                                .categories!
                                .where((element) => element.name!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                        setState(() {});
                      },
                      controller: _searchController,
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: QrScanner(),
                          withNavBar: false,
                        );
                      },
                      icon: Icon(Icons.qr_code_scanner_rounded)),
                  for (Product product in _filteredListReviews2)
                    _NearWidget2(product: product),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // _NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
              //_NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
              //_NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _NearWidget2({required Product product}) {
  return Container(
    width: width,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 2,
          offset: Offset(0, 2),
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 2),
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
          child: Image.asset(
            "assets/img/Bitmap.png",
            height: height * 0.08,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              product.description.toString(),
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
              "\$ ${product.price}",
              style: TextStyle(
                color: Color(0xFF00ADF4),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "",
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
