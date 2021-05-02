part of 'lost_cubit.dart';

@immutable
abstract class LostState {}

class LostInitial extends LostState {}


class LostChangeBottomNavIndex extends LostState {}
class LostChangeBottomNavIcons extends LostState {}
class LostChangeBottomNavScreen extends LostState {}


class GetMissingPostData extends LostState {
  final List<Post> posts;
  GetMissingPostData(this.posts);
}
class GetFindingPostData extends LostState {
  final List<Post> posts;
  GetFindingPostData(this.posts);
}

