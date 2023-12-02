import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/model/chat_box_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhoAsked"),
      ),
      body: _chatList(),
    );
  }

  Widget _chatList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 0,
        itemBuilder: (context, index) {
          return Container();
        });
  }
}

class ChatBoxWidget extends StatelessWidget {
  final ChatBoxModel chatBoxModel;
  const ChatBoxWidget({super.key, required this.chatBoxModel});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
