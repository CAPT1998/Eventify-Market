// ignore_for_file: prefer_const_constructors

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Features/Model/ProductDetailResponseModel.dart';
import 'package:quickie_event/Quicke_Features/Model/ProductScreenResponseModel.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/Categories/ProductScreen.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/Categories/ViewAllCategory.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CourselSliderFeatures/CourselSliderFeaturesWidget.dart';
import 'package:quickie_event/Quicke_Features/providers/HomeProviders.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ConstantProviders/cartitemsprovider.dart';
import '../CartFeatures/CartScreenFeatures.dart';
import '../Notification/NotificationScreen.dart';
import '../ProductDetail/ProductDetailScreen.dart';
import '../barcodescannerFeatures/scanner.dart';
import 'address.dart';

class HomeScreenFeatures extends StatefulWidget {
  const HomeScreenFeatures({super.key});

  @override
  State<HomeScreenFeatures> createState() => _HomeScreenFeaturesState();
}

class _HomeScreenFeaturesState extends State<HomeScreenFeatures> {
  final TextEditingController _searchController = TextEditingController();
  List<Categories> _filteredListReviews = [];
  List<Product> _filteredListReviews2 = [];
  int _selectedAddressIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCategories();
    _loadAddress();
  }

  getCategories() async {
    await Provider.of<HomeProvider>(context).getProductScreenDate();
  }

  Future<void> _loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString('address') ?? " ";
    if (address != null) {
      setState(() {
        _addressController!.text = address;
      });
    }
  }

  Future<void> _saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }

  TextEditingController _addressController = TextEditingController();

  void _showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(child: AddressBottomSheetWidget());
      },
    );
  }

  void _clearAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('addresses');
  }

  void _selectAddress(String selectedAddress) async {
    final addresses = await _getSavedAddresses();
    final selectedIndex = addresses.indexOf(selectedAddress);
    print('Selected Address: $selectedAddress');
    setState(() {
      _selectedAddressIndex = selectedIndex;
    });
    print('Selected Address: $selectedAddress');
  }

  Future<List<String>> _getSavedAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getStringList('addresses');
    if (addressesJson != null) {
      return addressesJson;
    }
    return [];
  }

  Future<void> _saveAddresses(List<String> addresses) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('addresses', addresses);
  }

  Future<void> _addNewAddress() async {
    // Prompt user to enter a new address
    final newAddress = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter New Address'),
          content: TextField(
            controller: _addressController,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _addressController!.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newAddress != null) {
      final addresses = await _getSavedAddresses();
      addresses.add(newAddress);

      await _saveAddresses(addresses);
      setState(() {
        _selectedAddressIndex = addresses.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                _showAddressBottomSheet(context);
              },
              child: Text(
                " MI CASA",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showAddressBottomSheet(context);
              },
              child: Text(
                "Express Shopping",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
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
                  screen: const NotificationScreen(),
                  withNavBar: false,
                );
              },
              icon: const Icon(Icons.notifications_on))
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: textfieldProduct(
                      context: context,
                      name: "Search",
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
                          screen: QrScanner(),
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
            SizedBox(
                height: height * 0.2, child: CourselSliderFeatures(context)),
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
                          InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ViewAllCategories(),
                                withNavBar: false,
                              );
                            },
                            child: Text(
                              "Ver Todos",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF828588),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future:
                              Provider.of<HomeProvider>(context, listen: false)
                                  .getProductScreenDate(),
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
                                  if (_searchController.text.isEmpty) {
                                    _filteredListReviews = person
                                        .getProductScreenData!
                                        .data!
                                        .categories!;
                                  }
                                  return SizedBox(
                                    height: height / 7,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: _filteredListReviews.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: ProductScreen(
                                                    _filteredListReviews[i]
                                                        .id
                                                        .toString()),
                                                withNavBar: true,
                                              );
                                            },
                                            child: CategoriesFeatureWidget(
                                                context: context,
                                                image: _filteredListReviews[i]
                                                                .media !=
                                                            null &&
                                                        _filteredListReviews[i]
                                                            .media!
                                                            .isNotEmpty
                                                    ? _filteredListReviews[i]
                                                        .media![0]
                                                        .url
                                                        .toString()
                                                    : "abc",
                                                title: _filteredListReviews[i]
                                                    .name
                                                    .toString()),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                });
                              }
                            }
                          }),
                      /*
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




 */

                      SizedBox(
                        height: 20,
                      ),
                      _filteredListReviews == null &&
                              _filteredListReviews.isNotEmpty
                          ? SizedBox.shrink()
                          : Consumer<HomeProvider>(
                              builder: (context, person, child) {
                              if (_searchController.text.isEmpty) {
                                _filteredListReviews =
                                    person.getProductScreenData != null
                                        ? person.getProductScreenData!.data!
                                            .categories!
                                        : [];
                              }
                              return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _filteredListReviews.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        PersistentNavBarNavigator.pushNewScreen(
                                          context,
                                          screen: ProductScreen(
                                              _filteredListReviews[index]
                                                  .id
                                                  .toString()),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _filteredListReviews[index]
                                                    .name!,
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Consumer<HomeProvider>(builder:
                                              (context, person, child) {
                                            if (_searchController
                                                .text.isEmpty) {
                                              _filteredListReviews = person
                                                  .getProductScreenData!
                                                  .data!
                                                  .categories!;
                                            }
                                            return Container(
                                              height:
                                                  _filteredListReviews[index]
                                                          .products!
                                                          .isNotEmpty
                                                      ? height / 3
                                                      : height / 30,
                                              child: _filteredListReviews[index]
                                                      .products!
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      // physics: NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          _filteredListReviews[
                                                                  index]
                                                              .products!
                                                              .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return InkWell(
                                                          onTap: () {},
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: width *
                                                                    0.43,
                                                                // height: height * 0.3,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            4,
                                                                        spreadRadius:
                                                                            0,
                                                                        offset: Offset(
                                                                            0,
                                                                            2),
                                                                        color: Color(0XFFA2AAB8)
                                                                            .withOpacity(0.25),
                                                                      )
                                                                    ]),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => PRoductDetailScreen(
                                                                                      _filteredListReviews[index].products![i],
                                                                                      _filteredListReviews[index].products!,
                                                                                      _filteredListReviews,
                                                                                    )));
                                                                      },
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          _filteredListReviews[index].products![i].media! != null && _filteredListReviews[index].products![i].media!.isNotEmpty
                                                                              ? Image.network(
                                                                                  // "assets/img/Bitmap.png",
                                                                                  _filteredListReviews[index].products![i].media![0].url!,
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
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.02,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              0.4,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 10),
                                                                        child:
                                                                            Text(
                                                                          _filteredListReviews[index]
                                                                              .products![i]
                                                                              .name
                                                                              .toString(),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              0.4,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 10),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "\$${_filteredListReviews[index].products![i].price}",
                                                                              style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                            Spacer(),
                                                                            Text(
                                                                              _filteredListReviews[index].products![i].discountPrice != null ? _filteredListReviews[index].products![i].discountPrice.toString() : "-0.0%",
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
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          150,
                                                                    ),
                                                                    QuantityButtonsVerticalHome(
                                                                      decrement:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _filteredListReviews[index]
                                                                              .products![
                                                                                  i]
                                                                              .quantity = _filteredListReviews[index].products![i].quantity !=
                                                                                  null
                                                                              ? _filteredListReviews[index].products![i].quantity! - 1
                                                                              : 0;
                                                                        });
                                                                      },
                                                                      increment:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _filteredListReviews[index]
                                                                              .products![
                                                                                  i]
                                                                              .quantity = _filteredListReviews[index].products![i].quantity !=
                                                                                  null
                                                                              ? _filteredListReviews[index].products![i].quantity! + 1
                                                                              : 1;
                                                                        });
                                                                      },
                                                                      product: _filteredListReviews[
                                                                              index]
                                                                          .products![i],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
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
                                                      })
                                                  : const Center(
                                                      child: Text(
                                                          "No item found")),
                                            );
                                          }),
                                          SizedBox(
                                            height: 100,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),

                      /*  Row(
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
                            InkWell(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: PRoductDetailScreen(),
                                    withNavBar: false,
                                  );
                                },
                                child: _products()),
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
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
            // CourselSliderFeatures(context),
            /* Padding(
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
            ),*/
          ],
        ),
      ),
    );
  }
}

