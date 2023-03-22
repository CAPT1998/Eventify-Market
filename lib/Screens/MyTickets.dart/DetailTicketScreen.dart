import 'package:flutter/material.dart';

import '../../Constant.dart';
import '../../Widgets/TextWidget.dart';

class DetailTicketScreen extends StatefulWidget {
  const DetailTicketScreen({super.key});

  @override
  State<DetailTicketScreen> createState() => _DetailTicketScreenState();
}

class _DetailTicketScreenState extends State<DetailTicketScreen> {
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
              onPressed: () {},
              icon: Icon(
                Icons.file_download_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                            title: "Drink & Draw at The Living Gallery",
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
                            title: "Dec 11, 2022",
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
                            title: "07:00 PM",
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
                              title: "Ticket seat",
                              size: 12,
                              fontWeight: FontWeight.w500,
                              color: greyColor.withOpacity(0.3)),
                          SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            title: "Regular",
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                color: appColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                minWidth: width,
                height: 60,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
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
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Divider(
                                    color: greyColor,
                                  ),
                                ),
                                Image.asset("assets/img/qrcode.png",height: height*0.3,),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ));
                },
                child: TextWidget(
                  title: "Show Barcode",
                  size: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
