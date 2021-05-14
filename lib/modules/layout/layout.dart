import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/layout_cubit.dart';

class AppLayout extends StatelessWidget {
  AppLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
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
                  icon: Icon(Icons.home_filled),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outlined),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_rounded),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded),
                  // ignore: deprecated_member_use
                  title: SizedBox.shrink(),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
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
