import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/ContactInformationScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import 'TicketOrderCompletedScreen.dart';

class TicketDetailOrderScreen extends StatefulWidget {
  const TicketDetailOrderScreen({super.key});

  @override
  State<TicketDetailOrderScreen> createState() =>
      _TicketDetailOrderScreenState();
}

class _TicketDetailOrderScreenState extends State<TicketDetailOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: TextWidget(
          title: "Confirm and Pay",
          size: 14,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: greyColor,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor.withOpacity(0.5))),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/f4.png",
                      height: 90,
                      width: 90,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.6,
                          child: TextWidget(
                            title: "Drink & Draw at The Living Gallery",
                            maxline: 2,
                            size: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: greyColor.withOpacity(0.5),
                            ),
                            TextWidget(
                              title: "Broadway Brooklyn",
                              maxline: 2,
                              size: 12,
                              color: greyColor.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: greenColor.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: greenColor,
                      size: 15,
                    ),
                    TextWidget(
                        title: "  Your booking is protected by Eventer",
                        size: 12,
                        fontWeight: FontWeight.w500,
                        color: greenColor)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyColor.withOpacity(0.5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: "Your Events",
                      size: 14,
                      color: greyColor.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.ac_unit_sharp,
                          color: greyColor,
                        ),
                        TextWidget(
                          title: "Ticket",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        TextWidget(
                          title: "2 Tickets",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: greyColor,
                        ),
                        TextWidget(
                          title: "Date",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        TextWidget(
                          title: "Wed, 27 Nov 2022",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      title: "Price Details",
                      size: 14,
                      color: greyColor.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          title: "Price",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        TextWidget(
                          title: "2 x \$39.00",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          title: "Event fee",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        TextWidget(
                          title: "\$2.50",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          title: "Total price",
                          size: 14,
                        ),
                        Spacer(),
                        TextWidget(
                          title: "\$80.50",
                          size: 14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                title: "Payment Method",
                size: 14,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: purpleColor.withOpacity(0.5))),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.card_travel_outlined,
                          color: purpleColor,
                        )),
                  ),
                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor.withOpacity(0.5))),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.wallet,
                        )),
                  ),
                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor.withOpacity(0.5))),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.dashboard_outlined,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10,),
               Row(
                  children: [
                    TextWidget(
                      title: "Credit/Debit Card",
                      size: 14,
                      color: greyColor.withOpacity(0.5)
                    ),
                    Spacer(),
                    TextWidget(
                        title: "Add New",
                        size: 12,
                        color: purpleColor)
                  ],
                ),
                SizedBox(height: 20,),
                Image.asset("assets/img/card.png")
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          color: appColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minWidth: width,
          height: 50,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TicketOrderCompletedScreen()));
          },
          child: TextWidget(
            title: "Confirm and Pay",
            size: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
