import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whoaskedmobile/product/constants/app_constants.dart';
import 'package:whoaskedmobile/view/chat/chat_view.dart';
import 'package:whoaskedmobile/view/home/home_viewmodel.dart';

import '../../product/model/chat_box_model.dart';
import 'chat_box_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  AutoDisposeChangeNotifierProvider<HomeViewModel> provider =
      ChangeNotifierProvider.autoDispose((ref) => HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/profile");
        },
        child: const Icon(Icons.person),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatView(
                                chatBoxModel: ref
                                    .watch(provider)
                                    .chatBoxes
                                    .firstWhere((element) =>
                                        element.queueId ==
                                        AppConstants.globalChatId))));
                  },
                  child: const Icon(Icons.public)),
            ),
            const Expanded(child: Icon(Icons.chat))
          ],
        ),
      ),
      body: _chatList(),
    );
  }

  Widget _chatList() {
    List<ChatBoxModel> chatBoxesWithoutGlobalChat = ref
        .watch(provider)
        .chatBoxes
        .where((element) => element.queueId != AppConstants.globalChatId)
        .toList();

    if (chatBoxesWithoutGlobalChat.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: chatBoxesWithoutGlobalChat.length,
        itemBuilder: (context, index) {
          ChatBoxModel chatBoxModel = chatBoxesWithoutGlobalChat[index];
          return ChatBoxWidget(chatBoxModel: chatBoxModel);
        });
  }
}
