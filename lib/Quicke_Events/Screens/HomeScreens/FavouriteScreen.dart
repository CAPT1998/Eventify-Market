import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/Quicke_Events/Screens/HomeScreens/FavouriteEmptyScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../Models/CollectionsModel.dart';
import '../../Models/GetEventsModel.dart';
import '../../Models/GetFavoriteEvents.dart';
import '../../Models/UserFavoriteOrganizer.dart';
import '../../Providers/EventsProvider.dart';
import '../DetailOrganizer/DetaillOrganizerdetail.dart';
import '../DetailOrganizer/DetailsAllOganizerscreen.dart';
import '../DetailOrganizer/FavoriteDetailOrganizer.dart';
import '../EventDetails/EventDetailsScreen.dart';
import 'FavouriteEventDetailsScreen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<EventProvider, AuthProvider>(
        builder: (context, eventvalue, authvalue, child) => Scaffold(
          appBar: AppBar(
            leading: null,
            title: TextWidget(title: "Favorites", size: 16),
            backgroundColor: Colors.grey[50],
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: FavoriteEmptyScreen(),
                    withNavBar: false,
                  );
                },
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
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
                                text: "Organizers",
                              ),
                              const Tab(
                                text: "Collections",
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
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            NeverScrollableScrollPhysics(), // Disable scrolling of the inner ListView
                                        itemCount:
                                            eventvalue.favoriteevents.length,
                                        itemBuilder: (context, index) {
                                          return _NearWidget(context,
                                              img: "1",
                                              title: eventvalue
                                                  .favoriteevents[index]
                                                  .eventTitle!,
                                              color: yellowColor,
                                              model: eventvalue
                                                  .getEventsModel[index]);
                                        }),
                                    if (eventvalue.favoriteevents == null ||
                                        eventvalue.favoriteevents.isEmpty)
                                      Center(
                                        child: Text(
                                          "No favorite events available.",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: eventvalue
                                            .favoriteorganizers.length,
                                        itemBuilder: (context, index) {
                                          return _FavoriteOrganizer(context,
                                              img: "1",
                                              id: eventvalue
                                                  .favoriteorganizers[index].id
                                                  .toString(),
                                              title: eventvalue
                                                  .favoriteorganizers[index]
                                                  .organizerName!,
                                              color: yellowColor,
                                              model: eventvalue
                                                  .favoriteorganizers[index]);
                                        }),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: eventvalue
                                            .favoritecollection.length,
                                        itemBuilder: (context, index) {
                                          return _CollectionsWidget(
                                              context,
                                              eventvalue
                                                  .favoritecollection[index]);
                                        }),
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
      ),
    );
  }
}

Widget _NearWidget(context,
    {required String img,
    required String title,
    dynamic color,
    required GetEventsModel model}) {
  return Container(
    margin: EdgeInsets.only(right: 30, bottom: 10, left: 30),
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: EventDetailsScreen(
                model: model,
              ),
              withNavBar: false,
            );
          },
          child: Stack(
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
                child: TextWidget(
                  title: "$title",
                  fontWeight: FontWeight.w700,
                  size: 8,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
          title: model.eventTitle!,
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
              title: model.eventStartDate!,
              size: 12,
              fontWeight: FontWeight.w500,
              color: greyColor,
            ),
            Spacer(),
            TextWidget(
              title: "\$ ${model.price}",
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

Widget _FavoriteOrganizer(context,
    {required String img,
    required String id,
    required String title,
    dynamic color,
    required UserFavoriteOrganizer model}) {
  return Container(
    margin: EdgeInsets.only(right: 30, bottom: 10, left: 30),
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: DetailOrganizerScreen(
                model: model,
                organizername: title,
                organizerid: id,
              ),
              withNavBar: false,
            );
          },
          child: Stack(
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
                child: TextWidget(
                  title: model.organizerName!,
                  fontWeight: FontWeight.w700,
                  size: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _CollectionsWidget(context, CollectionModel model) {
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
                itemCount: model.organizer!.events?.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = model.organizer!.events![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: EventDetailsScreen(
                                model: model.organizer!.events![index]),
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
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    },
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 30, bottom: 10, left: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/img/5.png",
              width: width,
              height: height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: height * 0.2,
            width: width * 0.8,
            margin: EdgeInsets.only(right: 40, bottom: 30, left: 40, top: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(0XFFFFFFFF).withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: model.name ?? "Example Collection",
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
                      title: model.organizer!.events!.length.toString() +
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
  );
}
