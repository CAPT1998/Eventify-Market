import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';

import '../../Model/ProductDetailResponseModel.dart';
import '../../providers/HomeProviders.dart';
import '../HomeFeatures/HomeScreenFeatures.dart';
import '../ProductDetail/ProductDetailScreen.dart';
import '../barcodescannerFeatures/scanner.dart';

class ProductScreen extends StatefulWidget {
  String productId;

  // String type;
  ProductScreen(this.productId, {super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController? _searchController;
  List<dynamic>? relatedcategories = [];
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
          body: SingleChildScrollView(
        child: Padding(
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
                            _filteredListReviews = Provider.of<HomeProvider>(
                                    context,
                                    listen: false)
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
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const QrScanner(),
                              withNavBar: false,
                            );
                          },
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
                              relatedcategories = person
                                  .getProductScreenData!.data!.categories!;
                            }
                            return Column(
                              children: [
                                _filteredListReviews!.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
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
                                                            _filteredListReviews!,
                                                            relatedcategories!,
                                                          )));
                                            },
                                            child: ProductsWidget(
                                                _filteredListReviews![i]),
                                          );
                                        })
                                    : const Center(
                                        child: Text("Not item found")),
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
        ),
      )),
    );
  }
}

class ProductsWidget extends StatefulWidget {
  final Product product;

  ProductsWidget(this.product);

  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: width * 0.43,
          // height: height * 0.3,
          margin: const EdgeInsets.only(right: 10, left: 10),
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
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  widget.product.media != null &&
                          widget.product.media!.isNotEmpty
                      ? Image.network(
                          // "assets/img/Bitmap.png",
                          widget.product.media![0].url!,
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
                    ),
                  ),
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
                    widget.product.name.toString(),
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
                height: 5,
              ),
              SizedBox(
                width: width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.product.discountPrice != null
                            ? widget.product.discountPrice.toString() ??
                                "-0.0 %"
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
                height: 5,
              ),
              SizedBox(
                width: width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: QuantityButtonsVerticalHome(
                    decrement: () {
                      setState(() {
                        widget.product.quantity =
                            widget.product.quantity != null
                                ? widget.product.quantity! - 1
                                : 0;
                      });
                    },
                    increment: () {
                      setState(() {
                        widget.product.quantity =
                            widget.product.quantity != null
                                ? widget.product.quantity! + 1
                                : 1;
                      });
                    },
                    product: widget.product,
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
        ),
      ],
    );
  }
}
