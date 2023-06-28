import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../Constant.dart';

class MapTrackingScreen extends StatefulWidget {
  MapTrackingScreen({Key? key}) : super(key: key);

  @override
  State<MapTrackingScreen> createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  bool showContainer = false; // Define the showContainer variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
          ),
          if (showContainer)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: height * 0.34,
                child: SingleChildScrollView(
                  child: VerticalStepper(
                    dashLength: 5,
                    steps: [
                      Step(
                        title: "Order Placed",
                        isExpanded: true,
                        content: "We have received your order",
                        iconStyle: Colors.green,
                        onExpansion: (istrue) {},
                        shimmer: false,
                      ),
                      Step(
                        title: "Confirmed",
                        isExpanded: false,
                        content: "Your order has been confirmed",
                        iconStyle: Colors.green,
                        onExpansion: (istrue) {},
                        shimmer: false,
                      ),
                      Step(
                        title: "Order Shipped",
                        isExpanded: false,
                        content: "Your Package off for delivery",
                        iconStyle: Colors.green,
                        onExpansion: (istrue) {},
                        shimmer: false,
                      ),
                      Step(
                        title: "Out for Delivery",
                        isExpanded: false,
                        content: "Estimated for 13 Feb, 2024",
                        iconStyle: Colors.white,
                        onExpansion: (istrue) {},
                        shimmer: false,
                      ),
                      Step(
                        title: "Delivered",
                        isExpanded: false,
                        content: "Estimated for 13 Feb, 2024",
                        iconStyle: Colors.white,
                        onExpansion: (istrue) {},
                        shimmer: false,
                      ),
                    ],
                    iconColor: Colors.green,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VerticalStepper extends StatefulWidget {
  List<Step> steps;
  double dashLength;
  Color iconColor;
  VerticalStepper(
      {required this.steps, required this.dashLength, required this.iconColor});

  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              height: 1000,
              top: 23,
              left: 27,
              child: DottedLine(
                dashLength: 5,
                direction: Axis.vertical,
                lineLength: double.infinity,
                dashColor: Colors.black,
              ),
            ),
            Column(
              children: [
                for (int i = 0; i < widget.steps.length - 1; i++)
                  Container(
                    child: widget.steps[i],
                  )
              ],
            )
          ],
        ),
        Stack(
          children: [
            Positioned(
              top: 10,
              left: 27,
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: 140,
                dashColor: Colors.black,
                dashLength: this.widget.dashLength,
              ),
            ),
            Container(
              child: widget.steps.last,
            )
          ],
        )
      ],
    );
  }
}

class Step extends StatefulWidget {
  final String title;
  final String content;
  final Color iconStyle;
  final bool shimmer;
  final bool isExpanded;
  final Function(bool) onExpansion;

  const Step({
    required this.title,
    required this.content,
    required this.iconStyle,
    this.shimmer = false,
    this.isExpanded = false,
    required this.onExpansion,
  });

  @override
  _StepState createState() => _StepState();
}

class _StepState extends State<Step> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListTile(
        // initiallyExpanded: widget.isExpanded,
        // onExpansionChanged: widget.onExpansion,
        // initiallyExpanded: false,
        // expandedCrossAxisAlignment: CrossAxisAlignment.start,
        subtitle: Text(widget.content),
        trailing: Text(
          "12 Feb 2024\n\n10:30 AM",
          style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
        ),
        leading: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                child: Stack(children: [
                  Icon(
                    Icons.circle,
                    // color: Colors.grey,
                    color: widget.iconStyle != null
                        ? widget.iconStyle
                        : Colors.white,
                  ),
                ]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 1.5),
                        blurRadius: 0.5)
                  ],
                ),
              ),
            ),
          ],
        ),
        title: Text(widget.title),
      ),
    );
  }
}
