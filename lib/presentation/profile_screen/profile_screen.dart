import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/presentation/profile_screen/profile_option_tile.dart';
import 'package:flutter/material.dart';
import '../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';
import '../../logic/profile_bloc/profile_bloc.dart';
import '../../logic/profile_bloc/profile_event.dart';
import '../../logic/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      body: Column(
        children: [

          /// 🔷 HEADER (UPDATED ONLY IMAGE PART)
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {

              String name = "Loading...";
              String email = "";
              String image = "";

              if (state is ProfileLoaded) {
                name = state.profile.data?.name ?? "No Name";
                email = state.profile.data?.email ?? "";
                image = state.profile.data?.profileImage ?? "";
              }

              if (state is ProfileError) {
                name = "Error";
                email = state.message;
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1D2671), AppColors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: [

                    /// 👤 PROFILE IMAGE (UPDATED)
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: image.isNotEmpty
                          ? NetworkImage(image)
                          : null,
                      child: image.isEmpty
                          ? const Icon(Icons.person,
                          size: 30, color: Colors.black)
                          : null,
                    ),

                    const SizedBox(width: 15),

                    /// 🔷 NAME + EMAIL (UNCHANGED)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),

          /// 🔻 BLOC-BASED OPTIONS (UNCHANGED)
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(GetProfileEvent());
                await Future.delayed(const Duration(milliseconds: 500));
              },
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [

                _sectionTitle(StringConstants.account),

                ProfileOptionTile(
                  icon: Icons.person_outline,
                  title: StringConstants.editProfile,
                  action: ProfileOptionAction.editProfile,
                ),

                ProfileOptionTile(
                  icon: Icons.lock_outline,
                  title: StringConstants.changePassword,
                  action: ProfileOptionAction.changePassword,
                ),

                Divider(color: AppColors.dividerLightDarkColor),

                _sectionTitle(StringConstants.bookings),

                ProfileOptionTile(
                  icon: Icons.directions_car,
                  title: StringConstants.myBookings,
                  action: ProfileOptionAction.myBookings,
                ),

                ProfileOptionTile(
                  icon: Icons.favorite_border,
                  title: StringConstants.favorites,
                  action: ProfileOptionAction.favorites,
                ),

                ProfileOptionTile(
                  icon: Icons.notifications_none,
                  title: StringConstants.notifications,
                  action: ProfileOptionAction.notifications,
                ),

                Divider(color: AppColors.dividerLightDarkColor),

                _sectionTitle(StringConstants.helpSupport),

                ProfileOptionTile(
                  icon: Icons.help_outline,
                  title: StringConstants.helpFaq,
                  action: ProfileOptionAction.helpFaq,
                ),

                ProfileOptionTile(
                  icon: Icons.support_agent,
                  title: StringConstants.contactUs,
                  action: ProfileOptionAction.contactUs,
                ),

                ProfileOptionTile(
                  icon: Icons.library_books,
                  title: StringConstants.aboutUs,
                  action: ProfileOptionAction.aboutUs,
                ),

                Divider(color: AppColors.dividerLightDarkColor),

                _sectionTitle(StringConstants.appSettings),

                ProfileOptionTile(
                  icon: Icons.dark_mode_outlined,
                  title: StringConstants.themes,
                  action: ProfileOptionAction.selectTheme,
                ),

                ProfileOptionTile(
                  icon: Icons.language,
                  title: StringConstants.language,
                  action: ProfileOptionAction.selectLanguage,
                ),

                const SizedBox(height: 20),

                ProfileOptionTile(
                  icon: Icons.logout,
                  title: StringConstants.logout,
                  action: ProfileOptionAction.logout,
                  isLogout: true,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
          )],
      ),
    );
  }

  /// 🔹 Section Title
  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: AppTextStyle.titleStyleLB16bb.copyWith(
          color: AppColors.blue,
        ),
      ),
    );
  }
}


