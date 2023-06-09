import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';

import '../../Model/ProductDetailResponseModel.dart';
import '../../providers/HomeProviders.dart';
import '../ProductDetail/ProductDetailScreen.dart';

class ProductScreen extends StatefulWidget {
  String productId;

  // String type;
  ProductScreen(this.productId, {super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController? _searchController;

  List<Product>? _filteredListReviews = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    // _filteredListReviews = widget.filteredListReview.products!;
  }

  @override
  Widget build(BuildContext context) {
    print("Product id: " + widget.productId);
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
                        controller: _searchController,
                        onChanged: (value) {
                          _filteredListReviews =
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getProductDetailScreenData!
                                  .product!
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                          setState(() {});
                        },
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
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: Provider.of<HomeProvider>(context, listen: false)
                      .getProductDetailScreenDate(widget.productId),
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (dataSnapshot.error != null) {
                        return Center(
                          child: Text('An error occured' +
                              dataSnapshot.error.toString()),
                        );
                      } else {
                        return Consumer<HomeProvider>(
                            builder: (context, person, child) {
                          if (_searchController!.text.isEmpty) {
                            _filteredListReviews =
                                person.getProductDetailScreenData!.product;
                          }
                          return Column(
                            children: [
                              _filteredListReviews!.isNotEmpty
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.75),
                                      itemCount: _filteredListReviews!.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PRoductDetailScreen(
                                                          _filteredListReviews![
                                                              i],
                                                        )));
                                          },
                                          child: _products(
                                              _filteredListReviews![i]),
                                        );
                                      })
                                  : const Center(child: Text("Not item found")),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        });
                      }
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}

Widget _products(Product product) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
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
                  product.media! != null && product.media!.isNotEmpty
                      ? Image.network(
                          // "assets/img/Bitmap.png",
                          product.media![0].url!,
                          width: width * 0.42,
                          height: height * 0.15,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
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
                    product.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        product.discountPrice != null
                            ? product.discountPrice.toString() ?? "-0.0 %"
                            : "-0.0 %",
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
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}
