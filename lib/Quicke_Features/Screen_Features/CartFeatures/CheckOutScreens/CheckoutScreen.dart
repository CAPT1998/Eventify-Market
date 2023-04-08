import 'package:flutter/material.dart';
import '../../../../Constant.dart';
import '../Widgets/BillWidget.dart';
import '../Widgets/TotalBillWidget.dart';
import 'PaymentScreen.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: Text(
          "Checkout",
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
              _title("Your products", "View All"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.11,
                child: ListView.builder(
                    itemCount: 10,
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
              _title("Billing & Delivery Address", "Edit"),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rifat Sarkar, (+1) 917-860-0816\nJackie Auto Rice Mill, 719 Bohemia Court,\nNorth Tonawanda, NY 14120, USA",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: greyColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _title("Payment Method", "View All"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.17,
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
              SizedBox(
                height: 30,
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
              BillItem(title: "Products Price", price: '50'),
              BillItem(title: "Shipping Fees", price: '5'),
              TotalItem(
                title: "Total Cost",
                price: '55',
                quantity: '3',
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: height * 0.07,
                color: greyColor,
                minWidth: width,
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => PaymentPage()));
                },
                child: Text(
                  "promo code",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: height * 0.07,
                // color: textColor,
                minWidth: width,
                onPressed: () {},
                child: Text(
                  "Add Coupon Code",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: appColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: height * 0.07,
                color: appColor,
                minWidth: width,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutPaymentScreen()));
                },
                child: Text(
                  "Pay Now",
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
    height: height * 0.15,
    width: width * 0.5,
    decoration: BoxDecoration(
      color: greyColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/img/$image.png",
          width: width * 0.13,
          fit: BoxFit.fill,
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "5220",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
