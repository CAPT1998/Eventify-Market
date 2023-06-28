// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Features/Model/ProductDetailResponseModel.dart';

import '../../../ConstantProviders/cartitemsprovider.dart';
import '../CartFeatures/CheckOutScreens/CheckoutScreen.dart';
import '../HomeFeatures/HomeScreenFeatures.dart';

class PRoductDetailScreen extends StatefulWidget {
  final Product product;
  final List<dynamic> relatedProducts;
  final List<dynamic> relatedcategories;

  const PRoductDetailScreen(
      this.product, this.relatedProducts, this.relatedcategories,
      {super.key});

  @override
  State<PRoductDetailScreen> createState() => _PRoductDetailScreenState();
}

class _PRoductDetailScreenState extends State<PRoductDetailScreen> {
  // List<Product> cartItems = [];
  int? indexx = 0;
  void addToCart(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(product, 0);
  }

  List<Product> getrelatedproducts() {
    return [
      Product(
        name: "Rum",
        price: 30,
        quantity: 0,

        // photoUrl: "rum_photo_url",
        description: "Aged and flavorful rum.",
      ),
      Product(
        name: "Cola",
        price: 30,
        quantity: 0,

        //  photoUrl: "cola_photo_url",
        description: "Refreshing cola beverage.",
      ),
      Product(
        name: "Lime",
        price: 30,
        quantity: 0,

        // photoUrl: "lime_photo_url",
        description: "Freshly squeezed lime juice.",
      ),
    ];
  }

