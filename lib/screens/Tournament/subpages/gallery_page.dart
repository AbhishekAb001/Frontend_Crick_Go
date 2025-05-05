import 'dart:convert';
import 'dart:developer';

import 'package:cricket_management/model/gallerymodel.dart';
import 'package:cricket_management/screens/Tournament/tournament_screen.dart';
import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:cricket_management/service/cloudinary_service.dart';
import 'package:cricket_management/service/tournament/gallery_service.dart';
import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html; // Add this import for web
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; // Add this import for kIsWeb

class GallaryPage extends StatefulWidget {
  const GallaryPage({super.key});

  @override
  State<GallaryPage> createState() => _GallaryPageState();
}

class _GallaryPageState extends State<GallaryPage> {
  late double width;
  late double height;
  final List<String> _selectedImages = [];
  List<Uint8List>? tempImages;

  final List<String> galleryImages = [];

  Future<void> _pickImages() async {
    try {
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.multiple = true;
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files != null) {
          tempImages = <Uint8List>[];
          for (var file in files) {
            html.FileReader reader = html.FileReader();
            reader.readAsArrayBuffer(file);
            await reader.onLoadEnd.first;
            Uint8List bytes = reader.result as Uint8List;
            tempImages!.add(bytes);
          }
          _showImagePreviewDialog(tempImages!);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchGalleryImages();
  }

  // Add this to your state class variables
  bool _isLoading = false;
  bool _isAddingImages = false;

  // Update the build method
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blue,
                size: width * 0.02,
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: width * 0.015,
                      mainAxisSpacing: height * 0.02,
                      childAspectRatio: 1.0,
                    ),
                    itemCount:
                        _selectedImages.length + galleryImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildAddPhotoContainer();
                      }
                      return _buildGalleryItem(index - 1);
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  const Footer(),
                ],
              ),
            ),
    );
  }

  // Update the addImages method
  void addImages() async {
    try {
      setState(() {
        _isAddingImages = true;
      });

      List<String> imagesData =
          await CloudinaryService().uploadMultipleImages(tempImages!);
      final galleryModel =
          Gallerymodel(tournamentId: tournamentId, photos: imagesData);
      await GalleryService().addImages(galleryModel.toJson()).then((val) {
        if (val) {
          setState(() {
            Navigator.pop(context); // Close the dialog first

            _selectedImages.addAll(imagesData);
          });
        }
      });
    } catch (e) {
      log("Exception occure while add Images: $e");
    } finally {
      setState(() {
        _isAddingImages = false;
      });
    }
  }

  // Update the _fetchGalleryImages method
  void _fetchGalleryImages() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await GalleryService().fetchGalleryImages(tournamentId!).then((val) {
        setState(() {
          _selectedImages.addAll(val);
        });
      });
      log("Gallery Images: $_selectedImages");
    } catch (e) {
      log("Error fetching gallery images: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Update the _showImagePreviewDialog method to show loading while adding
  void _showImagePreviewDialog(List<Uint8List> images) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 15, 14, 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          'Selected Images',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.015,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          width: width * 0.6, // Reduced from 0.8
          height: height * 0.5, // Reduced from 0.6
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(width * 0.01),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Increased from 3
                crossAxisSpacing: width * 0.01,
                mainAxisSpacing: width * 0.01,
                childAspectRatio: 1.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.015,
                vertical: height * 0.01,
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: width * 0.01,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addImages,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.015,
                vertical: height * 0.01,
              ),
            ),
            child: (_isAddingImages)
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: width * 0.02,
                  )
                : Text(
                    'Add Images',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(int index) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 15, 14, 14).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: _selectedImages[index],
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: width * 0.05,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Failed to load image',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: width * 0.01,
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

  // Modify _buildAddPhotoContainer
  Widget _buildAddPhotoContainer() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                color: Colors.blue,
                size: width * 0.03,
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Add Photos',
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: width * 0.01,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
