import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_chat/manager/chat/chat_manager.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';

@provide
class ChatService {
  final ChatManager _chatManager;
  final AuthService _authService;
  ChatService(this._chatManager,this._authService);

  // This is Real Time, That is Why I went this way
  final PublishSubject<List<ChatModel>> _chatPublishSubject =
      new PublishSubject();

  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  void requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.docs.forEach((element) {
        chatMessagesList.add(new ChatModel.fromJson(element.data()));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  void sendMessage(
      String chatRoomID, String msg, bool support, feedBack) async {
    ChatModel model = new ChatModel(
      msg: msg,
      sender: await _authService.username,
      sentDate: DateTime.now().toString(),
    );
    _chatManager.sendMessage(chatRoomID, model);
    _chatManager.sendNotification(chatRoomID, support, feedBack);
  }

  void dispose() {
    _chatPublishSubject.close();
  }
}
