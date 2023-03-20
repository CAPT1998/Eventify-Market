import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickie_event/Screens/MyTickets.dart/CalenderTicketScreen.dart';
import 'package:quickie_event/Screens/MyTickets.dart/DetailTicketScreen.dart';

import '../../Constant.dart';
import '../../Widgets/TextWidget.dart';

class MyticketScreen extends StatefulWidget {
  const MyticketScreen({super.key});

  @override
  State<MyticketScreen> createState() => _MyticketScreenState();
}

class _MyticketScreenState extends State<MyticketScreen> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          title: TextWidget(title: "My Ticket", size: 16),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CalenderTicketScreen(),
                    withNavBar: false,
                  );
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          padding: const EdgeInsets.all(3),
                          labelColor: greyColor,
                          unselectedLabelColor: Color(0XFFA0A3AD),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          automaticIndicatorColorAdjustment: true,
                          // overlayColor:,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: [
                            const Tab(
                              text: "Upcoming",
                            ),
                            const Tab(
                              text: "Past Ticket",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Flexible(
                      child: SizedBox(
                        child: TabBarView(
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        title: "December 2022", size: 16),
                                    InkWell(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: DetailTicketScreen(),
                                            withNavBar: false,
                                          );
                                        },
                                        child: _TicketWidget()),
                                    _TicketWidget(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextWidget(
                                        title: "November 2022", size: 16),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _TicketWidget(),
                                    _TicketWidget(),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        title: "December 2022", size: 16),
                                    _TicketWidget(),
                                    _TicketWidget(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextWidget(
                                        title: "November 2022", size: 16),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _TicketWidget(),
                                    _TicketWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _TicketWidget() {
  return ClipPath(
    clipper: DolDurmaClipper(right: width * 0.2, holeRadius: 50),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: lightGreyColor,
          border: Border.all(color: greyColor.withOpacity(0.1))),
      width: width,
      height: height * 0.17,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.5,
                child: TextWidget(
                  title: "Drink & Draw at The Living Gallery",
                  maxline: 2,
                  fontWeight: FontWeight.w700,
                  size: 16,
                ),
              ),
              SizedBox(
                width: width * 0.5,
                child: TextWidget(
                    title: "Sun, Dec 11   07:00 PM",
                    fontWeight: FontWeight.w500,
                    size: 12,
                    color: greyColor),
              ),
              SizedBox(
                  width: width * 0.5,
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_sharp,
                        size: 15,
                        color: greyColor,
                      ),
                      TextWidget(
                        title: "  2 Ticket",
                        size: 12,
                        fontWeight: FontWeight.w500,
                        color: greyColor,
                      ),
                      Spacer(),
                      Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: greyColor,
                      ),
                      TextWidget(
                        title: "  The Living Gallery",
                        size: 12,
                        fontWeight: FontWeight.w500,
                        color: greyColor,
                      ),
                    ],
                  )),
            ],
          ),
          Spacer(),
          Image.asset("assets/img/barcode.png")
        ],
      ),
    ),
  );
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width - right - holeRadius, size.height),
        clockwise: false,
        radius: Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
