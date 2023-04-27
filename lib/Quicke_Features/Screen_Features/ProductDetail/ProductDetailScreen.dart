import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

class PRoductDetailScreen extends StatefulWidget {
  const PRoductDetailScreen({super.key});

  @override
  State<PRoductDetailScreen> createState() => _PRoductDetailScreenState();
}

class _PRoductDetailScreenState extends State<PRoductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Product Name",
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
                      child: Image.asset(
                        "assets/img/Bitmap.png",
                        fit: BoxFit.contain,
                      )
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
                    Text(
                      "Product Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Product Price",
                          style: TextStyle(
                            color: Color(0XFF00ADF4),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Product Discount",
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
                            const Tab(text: 'Bebidas Relaciondas'),
                          ],
                        ),
                        Flexible(
                            child: Container(
                          child: TabBarView(children: [
                            Center(
                              child: Text("No Description"),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
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
                                              color:
                                                  Colors.grey.withOpacity(0.5))
                                        ]),
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
                                                          .withOpacity(0.5))
                                                ]),
                                            child: Image.asset(
                                              "assets/img/Bitmap.png",
                                              height: height * 0.1,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Product Name",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Description".toString(),
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
                                              "Price",
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
                                ],
                              ),
                            ),
                          ]),
                        ))
                      ],
                    ),
                  ),
                ),
                Text(
                  "Productos Relacionados",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: height * 0.06,
                width: width * 0.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0XFF00ADF4))),
                child: Text(
                  "Add TO Cart",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF00ADF4)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: height * 0.06,
              width: width * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0XFF00ADF4)),
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
