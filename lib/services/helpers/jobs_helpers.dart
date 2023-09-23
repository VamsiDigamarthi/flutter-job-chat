import 'package:http/http.dart' as https;
import 'package:job/models/response/jobs/get_job.dart';
import 'package:job/models/response/jobs/jobs_response.dart';
import 'package:job/services/config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get jobs");
    }
  }

  static Future<JobsResponse> getRecentJobs() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.jobs);
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var jobsList = jobsResponseFromJson(response.body);
        var recent = jobsList.first;
        return recent;
      } else {
        throw Exception("Failed to get the recent jobs");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  static Future<GetJobRes> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, "${Config.job}/$jobId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      return job;
    } else {
      throw Exception("Failed to get job");
    }
  }

  // SEARCH

  static Future<List<JobsResponse>> searchJobs(String searchQuery) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var url = Uri.https(Config.apiUrl, "${Config.search}/$searchQuery");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception("Failed to get jobs");
    }
  }
}
