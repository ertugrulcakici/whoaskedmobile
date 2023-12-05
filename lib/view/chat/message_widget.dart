import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whoaskedmobile/core/services/auth_service.dart';
import 'package:whoaskedmobile/product/model/message_model.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageModel;
  final MessageModel? nextMessage;
  final MessageModel? previousMessage;
  final UserModel sender;
  // final Animation animation;
  const MessageWidget(
      {super.key,
      required this.messageModel,
      required this.sender,
      this.previousMessage,
      this.nextMessage});

  @override
  Widget build(BuildContext context) {
    return _card(context);
  }

  Widget _card(BuildContext context) {
    if (sender.userId == -1) // deleted user
    {
      return ListTile(
        leading: CircleAvatar(
          child: Text(
            sender.userName[0].toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        title: Text(messageModel.mess),
        subtitle: Row(
          children: [
            Text(messageModel.hourString),
            const SizedBox(width: 10),
            Text(sender.userName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey)),
          ],
        ),
      );
    } else {
      return _userMessage(context);
    }
  }

  Widget _userMessage(BuildContext context) {
    bool isLast = (previousMessage == null) ||
        (previousMessage!.sender != messageModel.sender);
    bool isSenderLoggedUser =
        AuthService.instance.user!.userId == sender.userId;

    List<Widget> widgets = [
      _messageBox(
          context: context,
          messageModel: messageModel,
          sender: sender,
          isLast: isLast,
          isSenderLoggedUser: isSenderLoggedUser),
      SizedBox(
          width: (1 / 9).sw,
          child: _customAvatarFromText(sender.userName, isLast: isLast))
    ];
    return SizedBox(
      width: 1.sw,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isSenderLoggedUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: !isSenderLoggedUser ? widgets.reversed.toList() : widgets,
      ),
    );
  }
}

ConstrainedBox _messageBox(
    {required BuildContext context,
    required MessageModel messageModel,
    required UserModel sender,
    required bool isLast,
    required bool isSenderLoggedUser}) {
  return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: (8 / 9).sw),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSenderLoggedUser ? Colors.blue : Colors.grey[500],
            borderRadius: isLast
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(messageModel.mess),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // username
                Text(sender.userName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                const SizedBox(width: 10),
                Text(messageModel.hourString),
              ],
            ),
          ],
        ),
      ));
}

Widget _customAvatarFromText(String text, {required bool isLast}) {
  if (isLast) {
    return CircleAvatar(
      child: Text(
        text[0].toUpperCase(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  } else {
    return const SizedBox();
  }
}
