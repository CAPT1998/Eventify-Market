import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'BookingTicket.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: TextWidget(
            title: "Ticket Detail",
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
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                value.checkValueEventTicket == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : value.getEventTicketsModel.length == 0
                        ? TextWidget(
                            title: "No Ticket Available",
                            size: 16,
                            fontWeight: FontWeight.w600,
                          )
                        : ListView.builder(
                            itemCount: value.getEventTicketsModel.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  value.mupdateSelectTicket(index: index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              value.selectTicketIndex == index
                                                  ? appColor
                                                  : Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          value.selectTicketIndex == index
                                              ? greenColor
                                              : appColor,
                                      child: Icon(
                                        CupertinoIcons.tickets,
                                        color:  Colors.white,
                                      ),
                                    ),
                                    title: TextWidget(
                                      title:
                                          "${value.getEventTicketsModel[index].name}",
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    subtitle: value.getEventTicketsModel[index]
                                                .description ==
                                            null
                                        ? null
                                        : TextWidget(
                                            title:
                                                "${value.getEventTicketsModel[index].description}",
                                            size: 12,
                                            fontWeight: FontWeight.w400,
                                            maxline: 2,
                                            color: greyColor.withOpacity(0.5)),
                                    trailing: TextWidget(
                                      title:
                                          "\$${value.getEventTicketsModel[index].price}/-",
                                      size: 16,
                                      fontWeight: FontWeight.w700,
                                      maxline: 2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.15,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  TextWidget(
                    title: "Ticket Quantity",
                    size: 14,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightGreyColor,
                    ),
                    child: Icon(
                      Icons.add,
                      color: greyColor,
                    ),
                  ),
                  TextWidget(
                    title: "  1  ",
                    size: 14,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appColor,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ],
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookingTicket()));
                },
                child: TextWidget(
                  title: "Checkout",
                  size: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
