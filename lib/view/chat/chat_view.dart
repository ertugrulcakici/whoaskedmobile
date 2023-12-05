import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whoaskedmobile/product/model/chat_box_model.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';
import 'package:whoaskedmobile/view/chat/chat_viewmodel.dart';
import 'package:whoaskedmobile/view/chat/message_widget.dart';
import 'package:whoaskedmobile/view/chat_settings/chat_settings_view.dart';

import '../../core/services/auth_service.dart';
import '../../product/model/message_model.dart';

part 'sender_input.dart';

class ChatView extends ConsumerStatefulWidget {
  final ChatBoxModel chatBoxModel;
  const ChatView({super.key, required this.chatBoxModel});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  late final ChangeNotifierProvider<ChatViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider(
        (ref) => ChatViewModel(chatBoxModel: widget.chatBoxModel));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatBoxModel.queueName),
        actions: [
          if (widget.chatBoxModel.ownerUsername ==
              AuthService.instance.user!.userName)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatSettingsView(
                              chatBoxModel: widget.chatBoxModel)));
                },
                icon: const Icon(Icons.settings))
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _messageList(),
        _SenderInput(context: context, onSend: ref.read(provider).sendMessage)
      ],
    );
  }

  Expanded _messageList() {
    if (ref.watch(provider).messages.length == 1 &&
        ref.watch(provider).messages[0].sender == 0) {
      return Expanded(
        child: Center(
          child: Text(ref.watch(provider).messages[0].mess),
        ),
      );
    }

    return Expanded(
      child: Consumer(
        builder: (context, watch, child) {
          final messages = ref.watch(provider).messages;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final MessageModel? nextMessage =
                  index + 1 < messages.length ? messages[index + 1] : null;
              final MessageModel? previousMessage =
                  index - 1 >= 0 ? messages[index - 1] : null;
              final senderIndex = widget.chatBoxModel.users
                  .indexWhere((element) => element.userId == message.sender);
              late final UserModel sender;
              if (senderIndex == -1) {
                sender = UserModel.deleted();
              } else {
                sender = widget.chatBoxModel.users
                    .firstWhere((element) => element.userId == message.sender);
              }

              return MessageWidget(
                  messageModel: message,
                  sender: sender,
                  nextMessage: nextMessage,
                  previousMessage: previousMessage);
            },
          );
        },
      ),
    );
  }
}
