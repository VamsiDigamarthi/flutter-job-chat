import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/models/response/bookmarks/book_res.dart';
import 'package:job/services/helpers/book_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarNotifier extends ChangeNotifier {
  List<String> _jobs = [];

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addjob(String jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jobs.isEmpty) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList("jobId");
    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookmark(BookMarkReqRes model, String jobId) {
    BookHelper.addBookmarks(model).then((response) => {
          if (response[0])
            {
              addjob(jobId),
              Get.snackbar(
                  "Bookmark successfully added", "Please check your book marks",
                  colorText: Color(kLight.value),
                  backgroundColor: Color(kLightBlue.value),
                  icon: const Icon(Icons.bookmark_add))
            }
          else if (!response[0])
            {
              Get.snackbar(
                  "Bookmark  added failed", "Sorry we con't added bookmark",
                  colorText: Color(kLight.value),
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.bookmark_add))
            }
        });
  }
}
