import 'package:flutter/material.dart';
import 'package:job/models/response/chat/get_chat.dart';
import 'package:job/services/helpers/chat_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;

  bool _typing = false;

  bool get typing => _typing;

  set typingStatus(bool newValue) {
    _typing = newValue;

    notifyListeners();
  }

  List<String> _online = [];

  List<String> get online => _online;

  set online(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;

  getChats() {
    chats = ChatHelper.getConversation();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
  }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamp);

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return 'Yesterday';
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}
