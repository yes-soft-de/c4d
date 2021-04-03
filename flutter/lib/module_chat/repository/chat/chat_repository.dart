import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:c4d/module_chat/model/chat/chat_model.dart';

@provide
class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ApiClient _apiClient;
  final AuthService _authService;
  ChatRepository(this._apiClient, this._authService);
  Stream<QuerySnapshot> requestMessages(String chatRoomID) {
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('sentDate', descending: false)
        .snapshots(includeMetadataChanges: false);
  }

  void sendMessage(String chatRoomID, ChatModel chatMessage) {
    _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(chatMessage.toJson());
  }

  Future<void> sendNotification(String chatRoomID) async {
    var token = await _authService.getToken();
    var result = await _apiClient.post(
      Urls.NOTIFICATIONNEWCHAT_API,
      {'roomID': chatRoomID},
      headers: {'Authorization': 'Bearer ' + token},
    );
  }
}
