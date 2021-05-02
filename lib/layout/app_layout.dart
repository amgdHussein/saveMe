import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//styles
import 'package:save_me/shared/constants/colors.dart';
import 'package:save_me/shared/cubit/lost_cubit.dart';

class AppLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LostCubit>(
      create: (BuildContext context) => LostCubit(),
      child: BlocConsumer<LostCubit, LostState>(
        listener: (BuildContext context, LostState state) {
          print(state);
        },
        builder: (BuildContext context, LostState state) {

          LostCubit cubit = LostCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: cubit.screen,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                iconSize: 35,
                selectedItemColor: bourbon,
                unselectedItemColor: bourbon,

                currentIndex: cubit.tab,
                onTap: (curretIndex) {
                  LostCubit.get(context).updateCurrentTab(curretIndex: curretIndex);
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
