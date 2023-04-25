import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/modules/chat/widgets/message_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/text_styles.dart';

class OnChattingScreen extends StatefulWidget {
  Conversation conversation;
  OnChattingScreen(this.conversation, {Key? key}) : super(key: key);

  @override
  State<OnChattingScreen> createState() => _OnChattingScreenState();
}

class _OnChattingScreenState extends State<OnChattingScreen> {
  FocusNode focusNode = FocusNode();
  ScrollController controller = ScrollController();
  late final Stream stream;
  @override
  void initState() {
    stream = Supabase.instance.client
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('sent_at')
        .eq('conversation_id', widget.conversation.id)
        .map((event) => event.map((e) => Message.fromJson(e)).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Chat Screen"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Message> messages = snapshot.data;
              return Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: AnimatedList(
                        reverse: true,
                        initialItemCount: messages.length,
                        itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) {
                          return MessageRow(
                            messages[index],
                            isError: (index == 10 ? true : false),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: AppTextStyles.roboto16regular,
                      maxLines: null,
                      //focusNode: focusNode,
                      onTap: () {},
                      onTapOutside: (e) {
                        focusNode.unfocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Type a message",
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.send),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
