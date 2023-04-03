import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickie_event/Constant.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class MapCategoryScreen extends StatefulWidget {
  const MapCategoryScreen({super.key});

  @override
  State<MapCategoryScreen> createState() => _MapCategoryScreenState();
}

class _MapCategoryScreenState extends State<MapCategoryScreen> {
  GoogleMapController? _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizeWidget(height: 30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: textfieldProduct(
                    context: context,
                    name: "Search events",
                    suffixIcon: IconButton(
                        onPressed: () {
                          _bottomSheet(context);
                        },
                        icon: Icon(Icons.compare_arrows_sharp)),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Icon(Icons.close)
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
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
                Positioned(
                  top: 20,
                  left: 20,
                  child: SizedBox(
                    height: 100,
                    // width: width*0.9,
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          _RowWidget(
                              title: "All Events", icon: Icons.list_rounded),
                          _RowWidget(title: "Music", icon: Icons.music_note),
                          _RowWidget(
                              title: "Sports",
                              icon: Icons.sports_basketball_outlined),
                          _RowWidget(
                              title: "Gallery", icon: Icons.image_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Column(
                    children: [
                      _moreEventsWidget(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        padding: EdgeInsets.all(10),
                        width: width*0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: TextWidget(
                          title: "10,675 events",
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _RowWidget({required String title, dynamic icon}) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(icon),
        TextWidget(
          title: "$title",
        )
      ],
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextWidget(
                      title: "Filters",
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
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        TextWidget(
                          title: "  Dates",
                          size: 14,
                        ),
                      ],
                    ),
                    children: [],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.space_dashboard_outlined),
                        TextWidget(
                          title: "  Category",
                          size: 14,
                        ),
                      ],
                    ),
                    children: [
                      ListTile(
                        leading: Icon(Icons.category),
                        title: TextWidget(
                            title: "Visual Art",
                            color: greyColor.withOpacity(0.5)),
                        trailing: Checkbox(value: false, onChanged: (value) {}),
                      ),
                      ListTile(
                        leading: Icon(Icons.business_center_outlined),
                        title: TextWidget(
                            title: "Business",
                            color: greyColor.withOpacity(0.5)),
                        trailing: Checkbox(value: true, onChanged: (value) {}),
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite_border),
                        title: TextWidget(
                            title: "Heart", color: greyColor.withOpacity(0.5)),
                        trailing: Checkbox(value: false, onChanged: (value) {}),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.event_note_outlined),
                        TextWidget(
                          title: "  Event Type",
                          size: 14,
                        ),
                      ],
                    ),
                    children: [],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGreyColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.price_change_outlined),
                        TextWidget(
                          title: "  Price",
                          size: 14,
                        ),
                      ],
                    ),
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget _moreEventsWidget() {
  return Container(
    margin: EdgeInsets.all(20),
    height: 90,
    padding: EdgeInsets.all(10),
    // width: width,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
