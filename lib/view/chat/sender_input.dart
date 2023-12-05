part of 'chat_view.dart';

class _SenderInput extends StatelessWidget {
  final Future<bool> Function(String) onSend;
  _SenderInput({required this.context, required this.onSend});

  final BuildContext context;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.black,
              decoration: const InputDecoration(hintText: "Message"),
              controller: _controller,
              onSubmitted: _sendMessage,
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  _sendMessage([String? value]) async {
    if (_controller.text.isNotEmpty) {
      if (await onSend(_controller.text)) {
        _controller.clear();
      }
    }
  }
}
