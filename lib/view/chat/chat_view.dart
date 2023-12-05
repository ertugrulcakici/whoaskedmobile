import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whoaskedmobile/product/model/chat_box_model.dart';
import 'package:whoaskedmobile/view/chat/chat_viewmodel.dart';

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
    provider =
        ChangeNotifierProvider((ref) => ChatViewModel(widget.chatBoxModel));
    ref.read(provider).init(widget.chatBoxModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatBoxModel.queueName)),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, watch, child) {
              final messages = ref.watch(provider).messages;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index].mess),
                  );
                },
              );
            },
          ),
        ),
        _input(),
      ],
    );
  }

  Widget _input() {
    return Container(
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Message",
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
