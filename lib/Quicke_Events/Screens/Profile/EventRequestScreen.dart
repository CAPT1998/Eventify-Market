import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickie_event/Quicke_Events/Models/GetSingleEventReponseModel.dart';
import 'package:quickie_event/widgets/loading_dialog_builder.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constant.dart';
import '../../Providers/EventsProvider.dart';
import '../../Widgets/TextWidget.dart';

class EventRequestScreen extends StatefulWidget {
  final String? eventId;

  const EventRequestScreen({Key? key, this.eventId}) : super(key: key);

  @override
  State<EventRequestScreen> createState() => _EventRequestScreenState();
}

class _EventRequestScreenState extends State<EventRequestScreen> {
  bool isLoading = false;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  ScreenshotController screenshotController = ScreenshotController();

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextWidget(
          title: "Event Request",
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
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.more_horiz_outlined,
        //         color: greyColor,
        //       ))
        // ],
      ),
      body: FutureBuilder(
          future: Provider.of<EventProvider>(context, listen: false)
              .getSingleEvent(widget.eventId!),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                return Consumer<EventProvider>(
                  builder: (context, orderData, child) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    orderData.getSingleEventDetail.invitation!
                                                .eventsPic !=
                                            null
                                        ? orderData.getSingleEventDetail
                                            .invitation!.eventsPic!
                                        : "assets/img/placeholder.jpg",
                                    height: height * 0.2,
                                    width: width,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, url, error) =>
                                        Image.asset(
                                      "assets/img/placeholder.jpg",
                                      fit: BoxFit.cover,
                                      width: width,
                                      height: height * 0.2,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            title: orderData
                                .getSingleEventDetail.invitation!.eventTitle!,
                            size: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 15,
                                color: greyColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextWidget(
                                title:
                                    "${orderData.getSingleEventDetail.invitation!.eventStartDate!} ${orderData.getSingleEventDetail.invitation!.eventStartTime!} \n${orderData.getSingleEventDetail.invitation!.eventEndDate!} ${orderData.getSingleEventDetail.invitation!.eventEndTime!}",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () async => {
                                              postRequestAction(widget.eventId!,"1")

                                            },
                                    child: isLoading
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : Text("Accept"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: isLoading
                                        ? null
                                        : () => {
                                              postRequestAction(
                                                  widget.eventId!, "0")
                                            },
                                    child: isLoading
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : Text("Reject"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }

  postRequestAction(String eventId, String status) async {
    DialogBuilder(context).showLoadingIndicator();
    String response = await Provider.of<EventProvider>(context, listen: false)
        .postSingleEventAction(eventId, status);
    DialogBuilder(context).hideOpenDialog();

    if (response == "Success") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Request Accepted successfully"),
      ));
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: [
                RoundedLoadingButton(
                  color: appColor,
                  borderRadius: 10,
                  controller:
                  buttonController,
                  onPressed: () {
                    print(
                        'https://quickeeapi.pakwexpo.com?eventId=${widget.eventId}');

                    // _shareQrCode();
                    Navigator.pop(
                        context);
                    buttonController
                        .reset();
                  },
                  child: TextWidget(
                    title: "Okay",
                    color: Colors.white,
                    size: 15,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
                /*   TextButton(
                                          onPressed: () {
                                            if (orderData.getMyEvent.invitations![index].id !=null || orderData.getMyEvent.invitations![index].id.toString().isEmpty) {
                                               */ /* Scaffold.of(context).showSnackBar(
                                                  SnackBar(content: Text('Generate your QR code first')));*/ /*
                                            } else {
                                              _shareQrCode();
                                            }
                                                                              },
                                          child: const Text('Send'),
                                        ),*/
              ],
              content: SizedBox(
                width: 150,
                height: 150,
                child: Center(
                  child: Screenshot(
                      controller:
                      screenshotController,
                      child: QrImage(
                          data:
                          'https://quickeeapi.pakwexpo.com?eventId=${widget.eventId}')),
                ),
              ));
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    }
  }
}

//'https://quickeeapi.pakwexpo.com/Events/' + orderData.getMyPersonalEvent[index].id.toString();
