import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/CategoriesFeatures/CategoriesFeatureWidget.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Constant.dart';
import '../../Widgets/TextWidget.dart';
import '../DetailOrganizer/DetaillOrganizerdetail.dart';
import '../EventDetails/EventDetailsScreen.dart';

class EventsOrganizersScreen extends StatefulWidget {
  const EventsOrganizersScreen({super.key});

  @override
  State<EventsOrganizersScreen> createState() => _EventsOrganizersScreenState();
}

class _EventsOrganizersScreenState extends State<EventsOrganizersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Event Organizers",
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
          child: Consumer<EventProvider>(builder: (context, person, child) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: person.getEventsModel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DetailOrganizerScreen(
                        organizername: person.getEventsModel[index]
                            .eventOrganizer?.organizerName!,
                        model: person.getEventsModel,
                        organizerid: person
                            .getEventsModel[index].eventOrganizer?.id
                            .toString(),
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 40),
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
                        TextWidget(
                            title: person.getEventsModel[index].eventOrganizer
                                    ?.organizerName ??
                                "Example Event")
                      ],
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
