import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/ShareOptionClass.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../Models/CollectionsModel.dart';
import '../../Models/GetEventsModel.dart';
import '../../Providers/EventsProvider.dart';
import '../EventDetails/EventDetailsScreen.dart';

class DetailAllOrganizerScreen extends StatefulWidget {
  String? organizername;
  String? organizerid;
  List<GetEventsModel> model;

  DetailAllOrganizerScreen(
      {required this.organizername,
      required this.organizerid,
      required this.model,
      super.key});

  @override
  State<DetailAllOrganizerScreen> createState() =>
      _DetailAllOrganizerScreenState();
}

class _DetailAllOrganizerScreenState extends State<DetailAllOrganizerScreen> {
  TabController? _tabController;
  bool _isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventProvider, AuthProvider>(
        builder: (context, eventvalue, authvalue, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey[50],
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
                    FavoriteButton(
                      iconSize: 40,
                      valueChanged: (_isFavorite) async {
                        if (!_isfavorite) {
                          await eventvalue.addFavoriteOrganizer(
                              context,
                              authvalue.loginModel[0].data?.id,
                              widget.organizerid);
                          await eventvalue.getFavoriteOrganzers(
                              authvalue.loginModel[0].data!.id.toString());
                        } else {
                          await eventvalue.removeFavoriteOrganizer(
                              context,
                              authvalue.loginModel[0].data?.id,
                              widget.organizerid);
                          await eventvalue.getFavoriteOrganzers(
                              authvalue.loginModel[0].data!.id.toString());
                        }
                        setState(() {
                          _isfavorite = !_isfavorite;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          ShareSocialClass.shareOptions("contentText");
                        },
                        icon: Icon(
                          Icons.ios_share_sharp,
                          color: greyColor,
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: TextWidget(
                        title: widget.organizername!,
                        size: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      subtitle: TextWidget(
                        title: widget.model[0].eventOrganizer?.location ??
                            " Example Location",
                        size: 12,
                        color: greyColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                      leading: Image.asset(
                        "assets/img/f1.png",
                        height: 70,
                        width: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
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
                                      text: "Events",
                                    ),
                                    const Tab(
                                      text: "Collections",
                                    ),
                                    const Tab(
                                      text: "About",
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
                                    SingleChildScrollView(
                                      child: Consumer<EventProvider>(
                                        builder: (context, value, child) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                NeverScrollableScrollPhysics(), // Disable scrolling of the inner ListView
                                            itemCount:
                                                value.getEventsModel.length,
                                            itemBuilder: (context, index) {
                                              String organizername = value
                                                      .getEventsModel[index]
                                                      .eventOrganizer
                                                      ?.organizerName ??
                                                  "Exmple Event";
                                              if (widget.organizername ==
                                                  organizername) {
                                                return _EventsWidget(
                                                    context,
                                                    value
                                                        .getEventsModel[index]);
                                              } else {
                                                return Container();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Consumer<EventProvider>(
                                        builder: (context, value, child) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                NeverScrollableScrollPhysics(), // Disable scrolling of the inner ListView
                                            itemCount:
                                                value.collectionsmodel.length,
                                            itemBuilder: (context, index) {
                                              String collectionid = value
                                                      .collectionsmodel[index]
                                                      .id
                                                      ?.toString() ??
                                                  "0";
                                              if (widget.organizerid ==
                                                  collectionid) {
                                                return _CollectionsWidet(
                                                    context,
                                                    value.collectionsmodel[
                                                        index]);
                                              } else {
                                                return Container();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextWidget(
                                              title: widget.model[0]
                                                      .eventOrganizer?.bio! ??
                                                  "Example Bio",
                                              size: 14,
                                              maxline: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
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
            ));
  }
}

Widget _EventsWidget(context, GetEventsModel eventmodel) {
  DateTime parsedDateTime = DateTime.parse(eventmodel.eventStartDate!);

  return GestureDetector(
    onTap: () {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: EventDetailsScreen(
          model: eventmodel,
        ),
        withNavBar: false,
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/img/13.png",
              width: width,
              height: height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: FavoriteButton(
              iconSize: 40,
              valueChanged: (_isFavorite) {
                print('Is Favorite $_isFavorite)');
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.only(top: 10, left: 10),
            decoration: BoxDecoration(
                color: yellowColor, borderRadius: BorderRadius.circular(5)),
            child: TextWidget(
              title: "Flash Deal",
              fontWeight: FontWeight.w700,
              size: 8,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: height * 0.1,
              width: width * 0.9,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: eventmodel.eventTitle!,
                    fontWeight: FontWeight.w700,
                    size: 14,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                      TextWidget(
                        title: DateFormat('yyyy-MM-dd').format(parsedDateTime),
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: Colors.white,
                      ),
                      Spacer(),
                      TextWidget(
                        title: "\$ ${eventmodel.price}",
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _CollectionsWidet(context, CollectionModel model) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upcoming Events'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.upcomingEvents!.length!,
                itemBuilder: (BuildContext context, int index) {
                  final event = model.upcomingEvents![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: EventDetailsScreen(
                                model: model.upcomingEvents![index]),
                            withNavBar: false,
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              event.eventTitle!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                decorationColor: Colors.black,
                                decorationThickness: 2.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                  ),
                                ],
                                letterSpacing: 0.5,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/img/5.png",
              width: width,
              height: height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: height * 0.3,
              width: width * 0.8,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: model.name!,
                    fontWeight: FontWeight.w700,
                    size: 14,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: appColor,
                        child: Icon(
                          Icons.crisis_alert_rounded,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      TextWidget(
                        title: "  by Eventer",
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: Colors.white,
                      ),
                      Spacer(),
                      TextWidget(
                        title: model.upcomingEventsCount.toString() +
                            " Upcoming Events ",
                        fontWeight: FontWeight.w500,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
