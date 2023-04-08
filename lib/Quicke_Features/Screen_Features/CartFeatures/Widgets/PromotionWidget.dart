import 'package:flutter/material.dart';

class PromoSection extends StatelessWidget {
  const PromoSection({
    Key? key,
    required this.sendText,
    required this.applyCoupon,
  }) : super(key: key);

  final Function(String text) sendText;
  final Function applyCoupon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, 2),
                color: Color(0XFF5C666D).withOpacity(0.1))
          ]),
      child: TextField(
        onChanged: (text) {
          sendText(text);
        },
        decoration: InputDecoration(
          hintText: "have Coupon Code",
          // hintStyle: Theme.of(context).textTheme.headline3,
          border: InputBorder.none,
          suffix: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              applyCoupon();
            },
            child: Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
