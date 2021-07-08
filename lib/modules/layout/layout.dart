import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../save_me/screens/chat/bloc/chat_search_bloc.dart';
import '../save_me/screens/profile/cubit/profile_cubit.dart';
import '../save_me/screens/report/bloc/report_bloc.dart';
import '../save_me/screens/search/bloc/search_bloc.dart';
import 'cubit/layout_cubit.dart';

class AppLayout extends StatelessWidget {
  AppLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => ReportBloc()),
        BlocProvider(create: (context) => ChatSearchBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: state.screen,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.tab,
              onTap: (curretIndex) {
                BlocProvider.of<LayoutCubit>(context)
                    .changeLayout(screenIndex: curretIndex);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.home),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidComments),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.plus),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.search),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userAlt),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
