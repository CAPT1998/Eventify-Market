import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class LinkedYourCardScreen extends StatefulWidget {
  const LinkedYourCardScreen({super.key});

  @override
  State<LinkedYourCardScreen> createState() => _LinkedYourCardScreenState();
}

class _LinkedYourCardScreenState extends State<LinkedYourCardScreen> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: TextWidget(title: "Link Your Card", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeWidget(height: 30),
            TextWidget(
                title: "Name on card",
                fontWeight: FontWeight.w600,
                size: 14,
                color: greyColor.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            textfieldProduct(context: context, name: "Name"),
            SizedBox(
              height: 20,
            ),
            TextWidget(
                title: "Card Number",
                fontWeight: FontWeight.w600,
                size: 14,
                color: greyColor.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            textfieldProduct(
                context: context,
                name: "XXXX XXXX XXXX XXXX",
                suffixIcon: Image.asset(
                  "assets/img/mastercard2.png",
                  height: 10,
                  width: 25,
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          title: "Expiration",
                          fontWeight: FontWeight.w600,
                          size: 14,
                          color: greyColor.withOpacity(0.5)),
                      SizedBox(
                        height: 10,
                      ),
                      textfieldProduct(context: context, name: "MM/YY"),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: width * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          title: "CVC",
                          fontWeight: FontWeight.w600,
                          size: 14,
                          color: greyColor.withOpacity(0.5)),
                      SizedBox(
                        height: 10,
                      ),
                      textfieldProduct(context: context, name: "123"),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
                title: "Postal Code",
                fontWeight: FontWeight.w600,
                size: 14,
                color: greyColor.withOpacity(0.5)),
            SizedBox(
              height: 10,
            ),
            textfieldProduct(context: context, name: "0000"),
            Spacer(),
            TextWidget(
              title:
                  "By adding a new card, you agree to the credit or debit cards terms.",
              fontWeight: FontWeight.w400,
              size: 14,
              maxline: 2,
              color: greyColor.withOpacity(0.5),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: appColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              minWidth: width,
              height: 50,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             ContactInformationDetailScreen()));
              },
              child: TextWidget(
                title: "Add Card",
                size: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
