import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickie_event/Constant.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'CheckOutScreens/CheckoutScreen.dart';
import 'Widgets/BillWidget.dart';
import 'Widgets/PromotionWidget.dart';
import 'Widgets/TotalBillWidget.dart';

class CartScreenFeatures extends StatefulWidget {
  const CartScreenFeatures({super.key});

  @override
  State<CartScreenFeatures> createState() => _CartScreenFeaturesState();
}

class _CartScreenFeaturesState extends State<CartScreenFeatures> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
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
                  "3 Items in your cart",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _cartWidget(),
            _cartWidget(),
            _cartWidget(),
            PromoSection(
              sendText: (text) {},
              applyCoupon: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cost",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BillItem(title: "Products Price", price: '50}'),
            BillItem(title: "Shipping Fees", price: '5'),
            TotalItem(
              title: "Total Cost",
              price: '55',
              quantity: '3',
            ),
            RoundedLoadingButton(
              borderRadius: 10,
              controller: buttonController,
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    withNavBar: false, screen: CheckoutScreen());
              },
              child: Text(
                "CheckOut",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _cartWidget() {
  return Container(
    // height: sizeConfig.screenHeight * 0.2,
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
            color: Color(0XFF5C666D).withOpacity(0.1))
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: 10,
        ),
        _CartImage(
          image: "assets/img/8.png",
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Padding(
          padding: EdgeInsets.only(
            // left: 20,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Artisti Shirt for man',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Blue, Full Sleve',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0XFF828588),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: width * 0.55,
                child: Row(
                  children: [
                    Text(
                      '\$ 150',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF2473F2)),
                    ),
                    Spacer(),
                    QuantityButtonsVertical(
                      decrement: () {
                        // decrement();
                      },
                      increment: () {
                        // increment();
                      },
                      quantity: 1,
                    ),
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
          image: AssetImage(
            image,
          ),
          placeholder: AssetImage(
            'assets/img/loading.gif',
          ),
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
  final double quantity;

  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<QuantityButtonsVertical> {
  bool _secondSelected = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoundedButton(
          icon: widget.quantity == 1 ? Icons.delete : Icons.remove_rounded,
          selected: !_secondSelected,
          onTap: () {
            setState(
              () {
                if (_secondSelected) {
                  changeSelected();
                }
                if (widget.quantity > 0) {
                  widget.decrement();
                }
              },
            );
          },
        ),
        Text(
          "   ${widget.quantity.round().toString()}   ",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        _RoundedButton(
          selected: _secondSelected,
          icon: Icons.add_rounded,
          onTap: () {
            setState(() {
              if (!_secondSelected) {
                changeSelected();
              }
              if (widget.quantity >= 0) {
                widget.increment();
              }
            });
          },
        ),
      ],
    );
  }

  void changeSelected() => _secondSelected = !_secondSelected;
}

class _RoundedButton extends StatefulWidget {
  const _RoundedButton({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.icon,
  }) : super(key: key);

  final Function onTap;
  final bool selected;
  final IconData icon;
  @override
  __RoundedButtonState createState() => __RoundedButtonState();
}

class __RoundedButtonState extends State<_RoundedButton> {
  @override
  Widget build(BuildContext context) {
    bool _isSelected = widget.selected;
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color:
              _isSelected ? Theme.of(context).accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).accentColor,
          ),
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: _isSelected ? Colors.white : Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
