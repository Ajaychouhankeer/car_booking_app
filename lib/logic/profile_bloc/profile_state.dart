import 'package:equatable/equatable.dart';
import '../../data/models/get_model/get_profile_model.dart';

enum ProfileOptionAction {
  editProfile,
  changePassword,
  myBookings,
  bookingHistory,
  favorites,
  notifications,
  helpFaq,
  contactUs,
  aboutUs,
  selectTheme,
  selectLanguage,
  logout,
}

/// 🔹 BASE STATE
class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// 🔄 LOADING
class ProfileLoading extends ProfileState {}

/// ✅ SUCCESS
class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// ❌ ERROR
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}









// import 'package:equatable/equatable.dart';
//
// import '../../data/models/get_model/get_profile_model.dart';
//
//
// enum ProfileOptionAction {
//   editProfile,
//   changePassword,
//
//   myBookings,
//   bookingHistory,
//   favorites,
//   notifications,
//
//   helpFaq,
//   contactUs,
//   aboutUs,
//
//   selectTheme,
//   selectLanguage,
//
//   logout,
// }
//
//
//
//
// class ProfileState extends Equatable {
//   const ProfileState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class ProfileLoaded extends ProfileState {
//   final ProfileModel profile;
//   ProfileLoaded(this.profile);
// }
