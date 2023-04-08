import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import '../Widgets/BillWidget.dart';
import '../Widgets/TotalBillWidget.dart';
import 'SuccessScreen.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  CheckoutPaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: Text(
          "Payment",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You’re buying 3 products",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.11,
                child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                              height: height * 0.1,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: width * 0.22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: greyColor.withOpacity(0.7),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: Offset(0, 2),
                                      color: Color(0XFF5C666D).withOpacity(0.1))
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/img/8.png",
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Total Cost",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BillItem(
                  title: "Products Price",
                  price: '55'),
              BillItem(
                  title: "Shipping Fees",
                  price: '5'),
              TotalItem(
                title: "Total",
                price: '60',
                quantity: '3',
              ),
              _title("Payment Method", "View All"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _containerPayment("Shape"),
                      _containerPayment("mastercard2"),
                      _containerPayment("Shape"),
                    ],
                  ),
                ),
              ),
              _textFieldWidget(
                  title: "Card Holder Name", icon: Icon(Icons.close)),
              SizedBox(
                height: 10,
              ),
              _textFieldWidget(title: "Card Number", icon: Icon(Icons.close)),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.45,
                    child: _textFieldWidget(title: "CVC"),
                  ),
                  SizedBox(
                    width: width * 0.45,
                    child: _textFieldWidget(title: "Expiry Date"),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: height * 0.07,
                color: appColor,
                minWidth: width,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessOrderScreen()));
                },
                child: Text(
                  "Proceed Payment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _title(String title, String subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$title",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        "$subtitle",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0XFF828588),
        ),
      )
    ],
  );
}

_containerPayment(String image) {
  return Container(
    margin: EdgeInsets.only(right: 20),
    padding: EdgeInsets.all(20),
    height: height * 0.07,
    width: width * 0.23,
    decoration: BoxDecoration(
      color: greyColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Image.asset(
      "assets/img/$image.png",
    ),
  );
}

Widget _textFieldWidget({String? title, dynamic icon}) {
  return Container(
    padding: EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
        color: Color(0XFFB8BCBF), borderRadius: BorderRadius.circular(5)),
    child: TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "$title",
        hintStyle: TextStyle(color: Color(0XFF828588)),
        suffixIcon: icon,
      ),
    ),
  );
}
