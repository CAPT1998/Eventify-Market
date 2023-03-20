import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Screens/DetailOrganizer/DetaillOrganizerdetail.dart';
import 'package:quickie_event/Screens/EventDetails/ContactInformationScreen.dart';
import 'package:quickie_event/Widgets/TextWidget.dart';

class TicketOrderCompletedScreen extends StatefulWidget {
  const TicketOrderCompletedScreen({super.key});

  @override
  State<TicketOrderCompletedScreen> createState() =>
      _TicketOrderCompletedScreenState();
}

class _TicketOrderCompletedScreenState
    extends State<TicketOrderCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: greyColor,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/img/21.png"),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              title: "Order Complete",
              size: 24,
            ),
            TextWidget(
                title:
                    "Etiam cras nec metus laoreet. Faucibus iaculis cras ut posuere.",
                size: 14,
                maxline: 2,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 20,
            ),
            Spacer(),
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
                title: "View Ticket",
                size: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: greyColor.withOpacity(0.5)),
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
                          builder: (context) =>
                              DetailOrganizerScreen()));
                },
                child: TextWidget(
                  title: "Discover More Event",
                  size: 16,
                  fontWeight: FontWeight.w700,
                  color: appColor,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
