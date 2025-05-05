import 'dart:developer';

import 'package:cricket_management/model/teams_model.dart';
import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:cricket_management/service/cloudinary_service.dart';
import 'package:cricket_management/service/tournament/teams_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_management/widgets/footer.dart'; // Add this import
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:cricket_management/widgets/member_search_widget.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

final List<Map<String, dynamic>> teams = [];

class _TeamsPageState extends State<TeamsPage> {
  double width = 0;
  double height = 0;
  int? hoveredIndex;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _captainNameController = TextEditingController();
  final TextEditingController _teamEmailController = TextEditingController();
  final TextEditingController _teamPhoneController = TextEditingController();
  final TextEditingController _teamDescriptionController =
      TextEditingController();
  XFile? _selectedImage;
  Uint8List? _imageData;
  final List<Map<String, dynamic>> _selectedMembers = [];
  List<Map<String, dynamic>> members = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTeams();
    _fetchMembers();
  }

  Future<void> _fetchTeams() async {
    setState(() {
      isLoading = true;
    });

    await TeamsService().getTeams(tournamentId!).then((value) {
      setState(() {
        teams.clear();
        teams.addAll(value);
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      log('Error fetching teams: $error');
    });
  }

  Future<void> _fetchMembers() async {
    await TeamsService().getMembers().then((value) {
      setState(() {
        members = value;
      });
    });
  }

  void _showAddTeamDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: width * 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: const Color(0xFF2A2A2A),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width * 0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add New Team',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Image selection
                    StatefulBuilder(
                      builder: (context, setState) {
                        return GestureDetector(
                          onTap: () async {
                            if (!kIsWeb) {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                _selectedImage = image;
                              });
                            } else {
                              html.FileUploadInputElement uploadInput =
                                  html.FileUploadInputElement();
                              uploadInput.accept = 'image/*';
                              uploadInput.click();

                              uploadInput.onChange.listen((e) {
                                final file = uploadInput.files?.first;
                                if (file != null) {
                                  final reader = html.FileReader();
                                  reader.readAsArrayBuffer(file);
                                  reader.onLoadEnd.listen((event) {
                                    setState(() {
                                      _imageData = reader.result as Uint8List;
                                    });
                                  });
                                }
                              });
                            }
                          },
                          child: Center(
                            child: Container(
                              width: width * 0.2,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                image: _selectedImage != null && !kIsWeb
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(_selectedImage!.path)),
                                        fit: BoxFit.cover,
                                      )
                                    : _imageData != null
                                        ? DecorationImage(
                                            image: MemoryImage(_imageData!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                              ),
                              child:
                                  _selectedImage == null && _imageData == null
                                      ? Center(
                                          child: Text(
                                            'Tap to select team logo',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white70,
                                              fontSize: width * 0.012,
                                            ),
                                          ),
                                        )
                                      : null,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildStyledTextField(
                            controller: _teamNameController,
                            label: 'Team Name',
                            icon: Icons.flag,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildStyledTextField(
                            controller: _teamDescriptionController,
                            label: 'Team Description',
                            icon: Icons.description,
                            maxLines: 3,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildStyledTextField(
                            controller: _captainNameController,
                            label: 'Captain Name',
                            icon: Icons.person,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildStyledTextField(
                            controller: _teamEmailController,
                            label: 'Team Email',
                            icon: Icons.email,
                          ),
                          SizedBox(height: height * 0.02),
                          _buildStyledTextField(
                            controller: _teamPhoneController,
                            label: 'Team Phone',
                            icon: Icons.phone,
                          ),
                          SizedBox(height: height * 0.02),
                          Container(
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MemberSearchWidget(
                              members: members,
                              initialSelectedMembers: _selectedMembers,
                              hintText: 'Search team members...',
                              onSelectedMembersChanged: (selectedMembers) {
                                setState(() {
                                  _selectedMembers.clear();
                                  _selectedMembers.addAll(selectedMembers);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDialogButton(
                          text: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                          color: Colors.red,
                        ),
                        _buildDialogButton(
                          text: 'Add Team',
                          onPressed: addTeam,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addTeam() async {
    if (_teamNameController.text.trim().isNotEmpty &&
        _captainNameController.text.trim().isNotEmpty &&
        _teamPhoneController.text.trim().isNotEmpty &&
        _teamEmailController.text.trim().isNotEmpty &&
        _teamDescriptionController.text.trim().isNotEmpty && // Add this check
        _selectedMembers.isNotEmpty &&
        _imageData != null) {
      try {
        final logoUrl = await CloudinaryService().uploadImage(_imageData!);

        TeamsModel team = TeamsModel(
          tournamentId: tournamentId,
          captain: _captainNameController.text,
          email: _teamEmailController.text,
          logo: logoUrl,
          name: _teamNameController.text,
          phone: _teamPhoneController.text,
          description: _teamDescriptionController.text, // Add this field
          members: _selectedMembers
              .map((member) => member['userId'] as String)
              .toList(),
        );

        log('team: ${team.toJson()}');
        await TeamsService().addTeam(team.toJson()).then((value) {
          _fetchTeams();
        });

        _teamNameController.clear();
        _captainNameController.clear();
        _teamEmailController.clear();
        _teamPhoneController.clear();
        setState(() {
          _selectedMembers.clear();
          _imageData = null;
          _selectedImage = null;
        });
        Get.snackbar(
          'Success',
          'Team added successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, // Add this line
        );

        Navigator.pop(context);
      } catch (e) {
        log('Error adding team: $e');
        Get.snackbar(
          'Error',
          'Failed to add team: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, // Add this line
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill in all the fields and select at least one member',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.poppins(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.015,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDialogButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.015,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: width * 0.012,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Team Button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.02),
                child: (AuthSharedP.isAdmin!)
                    ? ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Add Team',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.015,
                          ),
                        ),
                        onPressed: _showAddTeamDialog,
                      )
                    : const SizedBox(),
              ),
            ),

            // Modify the GridView.builder section
            LayoutBuilder(
              builder: (context, constraints) {
                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }

                if (teams.isEmpty) {
                  return Center(
                    child: Text(
                      'No teams found. Click "Add Team" to create one.',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: width * 0.02,
                      ),
                    ),
                  );
                }

                // Fixed 3 columns layout
                int crossAxisCount = 3;
                double cardWidth = constraints.maxWidth / crossAxisCount;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1,
                    crossAxisSpacing: width * 0.02,
                    mainAxisSpacing: height * 0.02,
                  ),
                  itemCount: teams.length,
                  itemBuilder: (context, index) => _buildTeamCard(index),
                );
              },
            ),
            SizedBox(height: width * 0.02),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(int index) {
    final team = teams[index];
    return FadeInUp(
      duration: Duration(milliseconds: 400 + (index * 100)),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = null),
        child: GestureDetector(
          onTap: () {
            // Handle team card tap
          },
          child: Container(
            margin: EdgeInsets.all(width * 0.003), // Reduced from 0.005
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(width * 0.01), // Reduced from 0.015
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: hoveredIndex == index
                      ? [
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.1),
                        ]
                      : [
                          Colors.blue.withOpacity(0.1),
                          Colors.blue.withOpacity(0.05),
                        ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: hoveredIndex == index
                      ? Colors.blue.withOpacity(0.7)
                      : Colors.blue.withOpacity(0.3),
                  width: hoveredIndex == index ? 2 : 1,
                ),
                boxShadow: hoveredIndex == index
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 3,
                        )
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Team Logo
                  AspectRatio(
                    aspectRatio:
                        2.0, // Increased from 1.8 to make image smaller
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12), // Reduced from 15
                      child: CachedNetworkImage(
                        imageUrl: team['teamLogo'] ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.withOpacity(0.5),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.sports_cricket,
                          color: Colors.blue.withOpacity(0.5),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.015), // Reduced from 0.02

                  // Team Name
                  Text(
                    team['teamName'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.015, // Reduced from 0.018
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[200], // Changed title color
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.01), // Reduced from 0.015

                  // Team Info Section
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.008, // Reduced from 0.01
                      horizontal: width * 0.006, // Reduced from 0.008
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8), // Reduced from 10
                    ),
                    child: Column(
                      children: [
                        // Captain Info
                        _buildInfoRow(
                          icon: Icons.person,
                          label: 'Captain',
                          value: team['teamCaptain'] ?? '',
                        ),
                        SizedBox(height: height * 0.02), // Reduced from 0.03
                        // Total Players
                        _buildInfoRow(
                          icon: Icons.people,
                          label: 'Players',
                          value: team['teamMemberIds'].length.toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.015), // Reduced from 0.02

                  // Stats
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.006, // Reduced from 0.008
                      horizontal: width * 0.006, // Reduced from 0.008
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.1),
                          Colors.blue.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8), // Reduced from 10
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                            'Matches', team['matchesPlayed']?.toString() ?? '0'),
                        _buildStatItem(
                            'Wins', team['wins']?.toString() ?? '0'),
                        _buildStatItem(
                            'Losses', team['losses']?.toString() ?? '0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modify the _buildInfoRow method
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue.withOpacity(0.7),
          size: width * 0.01, // Reduced from 0.012
        ),
        SizedBox(width: width * 0.006), // Reduced from 0.008
        Expanded(
          child: Text(
            '$label: $value',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: width * 0.008, // Reduced from 0.01
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Modify the _buildStatItem method
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.008, // Reduced from 0.01
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: width * 0.006, // Reduced from 0.008
          ),
        ),
      ],
    );
  }
}
