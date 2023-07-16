import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Constant.dart';

class ChatProvider with ChangeNotifier {
  String? returnMessage;
  var chatdata = [];
  StreamController<List<dynamic>> _chatMessagesController = StreamController<List<dynamic>>();
  Stream<List<dynamic>> get chatMessagesStream => _chatMessagesController.stream;
void updateChatMessages(List<dynamic> messages) {
    _chatMessagesController.add(messages);
  }

   Future<void> getChat(dynamic token, dynamic senderId, dynamic adminId) async {
    // Fetch the chat data using your existing logic
    List<dynamic> chatData = await getChatData( senderId, adminId);

    // Update the chat messages stream with the fetched data
    updateChatMessages(chatData);
  }

  // Helper method to fetch chat data
 

  // Update the chatMessagesStream with the new messages

  sentSMS(context,  userId, reciverId, text) async {
    print('====>$userId====>$reciverId====>$text');
                String token = "PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA"; // Assuming the token is stored in `apiToken` property of `LoginModel`

    try {
      
      var url = Uri.parse('http://quickeeapi.pakwexpo.com/api/chats');
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'sender_id': userId.toString(),
        'receiver_id': reciverId.toString(),
        'message': text.toString(),
      });
      final Map<String, dynamic> data = json.decode(response.body);
      print('data====>${data['message']}');
    } catch (e) {
      print("error=====>$e");
      ErrorFlushbar(context, "Block User", e.toString());
    }
  }

  var userData = {};
 
/*
  sendVoiceMessage(context, token, userId, reciverId, path) async {
    print('====>$userId====>$reciverId====>$path====>$token');

    final uri = Uri.parse(path);
    print(
      userId.toString(),
    );
    print(
      reciverId.toString(),
    );
    print(uri.path);
    File file = File(uri.path);
    try {
      File file = File(path);
      var request = http.MultipartRequest(
          'POST', Uri.parse('${AppUrl.baseUrl}/chat/create/audio'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['user_id'] = userId.toString();
      request.fields['other_user_id'] = reciverId.toString();
      request.files.add(await http.MultipartFile.fromPath('audio', file.path));
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = json.decode(responseBody);
      // print('data====>${data['message']}');
      print(data);
    } catch (e) {
      print("error=====>$e");
      ErrorFlushbar(context, "Block User", e.toString());
    }
  }
*/
  Future getChatData(
        senderId,

    adminId,
  ) async {
            String token = "PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA"; // Assuming the token is stored in `apiToken` property of `LoginModel`

    var url = Uri.parse('http://quickeeapi.pakwexpo.com/api/chats/$senderId/$adminId');
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
    }, );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print("=====>$parsed");
      return parsed['data'];
    } else {
      throw Exception('Something went wrong!');
    }
  }


}
