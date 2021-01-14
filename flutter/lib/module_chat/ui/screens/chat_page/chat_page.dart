import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';
import 'package:c4d/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:c4d/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  ChatPage(
    this._chatPageBloc,
    this._authService,
    this._uploadService,
  );

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  List<ChatBubbleWidget> chatsMessagesWidgets = [];
  
  String chatRoomId;

  bool initiated = false;

  @override
  Widget build(BuildContext context) {
    chatRoomId = ModalRoute.of(context).settings.arguments;

    if (currentState == ChatPageBloc.STATUS_CODE_INIT) {
      widget._chatPageBloc.getMessages(chatRoomId);
    }

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            if (this.mounted) setState(() {});
          });
        }
      }
    });

    return Scaffold(
      body: Column(
        // direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppBar(
            title: Text(S.of(context).chatRoom),
          ),
          Expanded(
            child: chatsMessagesWidgets != null
                ? ListView(
                    children: chatsMessagesWidgets,
                    reverse: false,
                  )
                : Center(
                    child: Text(S.of(context).loading),
                  ),
          ),
          ChatWriterWidget(
            onMessageSend: (msg) {
              widget._chatPageBloc.sendMessage(chatRoomId, msg);
            },
            uploadService: widget._uploadService,
          ),
        ],
      ),
    );
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    FirebaseAuth auth = await FirebaseAuth.instance;
    User user = auth.currentUser;
    chatList.forEach((element) {
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == user.uid ? true : false,
        sentDate: element.sentDate,
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }
}
