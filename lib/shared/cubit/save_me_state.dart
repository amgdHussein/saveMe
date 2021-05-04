part of 'save_me_cubit.dart';

@immutable
abstract class SaveMeState {}

class SaveMeInitial extends SaveMeState {}

class SaveMeChangeBottomNavIndex extends SaveMeState {}
class SaveMeChangeBottomNavIcons extends SaveMeState {}
class SaveMeChangeBottomNavScreen extends SaveMeState {}


class GetMissingPostData extends SaveMeState {
  final List<Post> posts;
  GetMissingPostData(this.posts);
}
class GetFindingPostData extends SaveMeState {
  final List<Post> posts;
  GetFindingPostData(this.posts);
}

