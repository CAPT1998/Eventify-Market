import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/MapCategoryScreen.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Icon(Icons.close)
                ],
              ),
              SizedBox(height: 20),
              TextWidget(
                title: "Recent and popular searches",
                size: 16,
                fontWeight: FontWeight.w600,
                color: greyColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 20,
              ),
              _SearchWidget(title: "Business Networking"),
              SizedBox(height: 20),
              TextWidget(
                title: "Event in Business",
                size: 16,
                fontWeight: FontWeight.w600,
                color: greyColor.withOpacity(0.5),
              ),
              SizedBox(
                height: 20,
              ),
              _NearWidget(img: "1", title: "Flash Deal", color: yellowColor),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _SearchWidget({required String title}) {
  return Row(
    children: [
      Icon(
        Icons.trending_up,
        color: appColor,
      ),
      TextWidget(
        title: "  $title",
        size: 14,
        fontWeight: FontWeight.w600,
      ),
    ],
  );
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
