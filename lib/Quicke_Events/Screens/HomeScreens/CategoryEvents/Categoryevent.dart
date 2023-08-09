import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../Constant.dart';
import '../../../Models/GetEventsModel.dart';
import '../../../Widgets/TextWidget.dart';
import '../../EventDetails/EventDetailsScreen.dart';

class CategoryEvent extends StatefulWidget {
  final String title;
  const CategoryEvent({required this.title, super.key});

  @override
  State<CategoryEvent> createState() => _CategoryEventScreenState();
}

class _CategoryEventScreenState extends State<CategoryEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<EventProvider>(builder: (context, eventvalue, child) {
            List<GetEventsModel> filteredEvents = eventvalue.getEventsModel
                .where((event) => widget.title == event.categoryname)
                .toList();
            print("Filtered Events Length: ${filteredEvents.length}");

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return InkWell(
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${filteredEvents[index].eventsPic}",
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, url, error) =>
                                      Image.asset(
                                    "assets/img/placeholder.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin: EdgeInsets.only(top: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: FittedBox(
                                  child: TextWidget(
                                    title: "Today",
                                    fontWeight: FontWeight.w700,
                                    size: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: TextWidget(
                              title: "${filteredEvents[index].eventTitle}",
                              size: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 15,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: FittedBox(
                                  child: TextWidget(
                                    title:
                                        "  ${filteredEvents[index].eventStartDate.toString().split(" ")[0]} - ${filteredEvents[index].eventStartTime}",
                                    size: 12,
                                    fontWeight: FontWeight.w500,
                                    color: greyColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                flex: 3,
                                child: FittedBox(
                                  child: TextWidget(
                                    title: "\$ ${filteredEvents[index].price}",
                                    size: 12,
                                    fontWeight: FontWeight.w500,
                                    color: darkPurpleColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
