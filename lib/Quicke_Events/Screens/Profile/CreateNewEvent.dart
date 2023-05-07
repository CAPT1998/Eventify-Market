import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

class CreateNewEvents extends StatefulWidget {
  const CreateNewEvents({super.key});

  @override
  State<CreateNewEvents> createState() => _CreateNewEventsState();
}

class _CreateNewEventsState extends State<CreateNewEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextWidget(
          title: "Create Private Event",
          size: 14,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: greyColor,
            )),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_outlined,
                color: greyColor,
              ))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
