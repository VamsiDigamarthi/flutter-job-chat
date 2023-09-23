import 'package:flutter/material.dart';
import 'package:job/models/response/jobs/get_job.dart';
import 'package:job/models/response/jobs/jobs_response.dart';
import 'package:job/services/helpers/jobs_helpers.dart';

class JobNotifire extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recentJob;
  late Future<GetJobRes> job;

  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getRecentJobs() {
    recentJob = JobsHelper.getRecentJobs();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }
}
