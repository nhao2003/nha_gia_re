import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/modules/chat/widgets/message_row.dart';

import '../../../core/theme/text_styles.dart';

class User {
  final String _id;
  final String _userName;

  String get userName => _userName;

  User(this._id, this._userName);
}

class Message {
  String senderID;
  String receiverID;
  DateTime time;
  String content;

  Message(this.senderID, this.receiverID, this.time, this.content);
}

List<Message> messages = [
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 0), "Hi there!"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 1), "Hello!"),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 2), "How are you today?"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 3),
      "I'm doing pretty well, thanks for asking."),
  Message(
      "user1", "user2", DateTime(2022, 1, 1, 12, 4), "That's great to hear!"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 5),
      "How about you? How are you doing?"),
  Message(
      "user1", "user2", DateTime(2022, 1, 1, 12, 6), "I'm doing okay, thanks."),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 7),
      "Just okay? Anything new going on in your life?"),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 8),
      "Not really, just the same old stuff."),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 9),
      "Well, sometimes that's not such a bad thing."),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 10),
      "Yeah, I suppose you're right."),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 11),
      "So, what are your plans for the weekend?"),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 12),
      "I don't have anything specific planned yet. What about you?"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 13),
      "I might go see a movie or something. Want to join me?"),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 14),
      "Sure, that sounds like fun!"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 15),
      "Great! I'll send you the details later."),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 16), "Sounds good!"),
  Message("user2", "user1", DateTime(2022, 1, 1, 12, 17),
      "By the way, have you heard about the new restaurant that just opened up downtown?"),
  Message("user1", "user2", DateTime(2022, 1, 1, 12, 18),
      "No, I haven't. What kind of food do they serve?")
].reversed.toList();

class OnChattingScreen extends StatefulWidget {
  const OnChattingScreen({Key? key}) : super(key: key);

  @override
  State<OnChattingScreen> createState() => _OnChattingScreenState();
}

class _OnChattingScreenState extends State<OnChattingScreen> {
  User user = User("123", "Hào Nguyễn");
  FocusNode focusNode = FocusNode();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Chat Screen"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
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
              decoration:  InputDecoration(
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
      ),
    );
  }
}
