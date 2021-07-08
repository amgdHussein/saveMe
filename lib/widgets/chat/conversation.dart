import 'package:flutter/material.dart';
import '../../config/themes/chat_theme.dart';
import '../../constants/app_constants.dart';
import '../../modules/save_me/models/firestore_user.dart';
import '../../modules/save_me/models/message.dart';

class Conversation extends StatelessWidget {
  const Conversation({Key key, @required this.user, @required this.messages})
      : super(key: key);

  final FirestoreUser user;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, int index) {
        final message = messages[index];
        bool isMe = message.sid != user.uid;
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!isMe)
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 12 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 12),
                      ),
                    ),
                    child: Text(
                      messages[index].content,
                      style: ChatTheme.bodyTextMessage.copyWith(
                        color: isMe ? Colors.white : Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isMe) SizedBox(width: 40),
                    Text(
                      DEFAULT_DATE_FORMAT.format(message.date),
                      style: ChatTheme.bodyTextTime,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
