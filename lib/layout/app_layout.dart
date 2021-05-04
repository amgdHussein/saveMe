import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:save_me/shared/cubit/save_me_cubit.dart';

class AppLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaveMeCubit>(
      create: (BuildContext context) => SaveMeCubit(),
      child: BlocConsumer<SaveMeCubit, SaveMeState>(
        listener: (BuildContext context, SaveMeState state) {
          print(state);
        },
        builder: (BuildContext context, SaveMeState state) {
          SaveMeCubit cubit = SaveMeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: cubit.screen,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.tab,
                onTap: (curretIndex) {
                  SaveMeCubit.get(context).updateCurrentTab(curretIndex: curretIndex);
                },

                items: [
                  BottomNavigationBarItem(
                    icon: Icon(cubit.icons[0]),
                    // ignore: deprecated_member_use
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(cubit.icons[1]),
                    // ignore: deprecated_member_use
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(cubit.icons[2]),
                    // ignore: deprecated_member_use
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(cubit.icons[3]),
                    // ignore: deprecated_member_use
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(cubit.icons[4]),
                    // ignore: deprecated_member_use
                    title: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
