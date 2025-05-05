import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/controllers/profile_controller.dart';
import 'package:cricket_management/model/updated_user.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:cricket_management/service/cloudinary_service.dart';
import 'package:cricket_management/service/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ProfileController profileController = Get.find<ProfileController>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  bool isEditing = false;
  Uint8List? tempImages;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: profileController.profileData["name"] ?? '');
    _phoneController = TextEditingController(
        text: profileController.profileData["phoneNumber"] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Update the edit dialog to use GetX
  void _showEditDialog(String field, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $field'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                isEditing = true;
                if (field == 'Name') {
                  profileController.updateProfileData('name', controller.text);
                } else if (field == 'Phone Number') {
                  profileController.updateProfileData(
                      'phoneNumber', controller.text);
                } else if (field == 'Email') {
                  profileController.updateProfileData('email', controller.text);
                } else if (field == 'Role') {
                  profileController.updateProfileData(
                      'roleType', controller.text);
                }
                Navigator.pop(context);

                setState(() {});
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _buildProfileSection(),
            ),
            const SizedBox(height: 20),
            SlideInLeft(
              duration: const Duration(milliseconds: 600),
              child: _buildAccountInfoSection(),
            ),
            const SizedBox(height: 20),
            SlideInRight(
              duration: const Duration(milliseconds: 700),
              child: _buildStatisticsSection(),
            ),
            const SizedBox(height: 20),
            SlideInLeft(
              duration: const Duration(milliseconds: 800),
              child: (isEditing) ? _buildButtons() : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () {
            setState(() {
              isEditing = false;
            });
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.withOpacity(0.3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () async {
            setState(() {
              isEditing = false;
            });
            try {
              UpdatedUser updatedUser = UpdatedUser(
                username: profileController.profileData["username"] ?? '',
                name: profileController.profileData["name"] ?? '',
                phoneNumber: profileController.profileData["phoneNumber"] ?? '',
                email: profileController.profileData["email"] ?? '',
                roleType: profileController.profileData["roleType"] ?? '',
                imgUrl: await getImage(),
              );
              SettingService()
                  .updateUserProfile(updatedUser.toJson())
                  .then((val) {
                AuthSharedP().setProfileData(val);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile Updated Successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Text(
            'Save',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<String> getImage() async {
    if (tempImages == null) {
      return profileController.profileData["imgUrl"] ?? '';
    }
    String url = await CloudinaryService().uploadImage(tempImages!);
    return url;
  }

  Future<void> _pickImages() async {
    try {
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.multiple = false;
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          html.FileReader reader = html.FileReader();
          reader.readAsArrayBuffer(files[0]);
          await reader.onLoadEnd.first;
          setState(() {
            tempImages = reader.result as Uint8List;
            isEditing = true;
          });
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: tempImages != null
                        ? MemoryImage(tempImages!)
                        : NetworkImage(
                                profileController.profileData["imgUrl"] ?? '')
                            as ImageProvider,
                    backgroundColor: Colors.grey[200],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Obx(() => Text(
                profileController.profileData["name"] ?? 'N/A',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
          const SizedBox(height: 5),
          Obx(() => Text(
                profileController.profileData["email"] ?? 'N/A',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAccountInfoSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.teal[100],
              ),
            ),
            const Divider(height: 25, thickness: 1, color: Color(0xFFE0E0E0)),
            Obx(() => _buildInfoTile(Icons.person_outline, 'Username',
                profileController.profileData["username"] ?? 'N/A')),
            _buildEditableInfoTile(
                Icons.badge_outlined,
                'Name',
                _nameController,
                () => _showEditDialog('Name', _nameController)),
            _buildEditableInfoTile(
                Icons.email_outlined,
                'Email',
                TextEditingController(
                    text: profileController.profileData["email"] ?? ''),
                () => _showEditDialog(
                    'Email',
                    TextEditingController(
                        text: profileController.profileData["email"] ?? ''))),
            _buildEditableInfoTile(
                Icons.phone_outlined,
                'Phone Number',
                _phoneController,
                () => _showEditDialog('Phone Number', _phoneController)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player Statistics',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.teal[100],
              ),
            ),
            const Divider(height: 25, thickness: 1, color: Color(0xFFE0E0E0)),
            _buildEditableInfoTile(
                Icons.sports_cricket_outlined,
                'Role',
                TextEditingController(
                    text: profileController.profileData["roleType"] ?? 'N/A'),
                () => _showEditDialog(
                    'Role',
                    TextEditingController(
                        text:
                            profileController.profileData["roleType"] ?? ''))),
            Obx(() => _buildInfoTile(
                Icons.format_list_numbered,
                'Matches Played',
                profileController.profileData["playCount"]?.toString() ?? '0')),
            Obx(() => _buildInfoTile(Icons.run_circle_outlined, 'Total Runs',
                profileController.profileData["totalRun"]?.toString() ?? '0')),
            Obx(() => _buildInfoTile(
                Icons.speed_outlined,
                'Run Rate',
                (profileController.profileData["runRate"]?.toString() ??
                    '0.00'))),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading:
          Icon(icon, color: Colors.teal[100]), // Light icon color for contrast
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.white, // Ensure text is visible on dark background
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          color: Colors.white70, // Ensure text is visible on dark background
        ),
      ),
      dense: true,
    );
  }

  Widget _buildEditableInfoTile(IconData icon, String title,
      TextEditingController controller, VoidCallback onEdit) {
    return ListTile(
      leading:
          Icon(icon, color: Colors.teal[100]), // Light icon color for contrast
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.white, // Ensure text is visible on dark background
        ),
      ),
      subtitle: Text(
        controller.text,
        style: GoogleFonts.poppins(
          color: Colors.white70, // Ensure text is visible on dark background
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.grey),
        onPressed: onEdit,
        tooltip: 'Edit $title',
      ),
      dense: true,
    );
  }
}
