import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/drawer/drawer_widget.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/horizonal_shimmer.dart';
import 'package:job/views/common/search.dart';
import 'package:job/views/common/vertical_shimmer.dart';
import 'package:job/views/common/vertical_tile.dart';
import 'package:job/views/ui/jobhorizontalTile/job_horizontal_tile.dart';
import 'package:job/views/ui/jobs/job_page.dart';
import 'package:job/views/ui/jobs/jobs_list.dart';
import 'package:job/views/ui/search/seacrh_page.dart';
import 'package:provider/provider.dart';

import '../common/heading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: const DrawerWidget(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                ),
              )
            ],
          ),
        ),
        body: Consumer<JobNotifire>(
          builder: (context, jobNotifire, child) {
            jobNotifire.getJobs();
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    Text(
                      "Seacrh \n Find & Apply",
                      style: appstyle(40, Color(kDark.value), FontWeight.bold),
                    ),
                    const HeightSpacer(size: 40),
                    SearchWidget(
                      onTap: () {
                        Get.to(() => const SearchPage());
                      },
                    ),
                    const HeightSpacer(size: 30),
                    HeadingWidget(
                      onTap: () {
                        Get.to(() => const JobListPage());
                      },
                      text: "Popular Jobs",
                    ),
                    SizedBox(
                      height: hieght * 0.28,
                      child: FutureBuilder(
                          future: jobNotifire.jobList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HorizontalShimmer();
                            } else if (snapshot.hasError) {
                              return Text("error ${snapshot.error}");
                            } else {
                              final jobs = snapshot.data;
                              return ListView.builder(
                                  itemCount: jobs!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final job = jobs[index];
                                    return JobHorizontalTile(
                                      onTap: () {
                                        Get.to(() => JobPage(
                                            title: job.company, id: job.id));
                                      },
                                      job: job,
                                    );
                                  });
                            }
                          }),
                    ),
                    const HeightSpacer(size: 15),
                    HeadingWidget(
                      onTap: () {},
                      text: "Recently posted",
                    ),
                    const HeightSpacer(size: 15),
                    FutureBuilder(
                        future: jobNotifire.recentJob,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: VerticalShimmer(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          } else {
                            final job = snapshot.data;
                            return VerticalTile(
                              onTap: () {
                                Get.to(() =>
                                    JobPage(title: job!.company, id: job.id));
                              },
                              job: job,
                            );
                          }
                        }),
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