  List<Product> getRelatedDrinks() {
    // Replace this with your logic to fetch related drinks based on the selected product
    // You can query the database or use any other method to determine the related drinks
    // Return a list of Product objects representing the related drinks
    return [
      Product(
        name: "Mojito",
        // photoUrl: "mojito.jpg",
        quantity: 0,
        price: 30,
        description:
            "A refreshing cocktail made with rum, lime juice, sugar, mint leaves, and soda water.",
        // ...other properties...
      ),
      Product(
        name: "Daiquiri",
        quantity: 0,
        price: 30,

        // photoUrl: "daiquiri.jpg",
        description: "A classic cocktail made with rum, lime juice, and sugar.",
        // ...other properties...
      ),
      Product(
        name: "Pina Colada",
        quantity: 0,
        price: 30,

        // photoUrl: "daiquiri.jpg",
        description: "A classic cocktail made with rum, lime juice, and sugar.",
        // ...other properties...
      ),
      // Add more related drinks here
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Product> relatedDrinks = getRelatedDrinks();
    List<Product> relatedproducts = getrelatedproducts();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product.name!,
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
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  // color: Colors.grey[50],
                  child: widget.product.media! != null &&
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
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: FadeInImage(
                  //     fit: BoxFit.cover,
                  //     height: 60,
                  //     width: 60,
                  //     image: NetworkImage("image"),
                  //     placeholder: AssetImage(
                  //       'assets/img/loading.gif',
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                          color: Color(0XFF00ADF4),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.product.discountPrice != null
                            ? widget.product.discountPrice.toString() ??
                                "-0.0 %"
                            : "-0.0 %",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 250,
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          dragStartBehavior: DragStartBehavior.start,
                          physics: const BouncingScrollPhysics(),
                          isScrollable: true,
                          labelColor: Colors.black,
                          tabs: [
                            const Tab(
                              text: 'Description',
                            ),
                            const Tab(text: 'Bebidas Relaciones'),
                          ],
                          onTap: (index) {
                            // Handle tab switch
                            if (index == 0) {
                              // Description tab selected
                              // Add your logic here
                              setState(() {
                                indexx = 0;
                              });
                            } else if (index == 1) {
                              // Categorias Relacionadas tab selected
                              setState(() {
                                indexx = 1;
                              });
                            }
                          }),
                      Flexible(
                          child: Container(
                        child: TabBarView(children: [
                          Center(
                            child: Text("No Description"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  /*
                                  Container(
                                    height: height * 0.13,
                                    width: width,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                              color: Colors.grey.withOpacity(0.5))
                                        ]),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    color: Colors.grey
                                                        .withOpacity(0.5))
                                              ]),
                                          child: widget.product.media! != null &&
                                                  widget.product.media!.isNotEmpty
                                              ? Image.network(
                                                  // "assets/img/Bitmap.png",
                                                  widget.product.media![0].url!,
                                                  height: height * 0.1,
                                                  fit: BoxFit.contain,
                                                )
                                              : Image.asset(
                                                  "assets/img/Bitmap.png",
                                                  height: height * 0.1,
                                                  fit: BoxFit.contain,
                                                ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.product.name!,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              widget.product.description ?? "",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "\$${widget.product.price}",
                                              style: TextStyle(
                                                color: Color(0XFF00ADF4),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                        
                          
                                      ],
                                    ),
                                  ),
                                  */
                                  relatedDrinks.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: relatedDrinks.length,
                                          itemBuilder: (context, index) {
                                            final drink = relatedDrinks[index];
                                            return Container(
                                              height: height * 0.13,
                                              width: width,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: 0,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 2),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image.asset(
                                                      "assets/img/Bitmap.png",
                                                      height: height * 0.1,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        drink.name!,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      SizedBox(
                                                        width: width * 0.5,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "\$${drink.price}"
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0XFF2473F2),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.4,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child:
                                                                    QuantityButtonsVerticalHome(
                                                                  decrement:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      drink
                                                                          .quantity = drink.quantity !=
                                                                              null
                                                                          ? drink.quantity! -
                                                                              1
                                                                          : 0;
                                                                    });
                                                                  },
                                                                  increment:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      drink
                                                                          .quantity = drink.quantity !=
                                                                              null
                                                                          ? drink.quantity! +
                                                                              1
                                                                          : 1;
                                                                    });
                                                                  },
                                                                  product:
                                                                      drink,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text('Nothing Found')),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ))
                    ],
                  ),
                ),
              ),
              Visibility(
                //  maintainSize: true,
                //  maintainAnimation: true,
                //  maintainState: true,
                replacement: SizedBox.shrink(),

                visible: indexx == 0,
                child: Text(
                  "Productos Relacionados",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              /* 
              Container(
                height: height * 0.13,
                width: width,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                              color: Colors.grey.withOpacity(0.5))
                        ]),
                        child: Image.asset(
                          "assets/img/Bitmap.png",
                          height: height * 0.1,
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
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Helper.getPrice(widget.product.price!, context, style: TextStyle()),
                              // _ProductPrice(
                              //     '${_controller.total.round()}'),
                              Text(
                                "\$ Total Price",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF2473F2),
                                ),
                              ),
                              SizedBox(
                                // width: width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              */
              Visibility(
                // maintainSize: true,
                //  maintainAnimation: true,
                //   maintainState: true,
                replacement: SizedBox.shrink(),
                visible: indexx == 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final relatedproduct = relatedproducts[index];
                    return Container(
                      height: height * 0.13,
                      width: width,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
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
                              height: height * 0.1,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                relatedproduct.name!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                relatedproduct.description ?? '',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Spacer(),
                              SizedBox(
                                width: width * 0.6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${relatedproduct.price}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF2473F2),
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: QuantityButtonsVerticalHome(
                                          decrement: () {
                                            setState(() {
                                              relatedproduct
                                                  .quantity = relatedproduct
                                                          .quantity !=
                                                      null
                                                  ? relatedproduct.quantity! - 1
                                                  : 0;
                                            });
                                          },
                                          increment: () {
                                            setState(() {
                                              relatedproduct
                                                  .quantity = relatedproduct
                                                          .quantity !=
                                                      null
                                                  ? relatedproduct.quantity! + 1
                                                  : 1;
                                            });
                                          },
                                          product: relatedproduct,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              // Handle add to cart button press
              addToCart(widget.product);
              SuccessFlushbar(context, "Success", "Item added to cart");
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: height * 0.06,
              width: width * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0XFF00ADF4)),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF00ADF4),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CheckoutScreen(
                  product: widget.product,
                ),
                withNavBar: false,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: height * 0.06,
              width: width * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0XFF00ADF4),
              ),
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
