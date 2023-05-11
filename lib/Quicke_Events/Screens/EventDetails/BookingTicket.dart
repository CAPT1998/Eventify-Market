import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:slide_countdown/slide_countdown.dart';

import 'ContactInformationScreen.dart';

class BookingTicket extends StatefulWidget {
  const BookingTicket({super.key});

  @override
  State<BookingTicket> createState() => _BookingTicketState();
}

class _BookingTicketState extends State<BookingTicket> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  bool isTimerVisible=false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset("assets/img/book.png"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.getEventSeatsModel.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            itemCount: value.getEventSeatsModel[index]
                                .seatingPlanDetails.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index12) {
                              return InkWell(
                                onTap: () {
                                  if (value
                                          .getEventSeatsModel[index]
                                          .seatingPlanDetails[index12]
                                          .seatStatus !=
                                      "1") {
                                    if (!value.reservationModel!.seatId!.any(
                                        (element) =>
                                            element ==
                                            value
                                                .getEventSeatsModel[index]
                                                .seatingPlanDetails[index12]
                                                .id)) {
                                      if (value.reservationModel!.quantity >
                                          value.reservationModel!.seatId!
                                              .length) {
                                        setState(() {
                                          isTimerVisible=true;

                                        });
                                        value.mAddSeatList(
                                            id: value.getEventSeatsModel[index]
                                                .seatingPlanDetails[index12].id,
                                            name: value
                                                .getEventSeatsModel[index]
                                                .seatingPlanDetails[index12]
                                                .seatNo);
                                      } else {
                                        ErrorFlushbar(context, "Quantity",
                                            "Add More Ticket to book your seat");
                                      }
                                    } else {
                                      setState(() {
                                        isTimerVisible=false;

                                      });
                                      value.mSubtractSeatList(
                                          id: value.getEventSeatsModel[index]
                                              .seatingPlanDetails[index12].id,
                                          name: value
                                              .getEventSeatsModel[index]
                                              .seatingPlanDetails[index12]
                                              .seatNo);
                                    }
                                  } else {
                                    ErrorFlushbar(context, "Seat",
                                        "Seat Already reserved");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: value.reservationModel!.seatId!
                                              .any((element) =>
                                                  element ==
                                                  value
                                                      .getEventSeatsModel[index]
                                                      .seatingPlanDetails[
                                                          index12]
                                                      .id)
                                          ? appColor
                                          : value
                                                      .getEventSeatsModel[index]
                                                      .seatingPlanDetails[
                                                          index12]
                                                      .seatStatus ==
                                                  "0"
                                              ? Colors.white
                                              : value
                                                          .getEventSeatsModel[
                                                              index]
                                                          .seatingPlanDetails[
                                                              index12]
                                                          .seatStatus ==
                                                      "1"
                                                  ? Colors.grey
                                                  : appColor,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextWidget(
                                      title:
                                          "${value.getEventSeatsModel[index].seatingPlanDetails[index12].seatNo}",
                                      color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      "  ●",
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                    ),
                    TextWidget(title: "  Reserved", size: 16),
                    Text(
                      "    ●",
                      style: TextStyle(color: Colors.grey[100], fontSize: 30),
                    ),
                    TextWidget(title: "  Available", size: 16),
                    Text(
                      "    ●",
                      style: TextStyle(color: appColor, fontSize: 30),
                    ),
                    TextWidget(title: "  Booking", size: 16),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextWidget(
                      title:
                          "Selected ${value.reservationModel!.seatName!.length} Seat",
                      size: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    TextWidget(
                      title: "${value.reservationModel!.seatName!}",
                      size: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Visibility(
                  visible: isTimerVisible,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                     color: appColor ),
                      margin: EdgeInsets.all(20),
                      child: SlideCountdown(
                        duration: const Duration(minutes: 20),
                        textStyle: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(color: Colors.transparent),
                        countUp: false,
                        onDone: (){
                          if(isTimerVisible){
                            setState(() {
                              isTimerVisible=false;
                            });
                          }
                          print("doneee");
                        },
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: RoundedLoadingButton(
            color: appColor,
            width: width,
            controller: buttonController,
            borderRadius: 14,
            height: 50,
            onPressed: () async {


        /*       await value.mAddReservation();
              if (value.reservationMessage == "success") {
                buttonController.success();
                SuccessFlushbar(context, "Reservation",
                    "Your Reservation has been successfull");
                Timer(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  buttonController.reset();
                });
              } else {
                buttonController.error();
                ErrorFlushbar(context, "Reservation",
                    "Your Reservation has been Cancelled please try again later");
                Timer(Duration(seconds: 2), () {
                  buttonController.reset();
                });
              }*/
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
      ),
    );
  }

}

class TableWithSeats extends StatelessWidget {
  final int numberOfSeats;
  final double tableSize;
  final List<Offset> seatPositions;

  const TableWithSeats({
    Key? key,
    required this.numberOfSeats,
    required this.tableSize,
    required this.seatPositions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Table
        Positioned(
          top: tableSize / 2,
          left: tableSize / 2,
          child: Container(
            width: tableSize,
            height: tableSize,
            // color: Colors.brown,
            child: Image.asset(
              "assets/img/table.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Seats
        ...seatPositions
            .map(
              (position) => Positioned(
                top: position.dy,
                left: position.dx,
                child: Seat(),
              ),
            )
            .toList(),
      ],
    );
  }
}

class Seat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
