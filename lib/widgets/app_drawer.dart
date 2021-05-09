import 'package:flutter/material.dart';

Widget appDrawer() {
  return Builder(
    builder: (context) {
      final Size pageSize = MediaQuery.of(context).size;
      return Drawer(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'profile'),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://static.remove.bg/remove-bg-web/2a274ebbb5879d870a69caae33d94388a88e0e35/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "UserName",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(
                      "${5} Posts",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            drawerListTile(
              icon: Icons.chat_bubble,
              text: "Chats",
              onTap: () => Navigator.pushNamed(context, 'chat'),
            ),
            drawerListTile(
              icon: Icons.settings_rounded,
              text: "Setting",
              onTap: () => Navigator.pushNamed(context, 'settings'),
            ),
            Divider(thickness: 2, height: 1),
            drawerListTile(
              icon: Icons.face_retouching_natural,
              text: "Tell a friend",
              onTap: () {},
            ),
            drawerListTile(
              icon: Icons.help,
              text: "saveMe Features",
              onTap: () {},
            ),
            drawerListTile(
              icon: Icons.exit_to_app_rounded,
              text: "Sign out",
              onTap: () {},
            ),
          ],
        ),
      );
    },
  );
}

Widget drawerListTile({
  @required IconData icon,
  @required String text,
  onTap,
}) =>
    Builder(
      builder: (context) => ListTile(
        minLeadingWidth: 10,
        dense: true,
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
          // size: 18,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontSize: 18,
          ),
        ),
        onTap: onTap,
      ),
    );
