import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/ContactInformationScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

class BookingTicket extends StatefulWidget {
  const BookingTicket({super.key});

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: TextWidget(
          title: "Event Detail",
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_outlined,
                color: greyColor,
              ))
        ],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 50,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                          color: Color(0XFFB6C5CD).withOpacity(0.3)),
                    ]),
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
                          width: width * 0.57,
                          child: Row(
                            children: [
                              TextWidget(
                                  title: "Concert",
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor.withOpacity(0.7)),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: greenColor.withOpacity(0.3),
                                ),
                                child: TextWidget(
                                  title: "\$289",
                                  size: 10,
                                  fontWeight: FontWeight.w500,
                                  color: greenColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        TextWidget(
                          title: "Radiohead Concert",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        TextWidget(
                          title: "Purwokerto, Ind,  28 Oct, 2022",
                          size: 12,
                          fontWeight: FontWeight.w400,
                          color: greyColor.withOpacity(0.7),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextWidget(
                title: "Choose Seat",
                size: 18,
              )
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
                    builder: (context) => ContactInformationDetailScreen()));
          },
          child: TextWidget(
            title: "Continue",
            size: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
