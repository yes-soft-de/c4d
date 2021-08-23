import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';
import 'package:c4d/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:c4d/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final ImageUploadService _uploadService;
  final AuthService _authservice;

  ChatPage(this._chatPageBloc, this._uploadService, this._authservice);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  List<ChatBubbleWidget> chatsMessagesWidgets = [];

  String chatRoomId;

  bool initiated = false;
  bool support = false;
  bool feedBack = false;
  bool down = true;
  ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            if (this.mounted) {
              setState(() {
                down = true;
              });
            }
          });
        }
      }
    });
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset !=
            scrollController.position.maxScrollExtent) {
          down = true;
        } else {
          down = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == ChatPageBloc.STATUS_CODE_INIT) {
      chatRoomId = ModalRoute.of(context).settings.arguments;
      if (chatRoomId.substring(0, 2) == 'A#') {
        chatRoomId = chatRoomId.substring(2);
        support = true;
      }
      if (chatRoomId.substring(0, 2) == 'F#') {
        chatRoomId = chatRoomId.substring(2);
        feedBack = true;
      }
      if (chatRoomId.substring(0, 2) == 'O#') {
        chatRoomId = chatRoomId.substring(2);
        feedBack = true;
        support = true;
      }
      widget._chatPageBloc.getMessages(chatRoomId);
    }

    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          body: Stack(
        children: [
          Column(
            // direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBar(
                title: Text(
                  S.of(context).chatRoom,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: chatsMessagesWidgets != null
                    ? ListView(
                        controller: scrollController,
                        children: chatsMessagesWidgets,
                        reverse: false,
                      )
                    : ListView(
                        children: [
                          Center(
                            child: Text(S.of(context).loading),
                          )
                        ],
                      ),
              ),
              ChatWriterWidget(
                onMessageSend: (msg) {
                  widget._chatPageBloc
                      .sendMessage(chatRoomId, msg, support, feedBack);
                },
                uploadService: widget._uploadService,
              ),
            ],
          ),
          down
              ? Positioned(
                  bottom: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                        setState(() {
                          down = false;
                        });
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      )),
    );
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    String username = widget._authservice.username;
    chatList.forEach((element) {
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == username ? true : false,
        sentDate: element.sentDate,
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }
}
