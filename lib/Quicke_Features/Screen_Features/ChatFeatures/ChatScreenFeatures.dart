import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../../ConstantProviders/ChatProvider.dart';
import 'Widgets/ChatInputField.dart';

class ChatScreenFeatures extends StatefulWidget {
  const ChatScreenFeatures({Key? key}) : super(key: key);

  @override
  State<ChatScreenFeatures> createState() => _ChatScreenFeaturesState();
}

class _ChatScreenFeaturesState extends State<ChatScreenFeatures> {
  TextEditingController message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: app_bar(title: "Chat"),
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/img/slider1.jpg"),
          ),
          title: Text(
            "Support Chat",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.info,
            color: appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer2<AuthProvider, ChatProvider>(
          builder: (context, value, value2, child) {
            value2.getChatData(value.loginModel!.data.id.toString(), "2");
            return StreamBuilder<List<dynamic>>(
              stream: value2.chatMessagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitPumpingHeart(
                      color: Color(0XFF24ABE3),
                      size: 70.0,
                    ),
                  );
                }
                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: Center(child: Text("No chat")),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        var item = snapshot.data![index];

                        return value.loginModel!.data.id.toString() ==
                                item["id"].toString()
                            ? _LeftWidget(
                                title: item["message"],
                              )
                            : _RightWidget(
                                title: item["message"],
                              );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomSheet: ChatInputField(message: message, press: () {}),
    );
  }
}

Widget _RightWidget({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // width: width * 0.6,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.check_circle_outline_rounded,
        size: 20,
        color: appColor,
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget _LeftWidget({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 10,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/img/slider1.jpg"),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // width: width * 0.6,
        decoration: BoxDecoration(
          color: Color(0XFFB8BCBF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
