// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/EventDetailsScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/HomeScreens/EventsOrganizersScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/HomeScreens/ExploreNearByEventsScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Notification/NotificationScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/VideoPlayer/VideoPlayerScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/SizedBoxWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../../Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';
import '../../Models/GetEventsModel.dart';
import '../../Models/OrganizersEvent.dart';
import '../../Widgets/TextFormWidget.dart';
import '../DetailOrganizer/DetaillOrganizerdetail.dart';
import 'package:geolocator/geolocator.dart';

import '../DetailOrganizer/DetailsAllOganizerscreen.dart';
import 'CategoryEvents/Categoryevent.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GoogleMapController? _googleMapController;
  List<GetEventsModel> _filteredListReviews = [];
  List<GetEventsModel> getEventsModel = [];
  bool _isfavorite = false;
  bool _isfavoritecollection = false;

  final TextEditingController _searchController = TextEditingController();
  String? addressValue;
  String? currentCountry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcuurentlocation();
    WidgetsBinding.instance.addPostFrameCallback((_) => getRequests(context));
  }

  getRequests(BuildContext context) async {
    await Provider.of<EventProvider>(context, listen: false).mGetEvents();
    String id = Provider.of<AuthProvider>(context, listen: false)
        .loginModel[0]
        .data!
        .id
        .toString();

    await Provider.of<EventProvider>(context, listen: false)
        .fetchOrganizerEvents();
    await Provider.of<EventProvider>(context, listen: false)
        .getFavoriteEvents(id);
    await Provider.of<EventProvider>(context, listen: false)
        .getFavoriteOrganzers(id);
    await Provider.of<EventProvider>(context, listen: false)
        .getEventOrganizers();
    await Provider.of<EventProvider>(context, listen: false)
        .getFavoritecollection(id);
    await Provider.of<EventProvider>(context, listen: false)
        .getcollectionevets();
    await Provider.of<EventProvider>(context, listen: false)
        .mGetEventSeatHistory();
  }

  void getcuurentlocation() async {
    setState(() {
      currentCountry = "Fetching location...";
    });

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        currentCountry = placemarks.first.locality;
      });
    } catch (error) {
      setState(() {
        currentCountry = "Error fetching location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<EventProvider, AuthProvider>(
        builder: (context, value, authvalue, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeWidget(height: 30),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          PersistentNavBarNavigator.pushDynamicScreen(
                            context,
                            screen: MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationFeatures()),
                            withNavBar: false,
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final selectedAddress = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => locationpicker()),
                            );
                            if (selectedAddress != null) {
                              setState(() {
                                addressValue = selectedAddress;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizeWidget(width: 5),
                              TextWidget(
                                  title: addressValue ?? currentCountry!),
                            ],
                          ),
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
                    onChanged: (value) {
                      _filteredListReviews =
                          Provider.of<EventProvider>(context, listen: false)
                              .getEventsModel
                              .where((element) => element.eventTitle!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                      setState(() {});
                    },
                    controller: _searchController,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ExploreNearByEventsScreen()));
                        },
                        child: TextWidget(
                            title: "See All",
                            fontWeight: FontWeight.w500,
                            size: 14,
                            color: appColor),
                      )
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
                                filteredListReviews: _filteredListReviews,
                                searchController: _searchController,
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
                      /*   Spacer(),
                      TextWidget(
                        title: "See All",
                        fontWeight: FontWeight.w500,
                        size: 14,
                        color: appColor,
                      ),*/
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
                        _CategoryWidget(context,
                            icon: Icons.music_note, title: "Music"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.attractions_sharp, title: "Visual Art"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.business_center_outlined,
                            title: "Business"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.favorite_outline, title: "Heart"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.sports, title: "Sports"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.travel_explore, title: "Travel"),
                        SizedBox(
                          width: 20,
                        ),
                        _CategoryWidget(context,
                            icon: Icons.holiday_village, title: "Holidays"),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      TextWidget(
                        title: "Trending Events",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ExploreNearByEventsScreen()));
                        },
                        child: TextWidget(
                            title: "See All",
                            fontWeight: FontWeight.w500,
                            size: 14,
                            color: appColor),
                      )
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
                            filteredListReviews: _filteredListReviews,
                            searchController: _searchController,
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
                  Consumer<EventProvider>(
                    builder: (context, eventvalue, child) => GestureDetector(
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
                                  itemCount: eventvalue.collectionsmodel[0]
                                      .upcomingEvents!.length!,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final event = eventvalue.collectionsmodel[0]
                                        .upcomingEvents![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: EventDetailsScreen(
                                                  model: eventvalue
                                                      .collectionsmodel[0]
                                                      .upcomingEvents![index]),
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
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
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
                            top: 5,
                            right: 10,
                            child: FavoriteButton(
                              iconSize: 50,
                              valueChanged: (_) async {
                                if (!_isfavoritecollection) {
                                  await value.addFavoritecollection(
                                      context,
                                      authvalue.loginModel[0].data?.id,
                                      eventvalue.collectionsmodel[0].id
                                          .toString());
                                  await value.getFavoritecollection(authvalue
                                      .loginModel[0].data!.id
                                      .toString());
                                } else {
                                  await value.removeFavoritecollection(
                                      context,
                                      authvalue.loginModel[0].data?.id,
                                      eventvalue.collectionsmodel[0].id
                                          .toString());
                                  await value.getFavoritecollection(authvalue
                                      .loginModel[0].data!.id
                                      .toString());
                                }
                                setState(() {
                                  _isfavoritecollection =
                                      !_isfavoritecollection;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: height * 0.2,
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
                                    title:
                                        eventvalue.collectionsmodel[0].name ??
                                            "Example Collection",
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
                                        title: eventvalue.collectionsmodel[0]
                                                .upcomingEventsCount
                                                .toString() +
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
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        _moreNearWidget(
                            img: "1",
                            title: "Today",
                            color: greenColor,
                            filteredListReviews: _filteredListReviews,
                            searchController: _searchController,
                            value: value),
                      ],
                    ),
                  ),
                  //  _moreEventsWidget(),
                  //  _moreEventsWidget(),
                  //  _moreEventsWidget(),
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
                          valueChanged: (_isFavorite) async {
                            if (!_isfavorite) {
                              await value.addFavoriteEvents(
                                  context,
                                  authvalue.loginModel[0].data?.id,
                                  value.getEventsModel[0].id);
                              await value.getFavoriteEvents(
                                  authvalue.loginModel[0].data!.id.toString());
                            } else {
                              await value.deleteFavoriteEvents(
                                  context,
                                  authvalue.loginModel[0].data?.id,
                                  value.getEventsModel[0].id);
                              await value.getFavoriteEvents(
                                  authvalue.loginModel[0].data!.id.toString());
                            }
                            setState(() {
                              _isfavorite = !_isfavorite;
                            });
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
                        child: GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: EventDetailsScreen(
                                model: value.getEventsModel[0],
                              ),
                              withNavBar: false,
                            );
                          },
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
                                  title: value.getEventsModel[0].eventTitle,
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
                                      title: value
                                          .getEventsModel[0].eventStartDate,
                                      fontWeight: FontWeight.w500,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    Spacer(),
                                    TextWidget(
                                      title:
                                          "\$ ${value.getEventsModel[0].price} ",
                                      fontWeight: FontWeight.w500,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ExploreNearByEventsScreen()));
                        },
                        child: TextWidget(
                            title: "See All",
                            fontWeight: FontWeight.w500,
                            size: 14,
                            color: appColor),
                      )
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
                            filteredListReviews: _filteredListReviews,
                            searchController: _searchController,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EventsOrganizersScreen()));
                        },
                        child: TextWidget(
                            title: "See All",
                            fontWeight: FontWeight.w500,
                            size: 14,
                            color: appColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.getEventsModel.length,
                        itemBuilder: (context, index) {
                          final eventOrganizerName = value.getEventsModel[index]
                              .eventOrganizer?.organizerName;
                          final eventOrganizerid =
                              value.getEventsModel[index].eventOrganizer?.id;
                          if (eventOrganizerName != null) {
                            return OrganizerWidget(
                              context,
                              eventOrganizerName,
                              eventOrganizerid.toString(),
                              value.getEventsModel,
                            );
                          }
                        }),
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

