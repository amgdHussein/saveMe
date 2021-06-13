import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/auth/blocs/auth_bloc.dart';

import 'cubit/profile_cubit.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  // ScrollController _scrollController = ScrollController();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            // controller: _scrollController,
            headerSliverBuilder: (context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                expandedHeight: 300.0,
                actions: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.userEdit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileEditScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.signOutAlt),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(AuthSignedOut());
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(20),
                  title: Text(state.user.displayName),
                  background: Image.network(
                    state.user.photoURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverAppBar(
                pinned: true,
                stretch: true,
                elevation: 0,
                toolbarHeight: 0.0,
                backgroundColor: Colors.transparent,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorPadding: EdgeInsets.all(5.0),
                  labelColor: Theme.of(context).canvasColor,
                  labelStyle: TextStyle(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Theme.of(context).canvasColor,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  tabs: [
                    Tab(text: "Your Posts"),
                    Tab(text: "Saved Posts"),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                buildImages(),
                buildImages(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildImages() => Scrollbar(
        child: ListView.separated(
          // controller: _scrollController,
          // padding: EdgeInsets.symmetric(vertical: 20.0),
          // physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Image.network(
            "https://media.sproutsocial.com/uploads/2017/11/Social-Media-Branding.png",
            fit: BoxFit.fitWidth,
          ),
          separatorBuilder: (context, index) => Divider(height: 3),
          itemCount: 5,
        ),
      );
}
