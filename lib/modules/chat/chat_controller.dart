import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/messsage_request.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import '../../data/models/message.dart';
import '../../routers/app_routes.dart';

class ChatController extends GetxController {
  RxList<File> mediaPicker = RxList<File>();
  late StreamSubscription<List<Message>> streamSubscription;
  final StreamController<List<Message>> _controller = StreamController();

  Stream<List<Message>> get stream => _controller.stream;
  late Conversation conversation;
  TextEditingController textEditingController = TextEditingController();
  final StreamController<bool> _allowSendingMessageController =
      StreamController();

  Stream<bool> get isAllowSendMessage => _allowSendingMessageController.stream;
  final ChatRepository _chatRepository = GetIt.instance<ChatRepository>();

  @override
  void onClose() {
    _chatRepository.markMessagesRead(conversation.id);
    streamSubscription.cancel();
    _allowSendingMessageController.close();
    _controller.close();
    super.onClose();
  }

  Future<void> pickMedias() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result != null) {
      mediaPicker.addAll(result.files.map((e) => File(e.path!)).toList());
    }
  }

  Future<void> takeAPhoto() async {
    final imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      mediaPicker.add(File(xFile.path));
    }
  }

  void removeMedia(File file) {
    mediaPicker.remove(file);
  }

  Future<void> initializeMessages(dynamic arg) async {
    if (arg is Conversation) {
      conversation = arg;
    } else if (arg is UserInfo) {
      try {
        conversation = await _chatRepository.getOrCreateConversation(arg.uid);
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception("Invalid arg. Arg is UserInfo or Conversation");
    }
    _chatRepository.markMessagesRead(conversation.id);
    streamSubscription =
        _chatRepository.getMessages(conversation).listen((event) {
      _controller.sink.add(event);
    });
  }

  Future<void> sendMessage() async {
    final trimmedText = textEditingController.text.trim();
    if (trimmedText.isNotEmpty || mediaPicker.isNotEmpty) {
      try {
        _allowSendingMessageController.sink.add(false);
        textEditingController.clear();
        final files = List<File>.from(mediaPicker);
        mediaPicker.clear();
        await _chatRepository.sendMessage(MessageRequest(
          conservationId: conversation.id,
          content: trimmedText,
          images: files.isEmpty ? null : files,
        ));
      } catch (e) {
        e.printError();
        Get.snackbar(
          "Lỗi",
          "Đã xảy ra lỗi khi gửi tin nhắn. Vui lòng thử lại",
        );
      } finally {
        _allowSendingMessageController.sink.add(true);
      }
    }
  }

  Future<void> sendLocation() async {
    final data = await Get.toNamed(AppRoutes.map_picker_screen);
    if (data != null) {
      LatLng latLng = data;
      final request =
          MessageRequest(conservationId: conversation.id, location: latLng);
      await _chatRepository.sendMessage(request);
    } else {
      log("None data from map_view_screen: $data");
    }
  }
}
