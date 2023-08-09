// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../Models/UserFavoriteOrganizer.dart';
import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';
import '../DetailOrganizer/DetaillOrganizerdetail.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List<UserFavoriteOrganizer> followingorganizers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getRequests(context));
  }

  getRequests(BuildContext context) async {
    String id = Provider.of<AuthProvider>(context, listen: false)
        .loginModel[0]
        .data!
        .id
        .toString();
    await Provider.of<EventProvider>(context, listen: false)
        .getFollowingOrganzers(id);
    followingorganizers =
        Provider.of<EventProvider>(context, listen: false).followingorganizers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: TextWidget(title: "Following", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizeWidget(height: 30),
              textfieldProduct(
                context: context,
                name: "Search",
                prefixIcon: Icon(Icons.search),
                onChanged: (value) {
                  followingorganizers =
                      Provider.of<EventProvider>(context, listen: false)
                          .followingorganizers
                          .where((element) => element.organizerName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                  setState(() {});
                },
                controller: _searchController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  TextWidget(title: "Sort by Default", size: 16),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer2<EventProvider, AuthProvider>(
                  builder: (context, eventvalue, authvalue, child) {
                if (followingorganizers.isEmpty) {
                  return TextWidget(
                    title: "No organizer found.",
                    size: 16,
                    color: Colors.red,
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: eventvalue.followingorganizers.length,
                      itemBuilder: (context, index) {
                        final organizer = followingorganizers[index];
                        return OrganizerWidget(organizer);
                      });
                }
                ;
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganizerWidget extends StatefulWidget {
  final UserFavoriteOrganizer model;

  OrganizerWidget(this.model);

  @override
  _OrganizerWidgetState createState() => _OrganizerWidgetState();
}

class _OrganizerWidgetState extends State<OrganizerWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventProvider, AuthProvider>(
      builder: (context, eventValue, authValue, child) => Container(
        margin: EdgeInsets.only(bottom: 10),
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: lightGreyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: TextWidget(
            title: widget.model.organizerName!,
            size: 14,
            fontWeight: FontWeight.w500,
          ),
          subtitle: TextWidget(
            title: "10.5K Followers",
            size: 12,
            color: greyColor.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          leading: GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: DetailOrganizerScreen(
                  organizername: widget.model.organizerName,
                  model: widget.model,
                  organizerid: widget.model.id.toString(),
                ),
                withNavBar: false,
              );
            },
            child: Image.asset(
              "assets/img/f1.png",
            ),
          ),
          trailing: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: lightGreyColor,
            onPressed: () async {
              if (_isFavorite) {
                eventValue.followorganizer(
                    context,
                    authValue.loginModel[0].data!.id.toString(),
                    widget.model.id.toString());
              } else {
                eventValue.unfolloworganizer(
                    context,
                    authValue.loginModel[0].data!.id.toString(),
                    widget.model.id.toString());
              }
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            child: TextWidget(
              title: _isFavorite ? "Follow" : "Unfollow",
              size: 12,
              fontWeight: FontWeight.w700,
              color: appColor,
            ),
          ),
        ),
      ),
    );
  }
}
