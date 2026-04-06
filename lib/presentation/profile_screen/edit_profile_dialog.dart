import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile_bloc/profile_bloc.dart';
import '../../logic/profile_bloc/profile_event.dart';
import '../../logic/profile_bloc/profile_state.dart';

class EditProfileDialog extends StatefulWidget {
  final ProfileLoaded state;

  const EditProfileDialog({super.key, required this.state});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.state.profile.data?.name ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.state.profile.data;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔷 PROFILE IMAGE
            Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: user?.profileImage != null &&
                      user!.profileImage!.isNotEmpty
                      ? NetworkImage(user.profileImage!)
                      : null,
                  child: user?.profileImage == null ||
                      user!.profileImage!.isEmpty
                      ? const Icon(Icons.person, size: 35)
                      : null,
                ),

                /// ADD IMAGE
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      context.read<ProfileBloc>().add(PickProfileImage());
                    },
                    child: const CircleAvatar(
                      radius: 14,
                      child: Icon(Icons.add, size: 16),
                    ),
                  ),
                ),

                /// DELETE IMAGE
                if (user?.profileImage != null &&
                    user!.profileImage!.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProfileBloc>().add(DeleteProfilePhoto());
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close, size: 12),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔷 NAME (Editable)
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            /// 🔷 EMAIL (Read Only)
            TextField(
              enabled: false,
              controller: TextEditingController(text: user?.email ?? ""),
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            /// 🔷 PHONE (Read Only)
            TextField(
              enabled: false,
              controller: TextEditingController(text: user?.phone ?? ""),
              decoration: const InputDecoration(
                labelText: "Mobile",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔷 UPDATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(
                    UpdateProfileEvent(
                      name: nameController.text.trim(),
                    ),
                  );
                },
                child: const Text("Update Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}