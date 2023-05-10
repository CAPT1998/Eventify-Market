import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import '../../Widgets/TextWidget.dart';

class FavoriteEmptyScreen extends StatefulWidget {
  const FavoriteEmptyScreen({super.key});

  @override
  State<FavoriteEmptyScreen> createState() => _FavoriteEmptyScreenState();
}

class _FavoriteEmptyScreenState extends State<FavoriteEmptyScreen> {
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
        title: TextWidget(title: "Favorites", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            
            Image.asset(
              "assets/img/favourite.png",
              width: width * 0.7,
            ),
            SizedBox(
              height: 30,
            ),
            TextWidget(title: "No Favorites Yet", size: 24),
            SizedBox(
              height: 10,
            ),
            TextWidget(
                title:
                    "Etiam cras nec metus laoreet. Faucibus iaculis cras ut posuere.",
                size: 14,
                maxline: 2,
                fontWeight: FontWeight.w400,
                color: greyColor.withOpacity(0.5)),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              color: appColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              minWidth: width,
              height: 60,
              onPressed: () {
               },
              child: TextWidget(
                title: "Exeplore Event",
                size: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
