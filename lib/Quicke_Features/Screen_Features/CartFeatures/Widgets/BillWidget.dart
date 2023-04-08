import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:quickie_event/Constant.dart';

class BillItem extends StatelessWidget {
  const BillItem({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);
  final String title, price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: greyColor,
            ),
          ),
          Dash(
            length: width*0.4,
            dashColor: greyColor,
          ),
          Text.rich(
            TextSpan(
              text: r'$' + price,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
