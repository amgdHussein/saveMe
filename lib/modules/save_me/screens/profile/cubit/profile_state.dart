part of 'profile_cubit.dart';

class ProfileState {
  final User user;

  ProfileState({@required this.user});
}

class ProfileInitial extends ProfileState {
  final User user;
  ProfileInitial({@required this.user});
}

class UpdatingPhoto extends ProfileState {
  final User user;
  UpdatingPhoto({@required this.user});
}

class UploadingPhoto extends ProfileState {
  final User user;
  UploadingPhoto({@required this.user});
}

class UpdatingName extends ProfileState {
  final User user;
  UpdatingName({@required this.user});
}
