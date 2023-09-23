import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/services/helpers/jobs_helpers.dart';
import 'package:job/views/common/custom_field.dart';
import 'package:job/views/common/loader.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/ui/jobs/widgets/job_tile.dart';

import '../../common/app_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kOrange.value),
          iconTheme: IconThemeData(color: Color(kLight.value)),
          title: CustomField(
            controller: search,
            hintText: "Seach for a job",
            onEditingComplete: () {
              setState(() {});
            },
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: const Icon(AntDesign.search1),
            ),
          ),
          elevation: 0,
        ),
        body: search.text.isNotEmpty
            ? Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
                child: FutureBuilder(
                    future: JobsHelper.searchJobs(search.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error ${snapshot.error}");
                      } else if (snapshot.data!.isEmpty) {
                        return const SearchLoading(text: "Job not found");
                      } else {
                        final jobs = snapshot.data;
                        return ListView.builder(
                            itemCount: jobs!.length,
                            itemBuilder: ((context, index) {
                              final job = jobs[index];
                              return VerticalTileWidget(jobs: job);
                            }));
                      }
                    }),
              )
            : const SearchLoading(
                text: 'Start Searching for jobs',
              ));
  }
}
