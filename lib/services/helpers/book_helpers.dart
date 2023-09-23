import 'dart:convert';

import 'package:http/http.dart' as https;

import 'package:job/models/response/bookmarks/book_res.dart';
import 'package:job/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookHelper {
  static var client = https.Client();

// GET BOOK MARKS
  static Future<List<dynamic>> addBookmarks(BookMarkReqRes model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toString()));

    if (response.statusCode == 200) {
      String bookmarkId = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }
}
