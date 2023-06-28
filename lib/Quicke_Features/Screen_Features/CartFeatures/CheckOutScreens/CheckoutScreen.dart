import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant.dart';
import '../../../../ConstantProviders/cartitemsprovider.dart';
import '../../../Model/ProductDetailResponseModel.dart';
import '../Widgets/BillWidget.dart';
import '../Widgets/TotalBillWidget.dart';
import 'PaymentScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends StatefulWidget {
  final Product product;

  CheckoutScreen({Key? key, required this.product}) : super(key: key);
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController? _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _loadAddress();
  }

  @override
  void dispose() {
    _addressController!.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    double productPrice = 0;

    num itemPrice = widget.product.price! * (widget.product.quantity ?? 1);
    productPrice += itemPrice;

    double shippingFees = 5; // Assuming fixed shipping fees of $5
    double totalCost = productPrice + shippingFees;
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
                    itemCount: 1,
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
              TextFormField(
                controller: _addressController,
                minLines: 3,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your address",
                ),
                onChanged: (value) {
                  _saveAddress(value); // Save the address whenever it changes
                },
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
              BillItem(
                  title: "Products Price",
                  price: productPrice.toStringAsFixed(2)),
              BillItem(title: "Shipping Fees", price: '5'),
              TotalItem(
                title: "Total Cost",
                price: totalCost.toStringAsFixed(2),
                quantity: cartItems.length.toString(),
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
