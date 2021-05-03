import 'package:flutter/cupertino.dart';

//bloc
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:save_me/models/post.dart';

//data
import 'package:save_me/shared/constants/app_icons/bottom_bar_icons.dart';
import 'package:save_me/shared/constants/screens_list.dart';

part 'lost_state.dart';

class LostCubit extends Cubit<LostState> {

  int _tab;
  get tab => this._tab;

  List<IconData> _icons;
  get icons => this._icons;

  Widget _screen;
  get screen => this._screen;

  LostCubit() : super(LostInitial()) {
    this.updateCurrentTab(curretIndex: 0);
  }

  // get context
  static LostCubit get(BuildContext context) => BlocProvider.of(context);

  // change bottom app bar
  void updateCurrentTab({@required int curretIndex}) {
    this._tab = curretIndex;
    emit(LostChangeBottomNavIndex());

    this.updateBarIcons(selectedIndex: curretIndex);
    this.updateCurrentScreen(selectedIndex: curretIndex);
  }
  void updateBarIcons({@required int selectedIndex}) {
    this._icons = []..addAll(unselectedIcons);
    this._icons[selectedIndex] = selectedIcons[selectedIndex];
    emit(LostChangeBottomNavIcons());
  }
  void updateCurrentScreen({@required int selectedIndex}){
    this._screen = screens[selectedIndex];
    emit(LostChangeBottomNavScreen());
  }

  // posts
  final List<Post> _posts = [
    Post(name: "Mahmoud Shrif",imagePath: "https://images.unsplash.com/photo-1619695654641-243759a638e7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
    Post(name: "Ahmed Mohamed",imagePath: "https://images.unsplash.com/photo-1619687683232-05301e818432?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
    Post(name: "Khaled Rizk",imagePath: "https://images.unsplash.com/photo-1619604833378-76cc228cb649?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
    Post(name: "Anderson Santos",imagePath: "https://images.unsplash.com/photo-1617732973321-cbc6b6c5844a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80"),
  ];
  List<Post> get posts => this._posts;
  List<Post> getMissingPostData(){
    List<Post> missingPosts = this.posts.sublist(0, 2);
    // emit(GetMissingPostData(missingPosts));
    return missingPosts;
  }
  List<Post> getFindingPostData(){
    List<Post> findingPosts = this.posts.sublist(2, 4);
    // emit(GetFindingPostData(findingPosts));
    return findingPosts;
  }

}
