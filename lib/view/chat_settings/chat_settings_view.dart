import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

import '../../product/model/chat_box_model.dart';
import 'chat_settings_viewmodel.dart';

class ChatSettingsView extends ConsumerStatefulWidget {
  final ChatBoxModel chatBoxModel;
  const ChatSettingsView({super.key, required this.chatBoxModel});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatSettingsViewState();
}

class _ChatSettingsViewState extends ConsumerState<ChatSettingsView> {
  late final ChangeNotifierProvider<ChatSettingsViewModel> provider;
  @override
  void initState() {
    provider = ChangeNotifierProvider(
        (ref) => ChatSettingsViewModel(widget.chatBoxModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _showAddDialog, child: const Icon(Icons.add)),
      appBar:
          AppBar(title: Text("Chat Settings ${widget.chatBoxModel.queueName}")),
      body: ListView.builder(
        itemCount: ref.watch(provider).chatBoxModel.users.length,
        itemBuilder: (context, index) {
          final user = ref.watch(provider).chatBoxModel.users[index];

          return ListTile(
              leading: CircleAvatar(
                child: Text(
                  user.userName[0].toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              title: Text(user.userName),
              trailing: widget.chatBoxModel.ownerUsername == user.userName
                  ? null
                  : IconButton(
                      onPressed: () {
                        _showDeleteDialog(user);
                      },
                      icon: const Icon(Icons.delete),
                    ));
        },
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return _AddUserDialog();
        }).then((value) {
      if (value != null) {
        ref.read(provider).addUser(value as String);
      }
    });
  }

  void _showDeleteDialog(UserModel userModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete user"),
            content:
                Text("Are you sure you want to delete ${userModel.userName}?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(provider).deleteUser(userModel);
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }
}

class _AddUserDialog extends StatelessWidget {
  _AddUserDialog();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add user"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, _controller.text);
            },
            child: const Text("Add")),
      ],
      content: TextFormField(
        decoration: const InputDecoration(hintText: "Username"),
        controller: _controller,
      ),
    );
  }
}
