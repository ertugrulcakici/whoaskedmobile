import 'package:flutter/material.dart';
import 'package:whoaskedmobile/view/chat/chat_view.dart';

import '../../product/model/chat_box_model.dart';

class ChatBoxWidget extends StatelessWidget {
  final ChatBoxModel chatBoxModel;
  const ChatBoxWidget({super.key, required this.chatBoxModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: chatBoxModel.seen ? Colors.white : Colors.grey[300],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(chatBoxModel: chatBoxModel)));
      },
      leading: CircleAvatar(
        child: Text(
          chatBoxModel.queueName[0].toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      title: Text(chatBoxModel.queueName),
      subtitle: Text(chatBoxModel.latestMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: chatBoxModel.seen
              ? null
              : const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
