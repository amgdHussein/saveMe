import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_me/modules/save_me/models/post.dart';

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
    isDismissible: false,
    isScrollControlled: true,
    // backgroundColor: Theme.of(context).primaryColor,
    builder: (builder) {
      return SizedBox(
        height: 450,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 15,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Positioned(
              top: 51,
              left: 0,
              right: 0,
              height: 1,
              child: Divider(height: 0),
            ),
            Positioned(
              top: 51,
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
