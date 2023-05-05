import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/EventDetailsScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Notification/NotificationScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/VideoPlayer/VideoPlayerScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/SizedBoxWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../Widgets/TextFormWidget.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GoogleMapController? _googleMapController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).mGetEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<EventProvider>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeWidget(height: 30),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizeWidget(width: 5),
                            TextWidget(title: "New York City"),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: NotificationScreen(),
                              withNavBar: false,
                            );
                          },
                          icon: Icon(Icons.notifications_active_outlined),
                        ),
                      ),
                    ],
                  ),
                  SizeWidget(height: 30),
                  textfieldProduct(
                    context: context,
                    name: "Search events",
                    prefixIcon: Icon(Icons.search),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextWidget(
                        title: "Explore Nearby",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      TextWidget(
                          title: "See All",
                          fontWeight: FontWeight.w500,
                          size: 14,
                          color: appColor)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              // PersistentNavBarNavigator.pushNewScreen(
                              //   context,
                              //   screen: VideoPlayerScreen(),
                              //   withNavBar: false,
                              // );
                            },
                            child: _NearWidget(
                                img: "1",
                                title: "Today",
                                color: greenColor,
                                value: value)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextWidget(
                        title: "Trending Categories",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      TextWidget(
                        title: "See All",
                        fontWeight: FontWeight.w500,
                        size: 14,
                        color: appColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _CategoryWidget(icon: Icons.music_note, title: "Music"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.attractions_sharp, title: "Visual Art"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.business_center_outlined,
                            title: "Business"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.favorite_outline, title: "Heart"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(icon: Icons.music_note, title: "Music"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.attractions_sharp, title: "Visual Art"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.business_center_outlined,
                            title: "Business"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(
                            icon: Icons.favorite_outline, title: "Heart"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextWidget(
                        title: "Trending Categories",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      TextWidget(
                          title: "See All",
                          fontWeight: FontWeight.w500,
                          size: 14,
                          color: appColor)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _NearWidget(
                            img: "3",
                            title: "",
                            color: Colors.transparent,
                            value: value),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: "Hand-picked Collection",
                    fontWeight: FontWeight.w700,
                    size: 16,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
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
                          height: height * 0.1,
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
                                title: "The Best Art Events in New York",
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
                                    title: "8 Upcoming events",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: "More Events",
                    fontWeight: FontWeight.w700,
                    size: 16,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _moreEventsWidget(),
                  _moreEventsWidget(),
                  _moreEventsWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/img/11.png",
                            width: width,
                            height: height * 0.25,
                            fit: BoxFit.fill,
                          ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            color: yellowColor,
                            borderRadius: BorderRadius.circular(5)),
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
                                title: "Drink & Draw at The Living Gallery",
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
                                    title: "  Nov 27, 07:00 PM",
                                    fontWeight: FontWeight.w500,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  Spacer(),
                                  TextWidget(
                                    title: "\$39.00",
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: "Popular Now",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      TextWidget(
                          title: "See All",
                          fontWeight: FontWeight.w500,
                          size: 14,
                          color: appColor)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _NearWidget(
                            img: "1",
                            title: "Today",
                            color: greenColor,
                            value: value),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextWidget(
                    title: "Explore Nearby",
                    fontWeight: FontWeight.w700,
                    size: 16,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        onMapCreated: ((controller) =>
                            _googleMapController = controller),
                        zoomGesturesEnabled: true,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-34.307381, 150.518051),
                          zoom: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextWidget(
                        title: "Organizers ",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      TextWidget(
                          title: "See All",
                          fontWeight: FontWeight.w500,
                          size: 14,
                          color: appColor)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OrganizerWidget(),
                        OrganizerWidget(),
                        OrganizerWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget OrganizerWidget() {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
    margin: EdgeInsets.only(right: 20),
    width: width * 0.35,
    decoration: BoxDecoration(
      border: Border.all(
        color: greyColor.withOpacity(0.3),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/img/6.png",
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            )),
        SizedBox(
          height: 10,
        ),
        TextWidget(title: "Brooklyn Nav")
      ],
    ),
  );
}

_NearWidget(
    {required String img,
    required String title,
    dynamic color,
    required EventProvider value}) {
  return SizedBox(
    height: height * 0.25,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: value.getEventsModel.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: EventDetailsScreen(
                model: value.getEventsModel[index],
              ),
              withNavBar: false,
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 10, bottom: 10),
            width: width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${value.getEventsModel[index].eventsPic}",
                        height: height * 0.17,
                        width: width * 0.6,
                        fit: BoxFit.fill,
                        errorBuilder: (context, url, error) => Image.asset(
                          "assets/img/placeholder.jpg",
                          fit: BoxFit.fill,
                          height: height * 0.17,
                          width: width * 0.6,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  title: "${value.getEventsModel[index].eventTitle}",
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
                          "  ${value.getEventsModel[index].eventStartDate.toString().split(" ")[0]}  .  ${value.getEventsModel[index].eventStartTime}",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: greyColor,
                    ),
                    Spacer(),
                    TextWidget(
                      title: "\$ ${value.getEventsModel[index].price}",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: darkPurpleColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget _CategoryWidget({required dynamic icon, required String title}) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: appColor, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      TextWidget(
        title: "$title",
        size: 14,
        fontWeight: FontWeight.w500,
      )
    ],
  );
}

Widget _moreEventsWidget() {
  return Container(
    height: 90,
    width: width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/img/6.png",
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: EdgeInsets.only(bottom: 10),
          width: width * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextWidget(
                title: "Gala Galactica: New Year's",
                fontWeight: FontWeight.w600,
                size: 16,
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
        )
      ],
    ),
  );
}
