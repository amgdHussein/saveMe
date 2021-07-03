import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  MessageForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _controller = TextEditingController();

  String _message;

  void _onPressed() {
    widget.onSubmit(_message);
    _message = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
              minLines: 1,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          SizedBox(width: 5),
          RawMaterialButton(
            onPressed: _message == null || _message.isEmpty ? null : _onPressed,
            fillColor: _message == null || _message.isEmpty
                ? Colors.blueGrey
                : Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'SEND',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}