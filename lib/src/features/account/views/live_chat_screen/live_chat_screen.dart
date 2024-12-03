import 'dart:async';

import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/material.dart';

import '../../../../common/views/widgets/appBar.dart';

class live_chatHelp_screen extends StatefulWidget {
  @override
  State<live_chatHelp_screen> createState() => _live_chatHelp_screenState();
}

class _live_chatHelp_screenState extends State<live_chatHelp_screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Live Support',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.0),
        child: chat_screen_2()
      ),
    );
  }
}

class ChatModel {
  String message, from, timestamp, seenType;

  static const String myId = "myId";
  static const String otherId = "otherId";

  ChatModel(this.message, this.from, this.timestamp, this.seenType);
}

class chat_screen_2 extends StatefulWidget {
  static const String path = "lib/d/screens/miscellaneous/chat_screen_2.dart";

  @override
  _ShoppingChatScreenState createState() => _ShoppingChatScreenState();
}

class _ShoppingChatScreenState extends State<chat_screen_2> {
  TextEditingController? _chatTextController;

  final List<ChatModel> _chatList = [];

  ScrollController? _scrollController;

  final List<Timer> _timers = [];

  @override
  initState() {
    super.initState();
    _chatTextController = TextEditingController();
    _scrollController = ScrollController();
    _chatList.add(
        ChatModel("How can i help you", ChatModel.otherId, DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
  }

  @override
  dispose() {
    super.dispose();
    _scrollController!.dispose();
    for (Timer timer in _timers) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        // color: Colors.yellowAccent,
        padding: EdgeInsets.symmetric(horizontal:  screenHeight*0.015),
        child: Column(


          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView.builder(

                controller: _scrollController,
                padding: EdgeInsets.all(0),
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    margin: index == 0
                        ? EdgeInsets.only(top: 12, bottom: 8).add(_chatList[index].from.compareTo(ChatModel.myId) == 0
                            ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2)
                            : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2))
                        : EdgeInsets.only(top: 3, bottom: 8).add(_chatList[index].from.compareTo(ChatModel.myId) == 0
                            ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2)
                            : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2)),
                    alignment: _chatList[index].from.compareTo(ChatModel.myId) == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: singleChat(index),
                  );
                },
              ),
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      maxLines: 6,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        isDense: true,
                        hintStyle:  TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w400),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color:  AppColors.primary_orange_color),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color:  AppColors.primary_orange_color),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color:  AppColors.primary_orange_color),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color:  AppColors.primary_orange_color),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      controller: _chatTextController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ClipOval(
                  child: Material(
                    color: AppColors.primary_orange_color,
                    child: InkWell(
                      splashColor: Colors.white,
                      child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            child: const Icon(
                              Icons.send_outlined,
                              size: 22,
                              color: Colors.white,
                            ),
                          )),
                      onTap: () {
                        sendMessage(_chatTextController!.text);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget singleChat(int index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: _chatList[index].from.compareTo(ChatModel.myId) == 0 ? Colors.white : AppColors.primary_orange_color,
          borderRadius: makeChatBubble(index),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      _chatList[index].message,
                      style: TextStyle(
                        overflow: TextOverflow.fade,
                        color: _chatList[index].from.compareTo(ChatModel.myId) == 0 ? AppColors.dark_text_color : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),
                    )),
              ),
            ],
          ),
        ));
  }

  BorderRadius makeChatBubble(int index) {
    if (_chatList[index].from.compareTo(ChatModel.myId) == 0) {
      // if (index != 0) {
      //   if (_chatList[index - 1].from.compareTo(ChatModel.myId) == 0) {
      //     return BorderRadius.all(Radius.circular(8));
      //   } else {
      //     return BorderRadius.only(
      //         topLeft: Radius.circular(12),
      //         bottomRight: Radius.circular(12),
      //         bottomLeft: Radius.circular(12),
      //         topRight: Radius.circular(0));
      //   }
      // } else {
      //   return BorderRadius.only(
      //       topLeft: Radius.circular(18),
      //       bottomRight: Radius.circular(18),
      //       bottomLeft: Radius.circular(18),
      //       topRight: Radius.circular(0));
      // }
      return BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          topRight: Radius.circular(0));
    } else {
      // if (index != 0) {
      //   if (_chatList[index - 1].from.compareTo(ChatModel.myId) != 0) {
      //     return BorderRadius.all(Radius.circular(8));
      //   } else {
      //     return BorderRadius.only(
      //         topLeft: Radius.circular(0),
      //         bottomRight: Radius.circular(8),
      //         bottomLeft: Radius.circular(8),
      //         topRight: Radius.circular(8));
      //   }
      // } else {
      //   return BorderRadius.only(
      //       topLeft: Radius.circular(0),
      //       bottomRight: Radius.circular(8),
      //       bottomLeft: Radius.circular(8),
      //       topRight: Radius.circular(8));
      // }
      return BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          topRight: Radius.circular(18));
    }
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _chatTextController!.clear();
        _chatList.add(ChatModel(message, ChatModel.myId, DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
        startTimer(_chatList.length - 1, message);
      });
      scrollToBottom(isDelayed: true);
    }
  }

  void startTimer(int index, String message) {
    const oneSec = Duration(seconds: 1);
    const twoSec = Duration(seconds: 2);
    Timer timerSeen = Timer.periodic(oneSec, (Timer timer) {
      timer.cancel();
      setState(() {
        _chatList[index].seenType = "seen";
      });
    });
    _timers.add(timerSeen);
    Timer timer = Timer.periodic(twoSec, (Timer timer) {
      timer.cancel();
      sentFromOther(message);
    });
    _timers.add(timer);
  }

  void sentFromOther(String message) {
    setState(() {
      _chatList.add(ChatModel(message, ChatModel.otherId, DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
      scrollToBottom(isDelayed: true);
    });
  }

  scrollToBottom({bool isDelayed = false}) {
    final int delay = isDelayed ? 400 : 0;
    Future.delayed(Duration(milliseconds: delay), () {
      _scrollController!.animateTo(_scrollController!.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

//
// Widget quickActionWidget(IconData iconData, String actionText) {
//   return Container(
//     margin: EdgeInsets.y(8),
//     child: Column(
//       children: <Widget>[
//         ClipOval(
//           child: Material(
//             color: customChatTheme.btnColor, // button color
//             child: InkWell(
//               splashColor: Colors.white,
//               // inkwell color
//               child: SizedBox(
//                   width: 52,
//                   height: 52,
//                   child: Icon(
//                     iconData,
//                     color: customChatTheme.iconOnBtn,
//                     size: 24,
//                   )),
//               onTap: () {},
//             ),
//           ),
//         ),
//         EdgeInsets.height(4),
//         MyText.bodySmall(
//           actionText,
//           color: theme.colorScheme.onBackground,
//           fontWeight: 600,
//           letterSpacing: 0.3,
//         )
//       ],
//     ),
//   );
// }
//
// Widget suggestions() {
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       children: <Widget>[
//         InkWell(
//           onTap: () {
//             sendMessage("Go to favourites");
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 border: Border.all(
//                     color: AppColors.primary_orange_color, width: 0.3)),
//             padding: EdgeInsets.xy(12, 8),
//             child: MyText.bodyMedium("Go to favourites",
//                 color: customChatTheme.onBackground,
//                 fontWeight: 400,
//                 letterSpacing: 0.3),
//           ),
//         ),
//          SizedBox(width: 8,),
//         InkWell(
//           onTap: () {
//             sendMessage("Last order status");
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 border: Border.all(
//                     color: customChatTheme.onBackground, width: 0.3)),
//             padding: EdgeInsets.xy(12, 8),
//             child: MyText.bodyMedium("Last order status",
//                 color: customChatTheme.onBackground,
//                 fontWeight: 400,
//                 letterSpacing: 0.3),
//           ),
//         ),
//          SizedBox(width: 8,),
//         InkWell(
//           onTap: () {
//             sendMessage("Show my orders");
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 border: Border.all(
//                     color: customChatTheme.onBackground, width: 0.3)),
//             padding: EdgeInsets.xy(12, 8),
//             child: MyText.bodyMedium("Show my orders",
//                 color: customChatTheme.onBackground,
//                 fontWeight: 400,
//                 letterSpacing: 0.3),
//           ),
//         ),
//          SizedBox(width: 8,),
//         InkWell(
//           onTap: () {
//             sendMessage("Other services");
//           },
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(16)),
//                 border: Border.all(
//                     color: customChatTheme.onBackground, width: 0.3)),
//             padding: EdgeInsets.xy(12, 8),
//             child: MyText.bodyMedium("Other services",
//                 color: customChatTheme.onBackground,
//                 fontWeight: 400,
//                 letterSpacing: 0.3),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
