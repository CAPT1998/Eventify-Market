import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Models/GetEventsModel.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/BookingTicket.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/TicketScreen.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../ConstantModels/LoginModel.dart';
import '../../../ConstantProviders/AuthProviders.dart';
import '../../Models/GetFavoriteEvents.dart';
import '../../Widgets/TextWidget.dart';

class FavouriteEventDetailsScreen extends StatefulWidget {
  FavouriteEventDetailsScreen({super.key, required this.model});
  Getfavoriteevents model;

  @override
  State<FavouriteEventDetailsScreen> createState() =>
      _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<FavouriteEventDetailsScreen> {
  GoogleMapController? _googleMapController;
  List<GetEventsModel> _filteredListReviews = [];
  Map<DateTime, List<dynamic>> _events = {};
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  String remindertime = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false)
        .mGetEventTickets(id: "${widget.model.id}");
    Provider.of<EventProvider>(context, listen: false)
        .mGetEventSeats(id: "${widget.model.id}");
    Provider.of<EventProvider>(context, listen: false)
        .mGetTablesEvent(id: "${widget.model.id}");
    getProfileInfo();
  }

  LoginModel? profile;

  LoginModel? getProfileInfo() {
    final box = GetStorage();
    String? userData = box.read("userKey");

    if (userData != null) {
      Map<String, dynamic> jsonMap = jsonDecode(userData);
      setState(() {
        profile = LoginModel.fromJson(jsonMap);
        print("name is" + profile!.data!.email!);
      });
      return profile;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    "${widget.model.eventsPic}",
                    width: width,
                    height: height * 0.35,
                    fit: BoxFit.fill,
                    errorBuilder: (context, url, error) => Image.asset(
                      "assets/img/placeholder.jpg",
                      fit: BoxFit.cover,
                      width: width,
                      height: height * 0.35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Consumer2<EventProvider, AuthProvider>(
                          builder: (context, eventvalue, authvalue, child) =>
                              GestureDetector(
                            onTap: () {},
                            child: FavoriteButton(
                              iconSize: 40,
                              valueChanged: (_isFavorite) async {
                                await eventvalue.addFavoriteEvents(
                                    context,
                                    authvalue.loginModel[0].data?.id,
                                    widget.model.id);
                                await eventvalue.getFavoriteEvents(authvalue
                                    .loginModel[0].data!.id
                                    .toString());
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: height * 0.1,
                      width: width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0XFFFFFFFF).withOpacity(0.3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: "${widget.model.eventTitle}",
                            fontWeight: FontWeight.w700,
                            size: 20,
                            color: Colors.white,
                          ),
                          Spacer(),
                          TextWidget(
                            title: "By Living Gallery",
                            fontWeight: FontWeight.w500,
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(title: "Date and time", size: 16),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: lightGreyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: TextWidget(
                          title: "${widget.model.eventStartDate}".split(" ")[0],
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: TextWidget(
                          title:
                              "${widget.model.eventStartTime} - ${widget.model.eventEndTime}",
                          size: 12,
                          color: greyColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            await _deviceCalendarPlugin.requestPermissions();

                            var calendarsResult =
                                await _deviceCalendarPlugin.retrieveCalendars();
                            print("here");
                            if (calendarsResult.isSuccess &&
                                calendarsResult.data?.isNotEmpty == true) {
                              var defaultCalendar = calendarsResult.data![0];

                              var eventDate = widget.model.eventStartDate;
                              DateTime parsedDateTime =
                                  DateTime.parse(eventDate!);

// Convert the event date to a TZDateTime object
                              var timeZone = tz.getLocation(
                                  'UTC'); // Replace 'your_timezone' with the desired timezone
                              var eventDateTime =
                                  tz.TZDateTime.from(parsedDateTime, timeZone);
                              var event = Event(defaultCalendar.id);
                              event.title = "Quickee event Reminder";
                              event.start = eventDateTime;
                              event.end =
                                  eventDateTime.add(Duration(minutes: 15));
                              event.reminders = [
                                Reminder(minutes: 30),
                                Reminder(minutes: 60),
                              ];

                              // Create the recurrence rule for a daily event
                              var recurrenceRule = RecurrenceRule(
                                RecurrenceFrequency.Daily,
                                interval: 1,
                                endDate: eventDateTime,
                              );
                              event.recurrenceRule = recurrenceRule;

                              // Add the reminder event to the calendar
                              var addResult = await _deviceCalendarPlugin
                                  .createOrUpdateEvent(event);

                              if (addResult!.isSuccess &&
                                  addResult.data != null) {
                                // Reminder added successfully
                                print("Auto reminder added to calendar");
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Reminder added to calendar!',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Date: ${eventDateTime.toLocal().toString().split(' ')[0]}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Time: ${eventDateTime.toLocal().toString().split(' ')[1].substring(0, 5)}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // Failed to add reminder
                                print(
                                    "Failed to add auto reminder to calendar");
                              }
                            } else {
                              // No calendars found
                              print("No calendars found");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lightGreyColor,
                            ),
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: appColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      title: "About this event",
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      title: "${widget.model.about}",
                      size: 14,
                      maxline: 4,
                      fontWeight: FontWeight.w700,
                      color: greyColor.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      title: "Location",
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      width: width,
                      child: widget.model.latitude == null ||
                              widget.model.longitude == null
                          ? Center(child: Text("No Location Available"))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GoogleMap(
                                onMapCreated: ((controller) =>
                                    _googleMapController = controller),
                                zoomGesturesEnabled: true,
                                myLocationEnabled: false,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: true,
                                markers: Set<Marker>.of([
                                  Marker(
                                    markerId: MarkerId("1"),
                                    position: LatLng(
                                        double.parse(widget.model.latitude!),
                                        double.parse(widget.model.longitude!)),
                                    // infoWindow:
                                    //     InfoWindow(title: markerIdVal, snippet: '*'),
                                    onTap: () {},
                                  ),
                                ]),
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      double.parse(widget.model.latitude!),
                                      double.parse(widget.model.longitude!)),
                                  zoom: 16.0,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    TextWidget(
                      title:
                          "The Living Gallery 1094 Broadway Brooklyn, NY 11221 United States",
                      size: 14,
                      maxline: 2,
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: lightGreyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: TextWidget(
                          title: "Eventer Best Price Guarentee",
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: TextWidget(
                          title:
                              "Best price or we'll send you 110% of the difference.",
                          size: 12,
                          maxline: 2,
                          color: greyColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: appColor,
                          child: Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      title: "Tags",
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: widget.model.tags?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              _TagWidget("${widget.model.tags![index]}"),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // OrganizerWidget(widget.model.eventOrganizer),
                    // OrganizerWidget(widget.model.eventOrganizer),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        TextWidget(
                          title: "Similiar Events",
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
                          _NearWidget(context,
                              img: "3",
                              title: "",
                              color: Colors.transparent,
                              filteredListReviews: _filteredListReviews),
                          _NearWidget(context,
                              filteredListReviews: _filteredListReviews,
                              img: "4",
                              title: "Flash Deal",
                              color: yellowColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            color: appColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            minWidth: width,
            height: 50,
            onPressed: () {
              // _bottomSheet(context);
              //   Navigator.push(
              //       context,
              //    MaterialPageRoute(
              //        builder: (context) => TicketScreen(
              //             model: widget.model,
              //          )));
            },
            child: TextWidget(
              title: "Buy Ticket",
              size: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _TagWidget(String title) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: lightGreyColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextWidget(
      title: "$title",
      size: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}

class OrganizerWidget extends StatefulWidget {
  String? name;

  OrganizerWidget(this.name, {super.key});
  @override
  _OrganizerWidgetState createState() => _OrganizerWidgetState();
}

class _OrganizerWidgetState extends State<OrganizerWidget> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: lightGreyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: TextWidget(
          title: widget.name!,
          size: 14,
          fontWeight: FontWeight.w500,
        ),
        subtitle: TextWidget(
          title: "10.5K Followers",
          size: 12,
          color: greyColor.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        leading: Image.asset(
          "assets/img/f1.png",
        ),
        trailing: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: appColor,
          onPressed: () {
            setState(() {
              isFollowing = !isFollowing;
            });
          },
          child: TextWidget(
            title: isFollowing ? "Unfollow" : "Follow",
            size: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget _NearWidget(context,
    {required String img,
    required List<GetEventsModel> filteredListReviews,
    required String title,
    dynamic color}) {
  return GestureDetector(
    onTap: () {
      //  PersistentNavBarNavigator.pushNewScreen(
      //    context,
      //    screen: EventDetailsScreen(
      //       model: filteredListReviews[0],
      //   ),
      //    withNavBar: false,
      //   );
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
                  child: Image.asset("assets/img/$img.png",
                      height: height * 0.17,
                      width: width * 0.6,
                      fit: BoxFit.fill)),
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
    ),
  );
}

void _bottomSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.6,
          padding: EdgeInsets.all(20),
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
              Divider(
                color: greyColor,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TicketWidget(
                    padding: EdgeInsets.all(20),
                    width: width * 0.4,
                    height: height * 0.3,
                    color: Color.fromARGB(255, 228, 228, 228),
                    isCornerRounded: true,
                    // shadow: [
                    //   BoxShadow(
                    //     spreadRadius: 2,
                    //     blurRadius: 4,
                    //     offset: Offset(0, 4),
                    //     color: Colors.grey.withOpacity(0.4),
                    //   )
                    // ],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: appColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          title: "Regular",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        TextWidget(
                            title: "Admission to the in-person drink & draw.",
                            size: 10,
                            fontWeight: FontWeight.w400,
                            maxline: 2,
                            color: greyColor.withOpacity(0.5)),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          color: greyColor,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            title: "\$39.00/pax",
                            size: 16,
                            fontWeight: FontWeight.w700,
                            maxline: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  TicketWidget(
                    padding: EdgeInsets.all(20),
                    width: width * 0.4,
                    height: height * 0.3,
                    color: Color.fromARGB(255, 228, 228, 228),
                    isCornerRounded: true,
                    // shadow: [
                    //   BoxShadow(
                    //     spreadRadius: 2,
                    //     blurRadius: 4,
                    //     offset: Offset(0, 4),
                    //     color: Colors.grey.withOpacity(0.4),
                    //   )
                    // ],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer_sharp,
                          color: appColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          title: "Premium",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        TextWidget(
                            title: "Admission to the in-person drink & draw.",
                            size: 10,
                            fontWeight: FontWeight.w400,
                            maxline: 2,
                            color: greyColor.withOpacity(0.5)),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          color: greyColor,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            title: "\$45.00/pax",
                            size: 16,
                            fontWeight: FontWeight.w700,
                            maxline: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextWidget(
                    title: "Ticket Quantity",
                    size: 14,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lightGreyColor,
                    ),
                    child: Icon(
                      Icons.add,
                      color: greyColor,
                    ),
                  ),
                  TextWidget(
                    title: "  1  ",
                    size: 14,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appColor,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: appColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                minWidth: width,
                height: 50,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookingTicket()));
                },
                child: TextWidget(
                  title: "Checkout",
                  size: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      });
}
