import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job/models/request/messaging/send_message.dart';
import 'package:job/models/response/messaging/messaging_res.dart';
import 'package:job/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, Config.messageUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      ReceivedMessage message =
          ReceivedMessage.fromJson(jsonDecode(response.body));
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessage>> getMessage(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, "${Config.messageUrl}/$chatId",
        {"page": offset.toString()});
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var messages = receivedMessageFromJson(response.body);
      return messages;
    } else {
      throw Exception("failed to load message");
    }
  }
}
