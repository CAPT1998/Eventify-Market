import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/MapCategoryScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/SearchScreen.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../Models/GetEventsModel.dart';
import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../EventDetails/EventDetailsScreen.dart';

class SearchCategoryScreen extends StatefulWidget {
  const SearchCategoryScreen({super.key});

  @override
  State<SearchCategoryScreen> createState() => _SearchCategoryScreenState();
}

class _SearchCategoryScreenState extends State<SearchCategoryScreen> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizeWidget(height: 30),
            Row(
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
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()));
                        },
                        icon: Icon(Icons.search)),
                  ),
                ),
                Icon(Icons.close)
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: DefaultTabController(
                length: 5,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      padding: const EdgeInsets.all(3),
                      labelColor: greyColor,
                      unselectedLabelColor: Color(0XFFA0A3AD),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
                        const Tab(
                          text: "All Events",
                          icon: Icon(Icons.line_style_rounded),
                        ),
                        const Tab(
                          text: "Music",
                          icon: Icon(Icons.music_note),
                        ),
                        const Tab(
                          text: "Sports",
                          icon: Icon(Icons.sports_basketball),
                        ),
                        const Tab(
                          text: "Holiday",
                          icon: Icon(Icons.image_search),
                        ),
                        const Tab(
                          text: "Business",
                          icon: Icon(Icons.add_business_outlined),
                        ),
                      ],
                    ),
                    Flexible(
                      child: SizedBox(
                        child: Consumer<EventProvider>(
                          builder: (context, value, child) => TabBarView(
                            // controller: _tabController,
                            // physics: NeverScrollableScrollPhysics(),
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _NearWidget(
                                      cat: "1",
                                      title: "Flash Deal",
                                      color: yellowColor,
                                      eventmodel: value.getEventsModel,
                                      value: value,
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _NearWidget2(
                                      cat: "Music",
                                      title: "Flash Deal",
                                      color: yellowColor,
                                      eventmodel: value.getEventsModel,
                                      value: value,
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _NearWidget2(
                                      cat: "Sports",
                                      title: "Flash Deal",
                                      color: yellowColor,
                                      eventmodel: value.getEventsModel,
                                      value: value,
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _NearWidget2(
                                      cat: "Holiday",
                                      title: "Flash Deal",
                                      color: yellowColor,
                                      eventmodel: value.getEventsModel,
                                      value: value,
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    _NearWidget2(
                                      cat: "Business",
                                      title: "Flash Deal",
                                      color: yellowColor,
                                      eventmodel: [],
                                      value: value,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 60,
        child: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Color(0XFF6927FF),
            onPressed: () {},
            label: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  // margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0XFF8752FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.format_list_numbered_rtl_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      TextWidget(title: " List", color: Colors.white)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapCategoryScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      // color: Color(0XFF8752FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        TextWidget(title: " Map", color: Colors.white)
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Widget _NearWidget(
    {required String cat,
    required String title,
    required List<GetEventsModel> eventmodel,
    required EventProvider value,
    dynamic color}) {
  return SizedBox(
    height: height,
    child: value.checkValueEvent == false
        ? Image.asset("assets/img/loading.gif")
        : eventmodel.length == 0
            ? TextWidget(title: "No Event Available")
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: eventmodel.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: EventDetailsScreen(
                          model: eventmodel[index],
                        ),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/img/1.png",
                                      height: height * 0.2,
                                      width: width,
                                      fit: BoxFit.fill)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin: EdgeInsets.only(top: 10, left: 10),
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
                            title: eventmodel[0].eventTitle,
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
                                title: eventmodel[0].eventStartDate,
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                              ),
                              Spacer(),
                              TextWidget(
                                title: "\$ " + eventmodel[0].price,
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
                }),
  );
}

Widget _NearWidget2({
  required String cat,
  required String title,
  required List<GetEventsModel> eventmodel,
  required EventProvider value,
  dynamic color,
}) {
  List<GetEventsModel> filteredEvents =
      eventmodel.where((event) => cat == event.categoryname).toList();

  return SizedBox(
    height: height,
    child: value.checkValueEvent == false
        ? Image.asset("assets/img/loading.gif")
        : filteredEvents.length == 0
            ? TextWidget(title: "No Event Available")
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: filteredEvents.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: EventDetailsScreen(
                          model: filteredEvents[index],
                        ),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/img/1.png",
                                  height: height * 0.2,
                                  width: width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin: EdgeInsets.only(top: 10, left: 10),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextWidget(
                                  title: "$title",
                                  fontWeight: FontWeight.w700,
                                  size: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextWidget(
                            title: filteredEvents[index].eventTitle,
                            size: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 15,
                                color: greyColor,
                              ),
                              TextWidget(
                                title: filteredEvents[index].eventStartDate,
                                size: 12,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                              ),
                              Spacer(),
                              TextWidget(
                                title: "\$ ${filteredEvents[index].price}",
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
