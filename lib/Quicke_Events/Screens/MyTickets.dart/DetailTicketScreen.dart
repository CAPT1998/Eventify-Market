import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/GetEventSeatHistoryModel.dart';
import '../../Widgets/TextWidget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class DetailTicketScreen extends StatefulWidget {
  DetailTicketScreen({super.key, required this.model});
  GetEventSeatHistoryModel model;
  @override
  State<DetailTicketScreen> createState() => _DetailTicketScreenState();
}

class _DetailTicketScreenState extends State<DetailTicketScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  late String imagePath;
  Future<void> captureAndSaveScreenshot() async {
    final imageFile = await screenshotController.capture();

    final appDir = await getTemporaryDirectory();
    final fileName = 'ticket_${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImagePath = '${appDir.path}/$fileName';

    final savedFile = File(savedImagePath);
    await savedFile.writeAsBytes(imageFile!);

// Save the image file to the gallery
    await GallerySaver.saveImage(savedImagePath);

    setState(() {
      imagePath = savedImagePath;
    });
    SuccessFlushbar(context, "Success", "Ticket saved to Gallery");
  }

  void _launchThirdPartyApp(BuildContext context) async {
    const thirdPartyAppUri = 'quickeepos://';
    if (await canLaunch(thirdPartyAppUri)) {
      await launch(thirdPartyAppUri);
    } else {
      showDownloadDialog(context);
    }
  }

  void showDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('App Not Installed'),
          content: Text(
              'Quickee Wallet app is not installed. Do you want to download it from the App Store?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Download'),
              onPressed: () {
                _downloadAppFromAppStore();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _downloadAppFromAppStore() async {
    const appStoreUrl =
        'https://apps.apple.com/app/idcom.example.thirdpartyapp';
    if (await canLaunch(appStoreUrl)) {
      await launch(appStoreUrl);
    } else {
      throw 'Could not launch $appStoreUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextWidget(title: "Ticket", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: captureAndSaveScreenshot,
              icon: Icon(
                Icons.file_download_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/img/11.png",
                            width: width,
                            height: height * 0.2,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF).withOpacity(0.3),
                            ),
                            child: TextWidget(
                              title: "${widget.model.eventTitle}",
                              fontWeight: FontWeight.w700,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: "Name",
                        size: 12,
                        fontWeight: FontWeight.w500,
                        color: greyColor.withOpacity(0.3)),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      title: "Emaa Alexander",
                      size: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: Divider(
                        color: greyColor,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                title: "Event date",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor.withOpacity(0.3)),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              title:
                                  "${widget.model.eventStartDate.toString().split(" ")[0]}",
                              size: 16,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                title: "Time",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor.withOpacity(0.3)),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              title: "${widget.model.eventStartTime}",
                              size: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                title: "Event",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor.withOpacity(0.3)),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              title: "${widget.model.seats[0].ticketId}",
                              size: 16,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                title: "Venue",
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor.withOpacity(0.3)),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              title: "The Living",
                              size: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: Divider(
                        color: greyColor,
                      ),
                    ),
                    Image.asset("assets/img/var.png"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  MaterialButton(
                    color: appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minWidth: 50,
                    height: 60,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    title: "Choose Ticket",
                                    fontWeight: FontWeight.w700,
                                    size: 16,
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: lightGreyColor,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                                child: Divider(
                                  color: greyColor,
                                ),
                              ),
                              Image.asset(
                                "assets/img/qrcode.png",
                                height: height * 0.3,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: TextWidget(
                      title: "Show Barcode",
                      size: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 50),
                  MaterialButton(
                    color: appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minWidth: 80,
                    height: 60,
                    onPressed: () {
                      _launchThirdPartyApp(context);
                    },
                    child: TextWidget(
                      title: "Wallet",
                      size: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
