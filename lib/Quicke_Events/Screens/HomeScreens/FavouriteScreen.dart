import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/Quicke_Events/Screens/HomeScreens/FavouriteEmptyScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../Models/GetFavoriteEvents.dart';
import '../../Providers/EventsProvider.dart';
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
                                                  .favoriteevents[index]);
                                        }),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //    _NearWidget(context,
                                    //        img: "4",
                                    //        title: "Flash Deal",
                                    //       color: yellowColor),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //  _NearWidget(context,
                                    //       img: "2",
                                    //       title: "Flash Deal",
                                    //        color: yellowColor),
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
    required Getfavoriteevents model}) {
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
              screen: FavouriteEventDetailsScreen(
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
