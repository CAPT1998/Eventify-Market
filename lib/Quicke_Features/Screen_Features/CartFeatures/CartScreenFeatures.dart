import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../ConstantProviders/cartitemsprovider.dart';
import '../../Model/ProductDetailResponseModel.dart';
import 'CheckOutScreens/CheckoutScreen.dart';
import 'Widgets/BillWidget.dart';
import 'Widgets/PromotionWidget.dart';
import 'Widgets/TotalBillWidget.dart';

class CartScreenFeatures extends StatefulWidget with ChangeNotifier {
  CartScreenFeatures({Key? key}) : super(key: key);

  @override
  State<CartScreenFeatures> createState() => _CartScreenFeaturesState();
}

class _CartScreenFeaturesState extends State<CartScreenFeatures>
    with ChangeNotifier {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  // List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final cartItems = cartProvider.cartItems;
    final quantity = cartProvider.amount;
    double productPrice = 0;
    for (var item in cartItems) {
      num itemPrice = item.price! * (quantity!);
      productPrice += itemPrice;
    }

    // Calculate total cost (including shipping fees)
    double shippingFees = 5; // Assuming fixed shipping fees of $5
    double totalCost = productPrice + shippingFees;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            color: Color(0XFF828588),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.production_quantity_limits,
                  color: appColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${cartItems.length} Items in your cart",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    print("clear");
                    cartProvider.clearCart();
                  },
                  icon: const Icon(
                    Icons.delete_outline_sharp,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return _cartWidget(cartItems[index], quantity!);
              },
            ),
            PromoSection(
              sendText: (text) {},
              applyCoupon: () {},
            ),
            SizedBox(height: 10),
            Text(
              "Cost",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            BillItem(
                title: "Products Price",
                price: productPrice.toStringAsFixed(2)),
            BillItem(title: "Shipping Fees", price: '5'),
            TotalItem(
              title: "Total Cost",
              price: totalCost.toStringAsFixed(2),
              quantity: cartItems.length.toString(),
            ),
            RoundedLoadingButton(
              borderRadius: 10,
              controller: buttonController,
              onPressed: () {
                //     PersistentNavBarNavigator.pushNewScreen(
                //      context,
                //    withNavBar: false,
                //    screen: CheckoutScreen(product: cartItems,),
                //    );
              },
              child: Text(
                "CheckOut",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _cartWidget(item, int quantity) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Color(0XFF5C666D).withOpacity(0.1),
          )
        ],
      ),
      child: Row(
        children: [
          //  SizedBox(width: 10),
          Image.asset(
            "assets/img/Bitmap.png",
            width: width * 0.29,
            height: height * 0.10,
            fit: BoxFit.contain,
          ),
          //_CartImage(image: item.media![0].url),
          SizedBox(width: width * 0.03),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item.description ?? "No description",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0XFF828588),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: width * 0.55,
                  child: Row(
                    children: [
                      Text(
                        '\$ ${item.price}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF2473F2),
                        ),
                      ),
                      Spacer(),
                      QuantityButtonsVertical(
                          decrement: () {
                            setState(() {
                              quantity = quantity != null ? quantity! - 1 : 0;
                              notifyListeners();
                            });
                          },
                          increment: () {
                            setState(() {
                              quantity = quantity != null ? quantity! + 1 : 1;
                              notifyListeners();
                            });
                          },
                          quantity: quantity!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartImage extends StatelessWidget {
  const _CartImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 80,
        width: 80,
        child: FadeInImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
          placeholder: AssetImage('assets/img/loading.gif'),
        ),
      ),
    );
  }
}

class QuantityButtonsVertical extends StatefulWidget {
  const QuantityButtonsVertical({
    Key? key,
    required this.decrement,
    required this.increment,
    required this.quantity,
  }) : super(key: key);

  final Function decrement;
  final Function increment;
  final int quantity;

  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<QuantityButtonsVertical>
    with ChangeNotifier {
  int? quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget
        .quantity; // Initialize the quantity from the widget's initial value
  }

  void addToCart(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(product, quantity!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoundedButton(
          icon: quantity == 1 ? Icons.delete : Icons.remove_rounded,
          onTap: () {
            setState(() {
              if (quantity! > 0) {
                widget.decrement();
                quantity = quantity! - 1;
                notifyListeners();
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
                quantity = quantity! + 1;
                notifyListeners();
              }
            });
            setState(() {});
          },
        ),
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
