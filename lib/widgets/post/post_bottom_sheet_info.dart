import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/models/firestore_user.dart';
import 'package:save_me/modules/save_me/screens/profile/cubit/profile_cubit.dart';
import 'package:save_me/modules/save_me/screens/profile/profile.dart';
import '../../modules/save_me/models/post.dart';

void displayPostInfo({
  @required BuildContext context,
  @required dynamic post,
  @required FirestoreUser owner,
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
                        GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: Colors.redAccent,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
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
                    if (FirebaseAuth.instance.currentUser.uid != owner.uid)
                      ListTile(
                        title: Text('Post Owner'),
                        subtitle: Text(owner.name),
                        trailing: Icon(FontAwesomeIcons.idBadge),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => ProfileCubit(),
                                child: ProfileScreen(user: owner),
                              ),
                            ),
                          );
                        },
                      ),
                    ListTile(
                      title: Text('Upload date'),
                      subtitle:
                          Text(DEFAULT_DATE_FORMAT.format(post.uploadDate)),
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
                        "${post.location.governorate}, ${post.location.city}",
                      ),
                    ),
                    if (post is Missing)
                      ListTile(
                        title: Text('When it happens?'),
                        subtitle:
                            Text(DEFAULT_DATE_FORMAT.format(post.missingFrom)),
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
