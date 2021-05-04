import 'package:flutter/material.dart';

class ChatMessege extends StatefulWidget {
  @override
  ChatMessegeState createState() => ChatMessegeState();
}

class ChatMessegeState extends State<ChatMessege> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/ppme.jpg'),
            ),
            SizedBox(
              width: 5,
            ),
            Text('mahmoud mohy'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => Text('chat text'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18 * 0.75),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    color: Color(0xFF087949).withOpacity(0.2)),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.mic,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.black,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "type message",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.attach_file,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
