import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../modules/save_me/models/post.dart';

void displayPostInfo({
  @required BuildContext context,
  @required dynamic post,
  @required String ownerName,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    isScrollControlled: true,
    builder: (builder) {
      return SizedBox(
        height: 450,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: 55,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          children: [
                            // Icon(
                            //   Icons.reply,
                            // ),
                            // Icon(
                            //   Icons.edit,
                            // ),
                            GestureDetector(
                              child: Icon(
                                Icons.close,
                                color: Colors.redAccent,
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Post Owner'),
                      subtitle: Text(ownerName),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Upload date'),
                      subtitle: Text(
                        DateFormat('dd MMM, yyyy').format(post.uploadDate),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(height: 0),
                    ),
                    ListTile(
                      title: Text('Person Name'),
                      subtitle: Text(post.name),
                    ),
                    ListTile(
                      title: Text('Age'),
                      subtitle: Text(post.age.toString()),
                    ),
                    ListTile(
                      title: Text('Gender'),
                      subtitle: Text(post.sex),
                    ),
                    ListTile(
                      title: Text('Description'),
                      subtitle: Text(post.description),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                        width: 200,
                        child: Divider(height: 0),
                      ),
                    ),
                    ListTile(
                      title: Text('Where it happens?'),
                      subtitle: Text(
                        "${post.location.city}, ${post.location.governorate}",
                      ),
                    ),
                    if (post is Missing)
                      ListTile(
                        title: Text('When it happens?'),
                        subtitle: Text(
                          DateFormat('dd MMM, yyyy').format(post.missingFrom),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
