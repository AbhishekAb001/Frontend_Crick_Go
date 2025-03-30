import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GallaryPage extends StatefulWidget {
  const GallaryPage({Key? key}) : super(key: key);

  @override
  State<GallaryPage> createState() => _GallaryPageState();
}

class _GallaryPageState extends State<GallaryPage> {
  late double width;
  late double height;
  int? selectedImageIndex;

  // Sample gallery images - in a real app, these would come from an API or database
  final List<Map<String, dynamic>> galleryImages = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Opening Ceremony',
      'date': '22 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1531415074968-036ba1b575da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Match Highlights',
      'date': '23 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1624880357913-a8539238245b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGNyaWNrZXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Team Celebration',
      'date': '24 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1629285483773-6b5cde5482c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNyaWNrZXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Award Ceremony',
      'date': '25 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1626016753965-0f95c8b3afe5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGNyaWNrZXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Team Photo',
      'date': '22 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1580748141549-71748dbe0bdc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Practice Session',
      'date': '21 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1589801258579-18e091f4ca26?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGNyaWNrZXR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Fan Moments',
      'date': '23 Mar 2024',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1531415074968-036ba1b575da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y3JpY2tldHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
      'title': 'Stadium View',
      'date': '24 Mar 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGalleryHeader(),
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
              itemCount: galleryImages.length,
              itemBuilder: (context, index) => _buildGalleryItem(index),
            ),
            SizedBox(height: height * 0.02),
            const Footer(),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.015,
            vertical: height * 0.008,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.photo_library,
                color: Colors.blue,
                size: width * 0.012,
              ),
              SizedBox(width: width * 0.005),
              Text(
                "${galleryImages.length} Photos",
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: width * 0.01,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: width * 0.015,
        mainAxisSpacing: height * 0.02,
        childAspectRatio: 1.0,
      ),
      itemCount: galleryImages.length,
      itemBuilder: (context, index) {
        return _buildGalleryItem(index);
      },
    );
  }

  Widget _buildGalleryItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImageIndex = index;
        });
        _showImagePreview(context, index);
      },
      child: FadeInUp(
        delay: Duration(milliseconds: 100 * index),
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: galleryImages[index]['imageUrl'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          galleryImages[index]['title'],
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          galleryImages[index]['date'],
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: width * 0.008,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(width * 0.02),
        child: Container(
          width: width * 0.7,
          height: height * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      galleryImages[index]['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: width * 0.015,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: CachedNetworkImage(
                    imageUrl: galleryImages[index]['imageUrl'],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: index > 0
                          ? () {
                              setState(() {
                                selectedImageIndex = index - 1;
                              });
                              Navigator.pop(context);
                              _showImagePreview(context, index - 1);
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: index > 0 ? Colors.white : Colors.grey,
                        size: width * 0.015,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "${index + 1} / ${galleryImages.length}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.012,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    IconButton(
                      onPressed: index < galleryImages.length - 1
                          ? () {
                              setState(() {
                                selectedImageIndex = index + 1;
                              });
                              Navigator.pop(context);
                              _showImagePreview(context, index + 1);
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: index < galleryImages.length - 1
                            ? Colors.white
                            : Colors.grey,
                        size: width * 0.015,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
