import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/LinkedYourCardScreen.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class PaymentLinkScreen extends StatefulWidget {
  const PaymentLinkScreen({super.key});

  @override
  State<PaymentLinkScreen> createState() => _PaymentLinkScreenState();
}

class _PaymentLinkScreenState extends State<PaymentLinkScreen> {
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
        title: TextWidget(title: "Linked Payment", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizeWidget(height: 30),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: lightGreyColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.payment),
                      TextWidget(
                        title: "  Credit/Debit Card",
                        size: 14,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(14)),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        minWidth: width,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LinkedYourCardScreen()),
                          );
                        },
                        child: TextWidget(
                          title: "Add New",
                          size: 16,
                          fontWeight: FontWeight.w700,
                          color: appColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: lightGreyColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.payment),
                      TextWidget(
                        title: "  Bank Account",
                        size: 14,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(14)),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        minWidth: width,
                        height: 50,
                        onPressed: () {},
                        child: TextWidget(
                          title: "Add New",
                          size: 16,
                          fontWeight: FontWeight.w700,
                          color: appColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: lightGreyColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.payment),
                      TextWidget(
                        title: "  E-Wallet",
                        size: 14,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/img/card.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(14)),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        minWidth: width,
                        height: 50,
                        onPressed: () {},
                        child: TextWidget(
                          title: "Add New",
                          size: 16,
                          fontWeight: FontWeight.w700,
                          color: appColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
