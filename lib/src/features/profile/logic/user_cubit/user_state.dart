import 'package:meta/meta.dart';

import '../../data/model/user_model.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final AppUser user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class CreateUserSuccessfully extends UserState {}

class CreateUserFailed extends UserState {
  final String error;
  CreateUserFailed(this.error);
}

class UserUpdating extends UserState {}

class ImageUploading extends UserState {}
