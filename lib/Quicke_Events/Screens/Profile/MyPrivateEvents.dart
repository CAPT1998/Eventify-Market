import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Widgets/TextWidget.dart';

class MyPrivateEvents extends StatefulWidget {
  const MyPrivateEvents({super.key});

  @override
  State<MyPrivateEvents> createState() => _MyPrivateEventsState();
}

class _MyPrivateEventsState extends State<MyPrivateEvents> {
  ScreenshotController screenshotController = ScreenshotController();
  RoundedLoadingButtonController buttonController =
  RoundedLoadingButtonController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrivateEvents();

  }
  Future<void> getPrivateEvents() async {
   await Provider.of<EventProvider>(context, listen: false).mPersonalEvents();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextWidget(
            title: "My Events",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                  itemCount: value.getMyPersonalEvent.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 30, bottom: 10, left: 30),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "${value.getMyPersonalEvent[index].eventsPic}",
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
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                      // color: color,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(Icons.share),
                                ),
                                onTap: () async {
                                  print(value.getMyPersonalEvent[index].id);

                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        RoundedLoadingButton(
                                          color: appColor,
                                          borderRadius: 10,
                                          controller: buttonController,
                                          onPressed: () {
                                            print('https://quickeeapi.pakwexpo.com?eventId=${value.getMyPersonalEvent[index].id}');
                                            _shareQrCode();
                                            buttonController.reset();
                                          },
                                          child: TextWidget(
                                            title: "Share",
                                            color: Colors.white,
                                            size: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                     /*   TextButton(
                                          onPressed: () {
                                            if (value.getMyPersonalEvent[index].id !=null || value.getMyPersonalEvent[index].id.toString().isEmpty) {
                                             *//* Scaffold.of(context).showSnackBar(
                                                  SnackBar(content: Text('Generate your QR code first')));*//*
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
                                        child: Center(child: Screenshot(
                                            controller: screenshotController,
                                            child: QrImage(data: 'https://quickeeapi.pakwexpo.com?eventId=${value.getMyPersonalEvent[index].id}')),
                                      ),
                                    ));
                                  },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            title:
                                "${value.getMyPersonalEvent[index].eventTitle}",
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
                              TextWidget(
                                title:
                                    "  ${value.getMyPersonalEvent[index].eventStartDate.toString().split(" ")[0]}  .  ${value.getMyPersonalEvent[index].eventStartTime}",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                              ),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }


  _shareQrCode() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((dynamic image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          if (imagePath != null) {
            await imagePath.writeAsBytes(image);
            print(imagePath.path);
            Share.shareFiles([imagePath.path]);
          }
        } catch (error) {}
      }
    }).catchError((onError) {
      print('Error --->> $onError');
    });
  }
}

Widget _NearWidget(
    {required String img, required String title, dynamic color}) {
  return Container(
    margin: EdgeInsets.only(right: 30, bottom: 10, left: 30),
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/img/$img.png",
                    height: height * 0.2, width: width, fit: BoxFit.fill)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(top: 10, left: 10),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.share),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
          title: "Bring Me The Horizon Tour",
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
            TextWidget(
              title: "  Nov 27  .  07:00 PM",
              size: 12,
              fontWeight: FontWeight.w500,
              color: greyColor,
            ),
            Spacer(),
            TextWidget(
              title: "\$39.00",
              size: 12,
              fontWeight: FontWeight.w500,
              color: darkPurpleColor,
            ),
          ],
        )
      ],
    ),
  );
}
