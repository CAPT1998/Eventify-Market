import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../../../../Constant.dart';

class TotalItem extends StatelessWidget {
  const TotalItem({
    Key? key,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);
  final String title, price, quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Dash(
                length: width * 0.3,
                dashColor: greyColor,
              ),
              Text.rich(
                TextSpan(
                  text: '($quantity items)  ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: r'$' + price,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
