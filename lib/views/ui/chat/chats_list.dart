import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/chat_provider.dart';
import 'package:job/models/response/chat/get_chat.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/drawer/drawer_widget.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/loader.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/ui/chat/chat_page.dart';
import 'package:provider/provider.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Chat",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(builder: (context, chatNotifire, child) {
        chatNotifire.getChats();
        chatNotifire.getPrefs();
        return FutureBuilder<List<GetChats>>(
            future: chatNotifire.chats,
            builder: (context, snapshort) {
              if (snapshort.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshort.hasError) {
                return Text("error ${snapshort.error}");
              } else if (snapshort.data!.isEmpty) {
                return const SearchLoading(text: "no chats availabel");
              } else {
                final chats = snapshort.data;
                return ListView.builder(
                    padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                    itemCount: chats!.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final user = chat.users
                          .where((user) => user.id != chatNotifire.userId);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ChatPage(
                                  id: chat.id,
                                  profile: user.first.profile,
                                  title: user.first.username,
                                  user: [chat.users[0].id, chat.users[1].id],
                                ));
                          },
                          child: Container(
                            height: 80,
                            width: width,
                            color: Color(kOrange.value),
                            decoration: BoxDecoration(
                              color: Color(kLightGrey.value),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                minLeadingWidth: 0,
                                minVerticalPadding: 0,
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(user.first.profile),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: user.first.username,
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 5),
                                    ReusableText(
                                        text: chat.latestMessages.content,
                                        style: appstyle(
                                            16,
                                            Color(kDarkGrey.value),
                                            FontWeight.normal)),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(right: 4.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                          text: chatNotifire.msgTime(
                                              chat.updatedAt.toString()),
                                          style: appstyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.normal)),
                                      Icon(chat.chatName == chatNotifire.userId
                                          ? Ionicons
                                              .arrow_forward_circle_outline
                                          : Ionicons.arrow_back_circle_outline)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    });
              }
            });
      }),
    );
  }
}
