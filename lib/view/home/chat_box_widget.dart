import 'package:flutter/material.dart';
import 'package:whoaskedmobile/view/chat/chat_view.dart';

import '../../product/model/chat_box_model.dart';

class ChatBoxWidget extends StatelessWidget {
  final ChatBoxModel chatBoxModel;
  const ChatBoxWidget({super.key, required this.chatBoxModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(chatBoxModel: chatBoxModel)));
      },
      leading: const CircleAvatar(
        child: Text("A"),
      ),
      title: Text(chatBoxModel.queueName),
      subtitle: Text(chatBoxModel.latestMessage),
      trailing: Text(chatBoxModel.seen ? "Seen" : "Not seen"),
    );
  }
}