Widget _products() {
  return Container(
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
              children: const [
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
              children: const [
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

class QuantityButtonsVerticalHome extends StatefulWidget {
  const QuantityButtonsVerticalHome({
    Key? key,
    required this.product,
    required this.decrement,
    required this.increment,
  }) : super(key: key);

  final Function decrement;
  final Function increment;
  final Product product;

  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<QuantityButtonsVerticalHome> {
  int? quantity;

  @override
  void initState() {
    super.initState();
    quantity = 0; // Initialize the quantity from the widget's initial value
  }

  void addToCart(Product product, quantity) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(product, quantity!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        _RoundedButton(
          icon: quantity == 1 ? Icons.delete : Icons.remove_rounded,
          onTap: () {
            setState(() {
              if (quantity! > 0) {
                widget.decrement();
                quantity = quantity != null ? quantity! - 1 : 0;
              }
            });
          },
        ),
        Text(
          "   ${quantity!.round().toString()}   ",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        _RoundedButton(
          icon: Icons.add_rounded,
          onTap: () {
            setState(() {
              if (quantity! >= 0) {
                widget.increment();
                quantity = quantity != null ? quantity! + 1 : 1;
              }
            });
            Future.delayed(Duration(seconds: 5), () {
              addToCart(widget.product, quantity!);
              SuccessFlushbar(context, "Success", "Item added to cart");
            });
          },
        ),
        Spacer(),
      ],
    );
  }
}

class _RoundedButton extends StatefulWidget {
  const _RoundedButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final Function onTap;
  final IconData icon;

  @override
  __RoundedButtonState createState() => __RoundedButtonState();
}

class __RoundedButtonState extends State<_RoundedButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap();
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: _isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
