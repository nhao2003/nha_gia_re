import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/message.dart';

class ChatController extends GetxController {
  final repo = ChatRepository();
  final supabase = Supabase.instance.client;
  final Map<String, StreamSubscription<Message?>> _messageSubscriptions = {};
  late final String _myUserId;
  late final List<UserInfo> _newUsers;
  List<Conversation> _conversations = [];
  late final Stream rawRoomsSubscription;
  bool _haveCalledGetRooms = false;
  final Stream stream = Supabase.instance.client
      .from('conversations')
      .stream(primaryKey: ['id'])
      .eq('user1_id', '8c222079-d67e-4ca6-b18c-639ed3128181')
      .map((event) => event.map((e) {
            print(e.toString());
            return Conversation.fromJson(e);
          }));

  void initializeRooms() {
    if (_haveCalledGetRooms) {
      return;
    }
    _haveCalledGetRooms = true;

    _myUserId = supabase.auth.currentUser!.id;
    final List<String> listUserID = [];

    /// Get realtime updates on rooms that the user is in
    rawRoomsSubscription = supabase.from('conversations').stream(
      primaryKey: ['conversation_id'],
    ).map((conversation) {
      if (conversation.isEmpty) {
        return;
      }
      print(conversation);
      _conversations = conversation.map((json) {
        return Conversation.fromJson(json);
      }).toList();
    });
  }

  // Setup listeners to listen to the most recent message in each room
  void _getNewestMessage({
    required BuildContext context,
    required String roomId,
  }) {
    _messageSubscriptions[roomId] = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at')
        .limit(1)
        .map<Message?>(
          (data) => data.isEmpty ? null : Message.fromJson(data.first),
        )
        .listen((message) {
          // final index = _rooms.indexWhere((room) => room.id == roomId);
          // _rooms[index] = _rooms[index].copyWith(lastMessage: message);
          // _rooms.sort((a, b) {
          //   /// Sort according to the last message
          //   /// Use the room createdAt when last message is not available
          //   final aTimeStamp =
          //   a.lastMessage != null ? a.lastMessage!.createdAt : a.createdAt;
          //   final bTimeStamp =
          //   b.lastMessage != null ? b.lastMessage!.createdAt : b.createdAt;
          //   return bTimeStamp.compareTo(aTimeStamp);
          // });
          // if (!isClosed) {
          //   emit(RoomsLoaded(
          //     newUsers: _newUsers,
          //     rooms: _rooms,
          //   ));
          // }
        });
  }

  /// Creates or returns an existing roomID of both participants
  Future<String> createRoom(String otherUserId) async {
    final data = await supabase
        .rpc('create_new_room', params: {'other_user_id': otherUserId});
    //emit(RoomsLoaded(rooms: _rooms, newUsers: _newUsers));
    return data as String;
  }

  Future<void> close() async {}
}
