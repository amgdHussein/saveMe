import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/screens/chat/cubit/chat_cubit.dart';
import 'package:save_me/widgets/app_logo.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: logoRichText(
          textStyle1: Theme.of(context).appBarTheme.textTheme.headline1,
          textStyle2: Theme.of(context).appBarTheme.textTheme.headline2,
        ),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.add),
              ],
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => true,
            widgetBuilder: (context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(),
                  title: Text("Ahmed"),
                  subtitle: Text(
                    "hi ahmed, send me your resume",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(DEFAULT_DATE_FORMAT.format(DateTime.now())),
                  onTap: () {
                    // navigateTo(
                    //   context,
                    //   ChatDetailsScreen(
                    //     userModel: model,
                    //   ),
                    // );
                  },
                ),
                // buildChatItem(SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: 10,
              );
            },
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
