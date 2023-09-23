import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/chat_provider.dart';
import 'package:job/models/request/messaging/send_message.dart';
import 'package:job/models/response/messaging/messaging_res.dart';
import 'package:job/services/helpers/messaging_helper.dart';
import 'package:job/views/common/app_bar.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/height_spacer.dart';
import 'package:job/views/common/loader.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/ui/chat/widgets/text_field.dart';
import 'package:job/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();

  int offset = 1;

  late Future<List<ReceivedMessage>> msgList;

  List<ReceivedMessage> messages = [];

  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getMessages(offset);
    connect();
    joinChat();
    handleNext();
    super.initState();
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<><>loadind new messages<><>");
          if (messages.length >= 12) {
            getMessages(offset++);
            setState(() {});
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(
        "https://jobhubrest-production-7c08.up.railway.app", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      print("connected to front end");
      socket!.on(
          'online-users',
          (userId) => {
                chatNotifier.online
                    .replaceRange(0, chatNotifier.online.length, [userId])
              });

      socket!.on("typing", (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on("stop typing", (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on("message received", (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessage receivedMessage =
            ReceivedMessage.fromJson(newMessageReceived);

        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
      });
    });
  }

  getMessages(int offset) {
    msgList = MessagingHelper.getMessage(widget.id, offset);
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      var emmision = response[2];
      socket!.emit('new message', emmision);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit("typing", status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit("stop typing", status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(builder: (context, chatNotifier, child) {
      receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: !chatNotifier.typing ? widget.title : "typing ...",
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.profile),
                    ),
                    const Positioned(
                        right: 3,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ))
                  ],
                ),
              )
            ],
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const MainScreen());
                },
                child: const Icon(MaterialCommunityIcons.arrow_left),
              ),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.h),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<ReceivedMessage>>(
                    future: msgList,
                    builder: (context, snapshort) {
                      if (snapshort.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshort.hasError) {
                        return Text("error ${snapshort.error}");
                      } else if (snapshort.data!.isEmpty) {
                        return const SearchLoading(
                            text: "you dont have messages");
                      } else {
                        final msgList = snapshort.data;
                        messages = messages + msgList!;
                        return ListView.builder(
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemCount: messages.length,
                            controller: _scrollController,
                            reverse: true,
                            itemBuilder: (context, index) {
                              final data = messages[index];

                              return Padding(
                                padding:
                                    EdgeInsets.only(top: 8.0, bottom: 12.h),
                                child: Column(
                                  children: [
                                    ReusableText(
                                        text: chatNotifier.msgTime(
                                            data.chat.updatedAt.toString()),
                                        style: appstyle(10, Color(kDark.value),
                                            FontWeight.normal)),
                                    const HeightSpacer(size: 15),
                                    ChatBubble(
                                      alignment:
                                          data.sender.id == chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      backGroundColor:
                                          data.sender.id == chatNotifier.userId
                                              ? Color(kOrange.value)
                                              : Color(kLightGrey.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                          radius: 8,
                                          type: data.sender.id ==
                                                  chatNotifier.userId
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: width * 0.8),
                                        child: ReusableText(
                                            text: data.content,
                                            style: appstyle(
                                                14,
                                                Color(kLight.value),
                                                FontWeight.normal)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    }),
              ),
              Container(
                padding: EdgeInsets.all(12.h),
                alignment: Alignment.bottomCenter,
                child: MessaginTextField(
                  messageController: messageController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      String msg = messageController.text;

                      sendMessage(msg, widget.id, receiver);
                    },
                    child: const Icon(
                      Icons.send,
                      size: 24,
                    ),
                  ),
                  onChange: (_) {
                    sendTypingEvent(widget.id);
                  },
                  onEditingComplete: () {
                    String msg = messageController.text;

                    sendMessage(msg, widget.id, receiver);
                  },
                  onSubmitted: (_) {
                    String msg = messageController.text;

                    sendMessage(msg, widget.id, receiver);
                  },
                  onTapOutside: (_) {
                    sendStopTypingEvent(widget.id);
                  },
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
