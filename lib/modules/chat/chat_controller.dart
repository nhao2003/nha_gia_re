import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/messsage_request.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/message.dart';

class ChatController extends GetxController {
  final repo = ChatRepository();
  final supabase = Supabase.instance.client;
  Rx<List<File>> mediaPicker = Rx<List<File>>([]);
  late StreamSubscription<List<Message>> streamSubscription;
  final StreamController<List<Message>> _controller = StreamController();
  Stream<List<Message>> get stream => _controller.stream;
  late Conversation conversation;
  TextEditingController textEditingController = TextEditingController();
  final StreamController<bool> _allowSendingMessageController =
  StreamController();

  Stream<bool> get isAllowSendMessage => _allowSendingMessageController.stream;
  final ChatRepository _chatRepository = ChatRepository();

  @override
  void onClose() {
    streamSubscription.cancel();
    _allowSendingMessageController.close();
    _controller.close();
    super.onClose();
  }
  Future<void> pickMedias()async {
    mediaPicker.value.clear();
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if(result != null){
      mediaPicker.value.addAll(result.files.map((e) => File(e.path!)).toList());
    }
  }
  Future<void> takeAPhoto()async {
    final imagePicker = ImagePicker();
    XFile? xFile =  await imagePicker.pickImage(
        source: ImageSource.camera);
    if(xFile!=null){
      mediaPicker.value.add(File(xFile.path));
    }
  }
  void removeMedia(File file){
    mediaPicker.value.remove(file);
  }
  Future<void> initializeMessages(dynamic arg) async {
    if (arg is Conversation) {
      conversation = arg;
    } else if (arg is UserInfo) {
      try {
        conversation = await repo.getOrCreateConversation(arg.uid);
        print('Goto chat by userInfo');
      } catch (e) {
        print(e.toString());
        rethrow;
      }
    } else {
      throw Exception("Invalid arg. Arg is UserInfo or Conversation");
    }
    streamSubscription =
        _chatRepository.getMessages(conversation.id).listen((event) {
          _controller.sink.add(event);
        });
  }

  Future<void> sendMessage() async {
    final trimmedText = textEditingController.text.trim();
    if (trimmedText.isNotEmpty || mediaPicker.value.isEmpty) {
      try {
        _allowSendingMessageController.sink.add(false);
        textEditingController.clear();
        await _chatRepository.sendMessage(MessageRequest(
          conservationId: conversation.id,
          content: trimmedText,
          images: mediaPicker.value.isEmpty ? null: mediaPicker.value,
        ));
      } catch (e) {
        print(e.toString());
        Get.snackbar(
          "Lỗi",
          "Đã xảy ra lỗi khi gửi tin nhắn. Vui lòng thử lại",
        );
      } finally {
        _allowSendingMessageController.sink.add(true);
      }
    }
  }
}
