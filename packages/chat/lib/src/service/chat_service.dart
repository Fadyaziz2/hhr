import 'dart:convert';
import 'package:chat/src/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import '../models/user_model.dart';

class ChatService {
  ///create new user
  void createAndUpdateUserInfo(map, uid) {
    FirebaseFirestore.instance.collection('users').doc(uid).set(map);
  }
  ///getUser
  Future<UserModel> getUserData(String uid) async {
    final data = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return UserModel.fromJson(data.data() as Map<String, dynamic>);
  }
  ///updateToken
  Future<void> updateUserToken({String? uid, String? token}) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'token': token});
  }
  ///create chat room for every person whom we want to chat
  void createChatRoom(fromId, toId, chatMap) {
    FirebaseFirestore.instance
        .collection('users')
        .doc('$fromId')
        .collection('$toId')
        .add(chatMap);
  }
  ///create friend list
  void createFriend(currentUser, chatUser, message) {
    Map<String, dynamic> friendMap = {
      'uid': chatUser.toString(),
      'message': message,
      'timestamp': '${Timestamp.now().seconds}',
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc('$currentUser')
        .collection('friends')
        .doc('$chatUser')
        .set(friendMap)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }
  ///get all query friend from firebase
  Stream<List<Friend>> getFriend(currentUser) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('$currentUser')
        .collection('friends')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(getAllFriendFromFirebase);
  }
  ///get list of friend
  List<Friend> getAllFriendFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((item) {
      return Friend.fromJson(item.data() as Map<dynamic, dynamic>);
    }).toList();
  }
  ///get all query message from firebase
  Stream<List<Message>> getChatRoomMessage(fromId, toId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc("$fromId")
        .collection('$toId')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots()
        .map(getAllMessageFromFirebase);
  }
  ///get list of message
  List<Message> getAllMessageFromFirebase(QuerySnapshot snapshot) {
    return snapshot.docs.map((item) {
      return Message(
        from: item['from'] ?? '',
        message: item['message'] ?? '',
        timeStamp: item['timestamp'] ?? '',
        type: item['type'],
        status: item['status'],
      );
    }).toList();
  }

  Future<http.Response> sendNotification({token, title, body, map, status = 'call'}) async {
    final path = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final response = await http.post(
      path,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'YOUR_KEY_HERE',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'type': '$status',
            'user_data': map,
          },
          'to': token,
        },
      ),
    );
    print('notification ${response.body}');
    return response;
  }

  Future<http.Response> sendNotificationWithTopic({topic, title, body, map, status = 'call'}) async {
    final path = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final response = await http.post(
      path,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAAaHOqun0:APA91bGQzkW17oSI1wIzNjm69Xzxq_zFrBDYzXdFDGkla45q8T3tKGjZZoH1GNSPIojEYmjquplT17qCG2w2UoIxc9e5gmKMRrKSuVHE1eueZ6G00NH_4iHDr23GmdNvKwrPauc_U2KR',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'type': '$status',
            'user_data': map,
          },
          'to': '/topics/$topic',
        },
      ),
    );
    print('notification ${response.body}');
    return response;
  }
}
