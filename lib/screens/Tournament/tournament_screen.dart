import 'dart:developer';
import 'dart:io';

import 'package:cricket_management/controllers/page_controller.dart';
import 'package:cricket_management/model/tournament_add_model.dart';
import 'package:cricket_management/screens/Tournament/tournament_detail_screen.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:cricket_management/service/cloudinary_service.dart';
import 'package:cricket_management/service/tournament/tournament_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;

String? tournamentId;

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  final PageNavigationController _pageNavigationController =
      Get.find<PageNavigationController>();
  String selectedFilter = 'All';
  late double width;
  late double height;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final formKey = GlobalKey<FormState>();

  // Form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final organizerController = TextEditingController();
  final venueController = TextEditingController();
  final prizeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final typeController = TextEditingController();

  List<String> rules = [];

  List<Map<String, String>> timeline = [{}];

  // Track hover state for each card
  late List<bool> _isHovering;
  List<DateTime?> timelineDates = [null];

  // Update the tournaments list type
  List<Map<String, dynamic>> tournaments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
    _isHovering = List<bool>.filled(tournaments.length, false);
  }

  void _fetchTournaments() async {
    try {
      setState(() => isLoading = true);
      final fetchedTournaments = await TournamentService().fetchTournaments();
      if (mounted) {
        setState(() {
          tournaments = List<Map<String, dynamic>>.from(fetchedTournaments);
          _isHovering = List<bool>.filled(tournaments.length, false);
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching tournaments: $e');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeIn(
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.all(width * 0.015),
          child: Column(
            children: [
              // Search bar on top
              SlideInRight(
                duration: const Duration(milliseconds: 600),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.03,
                    margin: EdgeInsets.only(bottom: width * 0.01),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.01),
                      decoration: InputDecoration(
                        hintText: 'Search tournaments...',
                        hintStyle: TextStyle(
                            color: Colors.white60, fontSize: width * 0.01),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.white60, size: width * 0.015),
                        filled: true,
                        fillColor: Colors.blue[900]?.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
              ),

              // Main content
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories Column
                    SlideInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[900]?.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: width * 0.01, horizontal: width * 0.02),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildFilterOption('All'),
                            _buildFilterOption('Completed'),
                            _buildFilterOption('Ongoing'),
                            _buildFilterOption('Upcoming'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    // Updated Tournament Cards section
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 3.2,
                              ),
                              itemCount: tournaments
                                  .where((tournament) =>
                                      (_searchQuery.isEmpty ||
                                          tournament['name']!
                                              .toLowerCase()
                                              .contains(_searchQuery
                                                  .toLowerCase())) &&
                                      (selectedFilter == 'All' ||
                                          tournament['status'] ==
                                              selectedFilter))
                                  .length,
                              itemBuilder: (context, index) {
                                final filteredTournaments = tournaments
                                    .where((tournament) =>
                                        (_searchQuery.isEmpty ||
                                            tournament['name']!
                                                .toLowerCase()
                                                .contains(_searchQuery
                                                    .toLowerCase())) &&
                                        (selectedFilter == 'All' ||
                                            tournament['status'] ==
                                                selectedFilter))
                                    .toList();
                                return _buildTournamentCard(tournaments
                                    .indexOf(filteredTournaments[index]));
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (AuthSharedP.isAdmin!)
          ? FloatingActionButton.extended(
              onPressed: () {
                _showAddTournamentDialog(context);
              },
              backgroundColor: Colors.blue.shade600,
              icon: const Icon(Icons.add, size: 28, color: Colors.white),
              label: Text(
                'Add Tournament',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              elevation: 12.0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Add this method to show the dialog
  // Add a variable to store the selected image
  XFile? _selectedImage;
  Uint8List? _imageData; // Add this for web image data

  void _showAddTournamentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Text(
          'Add Tournament',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: width * 0.6,
          height: height * 0.8,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogSectionTitle('Tournament Information'),
                  _buildDialogTextField(
                    controller: nameController,
                    label: 'Tournament Name',
                  ),
                  SizedBox(height: height * 0.01),
                  _buildDialogTextField(
                    controller: typeController,
                    label: 'Tournament Type',
                  ),
                  SizedBox(height: height * 0.01),

                  // Display the selected image or a placeholder
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
                                      image:
                                          FileImage(File(_selectedImage!.path)),
                                      fit: BoxFit.cover,
                                    )
                                  : _imageData != null
                                      ? DecorationImage(
                                          image: MemoryImage(_imageData!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                            child: _selectedImage == null && _imageData == null
                                ? Center(
                                    child: Text(
                                      'Tap to select an image',
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

                  SizedBox(height: height * 0.01),
                  _buildDialogTextField(
                    controller: descriptionController,
                    label: 'Tournament Description',
                    maxLines: 3,
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField(
                          controller: organizerController,
                          label: 'Organizer',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: venueController,
                          label: 'Venue',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: prizeController,
                          label: 'Prize Pool',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedStartDate ?? DateTime.now(),
                              //i want to first date one yerar back of current date
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 365)),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: Colors.blue,
                                      onPrimary: Colors.white,
                                      surface: Color(0xFF2A2A2A),
                                      onSurface: Colors.white,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() {
                                selectedStartDate = picked;
                                startDateController.text =
                                    "${picked.day}-${picked.month}-${picked.year}";
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: _buildDialogTextField(
                              controller: startDateController,
                              label: 'Start Date',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (selectedStartDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please select start date first'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  selectedEndDate ?? selectedStartDate!,
                              firstDate: selectedStartDate!,
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: Colors.blue,
                                      onPrimary: Colors.white,
                                      surface: Color(0xFF2A2A2A),
                                      onSurface: Colors.white,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() {
                                selectedEndDate = picked;
                                endDateController.text =
                                    "${picked.day}-${picked.month}-${picked.year}";
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: _buildDialogTextField(
                              controller: endDateController,
                              label: 'End Date',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: locationController,
                          label: 'Location',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Tournament Rules'),

                  // Dynamic rules list
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          for (int i = 0; i < rules.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDialogTextField(
                                    label: 'Rule ${i + 1}',
                                    onChanged: (value) {
                                      rules[i] = value;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (rules.length > 1) {
                                        rules.removeAt(i);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: height * 0.01),
                          TextButton.icon(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            label: Text(
                              'Add Rule',
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                            onPressed: () {
                              setState(() {
                                rules.add('');
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Tournament Timeline'),

                  // Dynamic timeline list
                  // Add this near other DateTime declarations at the top of the class

                  // In the timeline section, replace the existing TextField with DatePicker
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          for (int i = 0; i < timeline.length; i++)
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: timelineDates.length > i &&
                                                timelineDates[i] != null
                                            ? timelineDates[i]!
                                            : DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2101),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                primary: Colors.blue,
                                                onPrimary: Colors.white,
                                                surface: Color(0xFF2A2A2A),
                                                onSurface: Colors.white,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          if (timelineDates.length <= i) {
                                            timelineDates.add(picked);
                                          } else {
                                            timelineDates[i] = picked;
                                          }
                                          timeline[i]['date'] =
                                              "${picked.day}-${picked.month}-${picked.year}";
                                          timeline[i]['date'] =
                                              "${picked.day}-${picked.month}-${picked.year}";
                                        });
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: _buildDialogTextField(
                                        label: 'Date',
                                        controller: TextEditingController(
                                            text: timeline[i]['date'] ?? ''),
                                        onChanged: (value) {
                                          timeline[i]['date'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  flex: 3,
                                  child: _buildDialogTextField(
                                    label: 'Event',
                                    onChanged: (value) {
                                      timeline[i]['event'] = value;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (timeline.length > 1) {
                                        timeline.removeAt(i);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: height * 0.01),
                          TextButton.icon(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            label: Text(
                              'Add Timeline Event',
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                            onPressed: () {
                              setState(() {
                                timeline.add({'date': '', 'event': ''});
                                timelineDates.add(null);
// Remove the line since timelineControllers is not defined and not needed
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: height * 0.03),
                  _buildDialogSectionTitle('Contact Information'),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField(
                          controller: emailController,
                          label: 'Email',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: phoneController,
                          label: 'Phone',
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: _buildDialogTextField(
                          controller: websiteController,
                          label: 'Website',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: create,
            child: Text(
              'Create',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.01),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.blue,
          fontSize: width * 0.012,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Update the controllers to handle DateTime
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Widget _buildDialogTextField({
    TextEditingController? controller,
    required String label,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.01),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: maxLines,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
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

  Widget _buildFilterOption(String filter) {
    bool isSelected = selectedFilter == filter;
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = filter),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: width * 0.01,
            horizontal: width * 0.02,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[900] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filter,
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.01,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentCard(int index) {
    if (index >= tournaments.length || index >= _isHovering.length) {
      return const SizedBox.shrink();
    }
    final tournament = tournaments[index];

    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovering[index] = true),
        onExit: (_) => setState(() => _isHovering[index] = false),
        child: GestureDetector(
          onTap: () {
            tournamentId = tournament['tournamentId'];
            _pageNavigationController.navigateToSubWithData(2, 0, tournament);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: _isHovering[index]
                ? (Matrix4.identity()..scale(1.03))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF242730),
              boxShadow: _isHovering[index]
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
            ),
            child: ElasticIn(
              duration: const Duration(milliseconds: 800),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.01,
                      horizontal: width * 0.008,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.08,
                          clipBehavior: Clip.antiAlias,
                          height: width * 0.08,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: tournament['imageUrl']!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(width: width * 0.01),

                        ///Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.15,
                              child: Text(
                                tournament['name']!,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: width * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),

                            ///Date
                            Text(
                              "Date: ${tournament['startDate']?.split('T')[0]} - ${tournament['endDate']?.split('T')[0]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.008,
                              ),
                            ),
                            SizedBox(height: height * 0.01),

                            ///Location
                            Text(
                              "Location: ${tournament['venue']!}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.008,
                              ),
                            ),
                            SizedBox(height: height * 0.01),

                            ///Teams
                            Text(
                              "Teams : ${tournament['totalTeams']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.008,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(width * 0.008),
                    height: width * 0.03,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Colors.lightBlue,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      tournament['status'] ?? 'Upcoming',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.01,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isCreating = false;

  void create() async {
    if (formKey.currentState!.validate() &&
        _imageData != null &&
        rules.isNotEmpty &&
        timeline.isNotEmpty) {
      setState(() {
        _isCreating = true;
      });

      try {
        // Format dates to match LocalDateTime pattern
        final startDateFormatted =
            selectedStartDate?.toIso8601String().split('.')[0];
        final endDateFormatted =
            selectedEndDate?.toIso8601String().split('.')[0];

        final tournament = TournamentAddModel(
          name: nameController.text,
          description: descriptionController.text,
          imageUrl: await CloudinaryService().uploadImage(_imageData!),
          organizer: organizerController.text,
          venue: venueController.text,
          prizePool: double.tryParse(prizeController.text),
          rules: rules,
          timelines: convertTimeLineIntoMap(),
          startDate: startDateFormatted, // Use formatted date
          endDate: endDateFormatted, // Use formatted date
          location: locationController.text,
          email: emailController.text,
          phone: phoneController.text,
          website: websiteController.text,
          status: findStatus(),
          type: typeController.text,
        );

        await TournamentService().createTournament(tournament).then((value) {
          setState(() {
            tournaments.add(value);
          });
        });

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating tournament: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  Map<String, String> convertTimeLineIntoMap() {
    Map<String, String> map = {};

    for (var event in timeline) {
      if (event['date'] != null && event['event'] != null) {
        map[event['date']!] = event['event']!;
      }
    }
    return map;
  }

  String findStatus() {
    if (selectedStartDate == null || selectedEndDate == null) {
      return 'Upcoming'; // Default status if dates are not set
    }

    final now = DateTime.now();
    if (now.isBefore(selectedStartDate!)) {
      return 'Upcoming';
    } else if (now.isAfter(selectedStartDate!) &&
        now.isBefore(selectedEndDate!)) {
      return 'Ongoing';
    } else if (now.isAfter(selectedEndDate!)) {
      return 'Completed';
    }
    return 'Upcoming';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
