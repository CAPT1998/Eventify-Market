import 'dart:convert';

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
  late GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  void _showSupportChatInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Support Chat Info"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Timing: Monday to Friday, 9 AM to 5 PM"),
              Text("Availability: Online"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          title: const Text(
            "Support Chat",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.info,
              color: appColor,
            ),
            onPressed: () {
              _showSupportChatInfo(context);
            },
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Consumer2<AuthProvider, ChatProvider>(
          builder: (context, value, chatProvider, child) {
            return FutureBuilder<List<dynamic>>(
                future:
                    chatProvider.getChatData(value.loginModel[0].data!.id, "2"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Color(0XFF24ABE3),
                      size: 70.0,
                    ));
                  }
                  if (snapshot.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 48.0),
                      child: Center(child: Text("No chat")),
                    );
                  }

                  if (snapshot.data != null) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          //reverse: true, // Scroll to the bottom
                          controller: _scrollController, // Add controller
                          itemCount: snapshot.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctx, index) {
                            var item = snapshot.data![index];
                            // var item2 = snapshot.data![0];
                            List<int> encodedBytes =
                                base64Url.decode(item['message']);
                            String encodedText = utf8.decode(encodedBytes);
                            String decodedText =
                                encodedText.replaceAll('@@@', '');

                            var adminid = item['receiver_id'];
                            print(snapshot.data.toString());

                            return adminid == "2"
                                ? _LeftWidget(
                                    title: decodedText,
                                  )
                                : _RightWidget(
                                    title: decodedText,
                                  );
                          },
                        ),
                      ),
                    );
                  }
                  return const Center(
                      child: SpinKitCircle(
                    color: Color(0XFF24ABE3),
                    size: 70.0,
                  ));
                });
          },
        ),
      ),
      bottomSheet: Consumer2<AuthProvider, ChatProvider>(
          builder: (context, value, chatProvider, child) {
        return ChatInputField(
            message: message,
            press: () async {
              String encodedText = message.text.replaceAllMapped(
                RegExp(
                  r'([\u{1F910}-\u{1F918}\u{1F980}-\u{1F984}\u{1F9C0}])',
                  unicode: true,
                ),
                (Match match) => '@@@${match.group(0)}',
              );
              List<int> encodedBytes = utf8.encode(encodedText);
              String encodedMessage = base64UrlEncode(encodedBytes);
              await chatProvider.sentSMS(
                  context, value.loginModel[0].data!.id, "2", encodedMessage);
              setState(() {
                _refreshKey = GlobalKey<RefreshIndicatorState>();
              });
              message.clear();
            });
      }),
    );
  }
}

// ignore: non_constant_identifier_names
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
      const SizedBox(
        height: 50,
      ),
      const SizedBox(
        width: 10,
      ),
      const CircleAvatar(
        backgroundImage: AssetImage("assets/img/slider1.jpg"),
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
