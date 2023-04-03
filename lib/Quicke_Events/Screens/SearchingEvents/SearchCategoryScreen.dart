import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/MapCategoryScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/SearchScreen.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

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
                          text: "Musics",
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
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: SizedBox(
                        child: TabBarView(
                          // controller: _tabController,
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  _NearWidget(
                                      img: "1",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "2",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "3",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  _NearWidget(
                                      img: "4",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "5",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "1",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  _NearWidget(
                                      img: "2",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "11",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                  _NearWidget(
                                      img: "4",
                                      title: "Flash Deal",
                                      color: yellowColor),
                                ],
                              ),
                            ),
                            Text("data"),
                            Text("data"),
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
    {required String img, required String title, dynamic color}) {
  return Container(
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
