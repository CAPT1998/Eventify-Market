import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../Constant.dart';
import 'MapTrackingScreen.dart';

class TrackingScreen extends StatefulWidget {
  TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Track Order",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0XFF2473F2).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/img/slider2.jpg",
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: Text(
                      "Order Number #856568\nNike React Miler Shoes\n1 Item - \$160.00",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF828588)),
                    ),
                  ),
                ],
              ),
            ),
            VerticalStepper(
              dashLength: 5,
              steps: [
                Step(
                  title: "Oreder Placed",
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
                  content: "Your Package off for delivery ",
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
              ],
              iconColor: Colors.green,
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
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: CustomLargeButton(
          text: 'CHECK ON MAP',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapTrackingScreen()));
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VerticalStepper extends StatefulWidget {
  List<Step> steps;
  double dashLength;
  Color iconColor;
  VerticalStepper({required this.steps,required this.dashLength,required this.iconColor});

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



class CustomLargeButton extends StatelessWidget {
  final Function onPressed;
  final double separation;
  final String text;
  const CustomLargeButton({
    Key? key,
    required this.onPressed,
    this.separation = 10,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: separation),
      height: 60,
      width: width,
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, 12),
        //     blurRadius: 25,
        //     color: kprimaryShadow,
        //   ),
        // ],
      ),
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}