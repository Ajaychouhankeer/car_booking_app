
import 'package:equatable/equatable.dart';

import 'package:bloc_project_basic/logic/profile_bloc/profile_state.dart';


sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// ✅ API CALL EVENT
class GetProfileEvent extends ProfileEvent {}

class ProfileDataFetching extends ProfileEvent {}
class PickProfileImage extends ProfileEvent {}
class DeleteProfilePhoto extends ProfileEvent {}

class ProfileOptionTapped extends ProfileEvent {
  final ProfileOptionAction action;
  const ProfileOptionTapped(this.action);

  @override
  List<Object?> get props => [action];
}

class UpdateProfileEvent extends ProfileEvent {
  final String name;

  const UpdateProfileEvent({required this.name});
}



//
//
// import 'package:bloc_project_basic/logic/profile_bloc/profile_state.dart';
// import 'package:equatable/equatable.dart';
//
// sealed class ProfileEvent extends Equatable {
//   const ProfileEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// /// ✅ API CALL EVENT
// class GetProfileEvent extends ProfileEvent {}
//
// class ProfileDataFetching extends ProfileEvent {}
// class PickProfileImage extends ProfileEvent {}
// class DeleteProfilePhoto extends ProfileEvent {}
//
// class ProfileOptionTapped extends ProfileEvent {
//   final ProfileOptionAction action;
//   const ProfileOptionTapped(this.action);
//
//   @override
//   List<Object?> get props => [action];
// }
