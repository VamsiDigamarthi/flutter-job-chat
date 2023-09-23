import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/models/request/chat/create_chat.dart';
import 'package:job/models/request/messaging/send_message.dart';
import 'package:job/services/helpers/chat_helpers.dart';
import 'package:job/services/helpers/messaging_helper.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/custom_outline_btn.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/ui/auth/profile.dart';
import 'package:job/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;

  final String id;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobNotifire>(builder: (context, jobNotifier, child) {
      jobNotifier.getJob(widget.id);
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
                text: widget.title,
                actions: [
                  Consumer<BookMarNotifier>(
                      builder: (context, bookMarkNotifier, child) {
                    return GestureDetector(
                      onTap: () {
                        // BookMarkReqRes model = BookMarkReqRes(id: id)
                        // bookMarkNotifier.addBookmark(model, jobId);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Entypo.bookmark),
                      ),
                    );
                  })
                ],
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(CupertinoIcons.arrow_left),
                )),
          ),
          body: FutureBuilder(
              future: jobNotifier.job,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final job = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const HeightSpacer(size: 30),
                            Container(
                              width: width,
                              height: hieght * 0.27,
                              color: Color(kLightGrey.value),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(job!.imageUrl),
                                  ),
                                  const HeightSpacer(size: 10),
                                  ReusableText(
                                      text: job.title,
                                      style: appstyle(22, Color(kDark.value),
                                          FontWeight.w600)),
                                  const HeightSpacer(size: 5),
                                  ReusableText(
                                      text: job.location,
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.normal)),
                                  const HeightSpacer(size: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomOulineBtn(
                                          width: width * 0.26,
                                          height: hieght * 0.04,
                                          color1: Color(kLight.value),
                                          text: job.contract,
                                          color: Color(kOrange.value),
                                        ),
                                        Row(
                                          children: [
                                            ReusableText(
                                                text: job.salary,
                                                style: appstyle(
                                                    22,
                                                    Color(kDark.value),
                                                    FontWeight.w600)),
                                            SizedBox(
                                                width: width * 0.2,
                                                child: ReusableText(
                                                    text: job.period,
                                                    style: appstyle(
                                                        22,
                                                        Color(kDark.value),
                                                        FontWeight.w600))),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const HeightSpacer(size: 20),
                            ReusableText(
                                text: "Job description",
                                style: appstyle(
                                    22, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 20),
                            Text(
                              desc,
                              textAlign: TextAlign.justify,
                              maxLines: 8,
                              style: appstyle(16, Color(kDarkGrey.value),
                                  FontWeight.normal),
                            ),
                            const HeightSpacer(size: 20),
                            ReusableText(
                                text: "Requirements",
                                style: appstyle(
                                    22, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            SizedBox(
                              height: hieght * 0.6,
                              child: ListView.builder(
                                  itemCount: job.requirements.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final req = job.requirements[index];
                                    return Text(
                                      "$req\n",
                                      maxLines: 4,
                                      textAlign: TextAlign.justify,
                                      style: appstyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.normal),
                                    );
                                  }),
                            ),
                            const HeightSpacer(size: 20)
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: CustomOulineBtn(
                              onTap: () {
                                print("create");
                                CreateChat model =
                                    CreateChat(userId: job.agentId);
                                ChatHelper.apply(model).then((response) {
                                  if (response[0]) {
                                    SendMessage model = SendMessage(
                                        content: "hellow",
                                        chatId: response[1],
                                        receiver: job.agentId);
                                    MessagingHelper.sendMessage(model)
                                        .whenComplete(() {
                                      Get.to(() => const MainScreen());
                                    });
                                  }
                                });
                              },
                              color1: Color(kLight.value),
                              text: "Apply now",
                              color: Color(kOrange.value),
                              width: width,
                              height: hieght * 0.06,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })));
    });
  }
}