// ignore: non_constant_identifier_names
Widget OrganizerWidget(
    context, String? organize, String id, List<GetEventsModel> eventmodel) {
  return GestureDetector(
    onTap: () {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: DetailAllOrganizerScreen(
          organizername: organize,
          model: eventmodel,
          organizerid: id,
        ),
        withNavBar: false,
      );
    },
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
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
          TextWidget(title: organize.toString())
        ],
      ),
    ),
  );
}

_NearWidget(
    {required String img,
    required String title,
    dynamic color,
    required TextEditingController searchController,
    required List<GetEventsModel> filteredListReviews,
    required EventProvider value}) {
  if (searchController.text.isEmpty) {
    filteredListReviews = value.getEventsModel;
  }
  return SizedBox(
    height: height * 0.35,
    child: value.checkValueEvent == false
        ? Image.asset("assets/img/loading.gif")
        : filteredListReviews.length == 0
            ? TextWidget(title: "No Event Available")
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final latitude =
                      double.parse(filteredListReviews[index].latitude);
                  final longitude =
                      double.parse(filteredListReviews[index].longitude);
                  final price = filteredListReviews[index].price;
                  final originalPrice = double.parse(price!);
                  final reducedPrice = originalPrice - 15;
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: EventDetailsScreen(
                          model: filteredListReviews[index],
                        ),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10),
                      width: width * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${filteredListReviews[index].eventsPic}",
                                    height: height * 0.17,
                                    width: width * 0.6,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, url, error) =>
                                        Image.asset(
                                      "assets/img/placeholder.jpg",
                                      fit: BoxFit.fill,
                                      height: height * 0.17,
                                      width: width * 0.6,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(5)),
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
                              title: "${filteredListReviews[index].eventTitle}",
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
                                      "  ${filteredListReviews[index].eventStartDate.toString().split(" ")[0]}  .  ${filteredListReviews[index].eventStartTime}",
                                  size: 12,
                                  fontWeight: FontWeight.w500,
                                  color: greyColor,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              title:
                                  "\$ ${reducedPrice.toStringAsFixed(2)} - \$ $originalPrice",
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: darkPurpleColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 15,
                                  color: greyColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                FutureBuilder<List<dynamic>>(
                                  future: placemarkFromCoordinates(
                                      latitude, longitude),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text(
                                        'Loading...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      final placemark = snapshot.data!.first;
                                      return Text(
                                        placemark.name ??
                                            'Address not available',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        'Address not available',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
  );
}

_moreNearWidget(
    {required String img,
    required String title,
    dynamic color,
    required TextEditingController searchController,
    required List<GetEventsModel> filteredListReviews,
    required EventProvider value}) {
  if (searchController.text.isEmpty) {
    filteredListReviews = value.getEventsModel;
  }
  return SizedBox(
    height: height * 0.12,
    child: value.checkValueEvent == false
        ? Image.asset("assets/img/loading.gif")
        : filteredListReviews.length == 0
            ? TextWidget(title: "No Event Available")
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  String price = filteredListReviews[0].price;
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: EventDetailsScreen(
                          model: filteredListReviews[index],
                        ),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      height: 90,
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/img/6.png",
                              height: 70,
                              width: 70,
                              fit: BoxFit.fill,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, top: 5, bottom: 5),
                              margin: EdgeInsets.only(bottom: 10),
                              width: width * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextWidget(
                                    title: filteredListReviews[0].eventTitle,
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
                                        title: filteredListReviews[0]
                                            .eventStartDate,
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                        color: greyColor,
                                      ),
                                      Spacer(),
                                      TextWidget(
                                        title: "\$ $price",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                        color: darkPurpleColor,
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
                },
              ),
  );
}

Widget _CategoryWidget(context,
    {required dynamic icon, required String title}) {
  return GestureDetector(
    onTap: () {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: CategoryEvent(
          title: title,
        ),
        withNavBar: false,
      );
    },
    child: Column(
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
    ),
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
        GestureDetector(
          onTap: () {},
          child: Container(
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
          ),
        )
      ],
    ),
  );
}

class locationpicker extends StatefulWidget {
  @override
  _locationpickerState createState() => _locationpickerState();
}

class _locationpickerState extends State<locationpicker> {
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Events Location'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 600,
          child: Column(
            children: [
              SelectState(
                // style: TextStyle(color: Colors.red),
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
              InkWell(
                onTap: () {
                  String address;

                  if (cityValue.isNotEmpty) {
                    address = cityValue;
                  } else if (stateValue.isNotEmpty) {
                    address = stateValue;
                  } else {
                    address = countryValue;
                  }

                  print('Selected address: $address');
                  Navigator.of(context).pop(address);
                },
                child: SizedBox(
                  width: 150,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightGreyColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizeWidget(width: 3),
                        TextWidget(title: "Confirm Selection"),
                      ],
                    ),
                  ),
                ), //Text('Confirm Selection')
              )
            ],
          )),
    );
  }
}
