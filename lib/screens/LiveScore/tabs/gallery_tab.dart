import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_management/widgets/footer.dart';

class GalleryTab extends StatefulWidget {
  const GalleryTab({super.key});

  @override
  State<GalleryTab> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  late double width;
  late double height;
  int selectedTabIndex = 0;
  final List<String> tabs = ['PHOTOS', 'VIDEOS', 'HIGHLIGHTS'];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.025),

            // Custom tab bar similar to statistics page
            _buildTabBar(width, height),

            SizedBox(height: height * 0.025),

            // Content based on selected tab
            Container(
              height: height * 0.6, // Set a fixed height for content
              child: selectedTabIndex == 0
                  ? _buildPhotosGrid()
                  : selectedTabIndex == 1
                      ? _buildVideosGrid()
                      : _buildHighlightsGrid(),
            ),

            SizedBox(height: height * 0.04),

            // Add Footer with animation
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 800),
              child: const Footer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        tabs.length,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: selectedTabIndex == index
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selectedTabIndex == index
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.poppins(
                  color: selectedTabIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                  fontSize: width * 0.012,
                  fontWeight: selectedTabIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosGrid() {
    final List<String> photos = [
      'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
      'https://img.cricketworld.com/images/f-126249/2023-04-09t120455z_1283255784_up1ej490xk5oe_rtrmadp_3_cricket-ipl.jpg',
      'https://img.cricketworld.com/images/f-066249/mitchell-starc.jpg',
      'https://img.cricketworld.com/images/f-066249/jasprit-bumrah.jpg',
      'https://img.cricketworld.com/images/f-066249/pat-cummins.jpg',
      'https://img.cricketworld.com/images/f-066249/david-warner.jpg',
      'https://img.cricketworld.com/images/f-096249/kl-rahul.jpg',
      'https://img.cricketworld.com/images/f-066249/steve-smith.jpg',
      'https://img.cricketworld.com/images/f-066249/hardik-pandya.jpg',
    ];

    return GridView.builder(
      padding: EdgeInsets.all(width * 0.02),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: width * 0.01,
        mainAxisSpacing: width * 0.01,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return _buildPhotoItem(photos[index]);
      },
    );
  }

  Widget _buildVideosGrid() {
    final List<Map<String, String>> videos = [
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
        'title': 'Rohit Sharma\'s brilliant 22 off 18 balls',
        'duration': '1:24',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-126249/2023-04-09t120455z_1283255784_up1ej490xk5oe_rtrmadp_3_cricket-ipl.jpg',
        'title': 'Virat Kohli\'s quick 15 off 12 balls',
        'duration': '0:58',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/mitchell-starc.jpg',
        'title': 'Mitchell Starc\'s wicket of Rohit Sharma',
        'duration': '0:45',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/pat-cummins.jpg',
        'title': 'Pat Cummins dismisses KL Rahul',
        'duration': '0:38',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/josh-hazlewood.jpg',
        'title': 'Josh Hazlewood\'s perfect yorker to Pant',
        'duration': '0:42',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/jasprit-bumrah.jpg',
        'title': 'Jasprit Bumrah\'s economical spell',
        'duration': '1:15',
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.all(width * 0.02),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.01,
        mainAxisSpacing: width * 0.01,
        childAspectRatio: 1.5,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return _buildVideoItem(
          videos[index]['thumbnail']!,
          videos[index]['title']!,
          videos[index]['duration']!,
        );
      },
    );
  }

  Widget _buildHighlightsGrid() {
    final List<Map<String, dynamic>> highlights = [
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-106249/rohit-sharma-2021.jpg',
        'title': 'Match Highlights: WIZARDS vs CHALLENGERS',
        'duration': '5:30',
        'type': 'Full Highlights',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/mitchell-starc.jpg',
        'title': 'Bowling Highlights',
        'duration': '3:15',
        'type': 'Bowling',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-126249/2023-04-09t120455z_1283255784_up1ej490xk5oe_rtrmadp_3_cricket-ipl.jpg',
        'title': 'Batting Highlights',
        'duration': '3:45',
        'type': 'Batting',
      },
      {
        'thumbnail':
            'https://img.cricketworld.com/images/f-066249/jasprit-bumrah.jpg',
        'title': 'Best Moments',
        'duration': '2:20',
        'type': 'Moments',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(width * 0.02),
      itemCount: highlights.length,
      itemBuilder: (context, index) {
        return _buildHighlightItem(
          highlights[index]['thumbnail'],
          highlights[index]['title'],
          highlights[index]['duration'],
          highlights[index]['type'],
        );
      },
    );
  }

  Widget _buildPhotoItem(String imageUrl) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.withOpacity(0.3),
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoItem(String thumbnailUrl, String title, String duration) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: width * 0.02,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.008,
                        vertical: height * 0.003,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: width * 0.008,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.01),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.01,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightItem(
      String thumbnailUrl, String title, String duration, String type) {
    return Bounce(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.01),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    width: width * 0.15,
                    height: height * 0.1,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.withOpacity(0.3),
                      width: width * 0.15,
                      height: height * 0.1,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.withOpacity(0.3),
                      width: width * 0.15,
                      height: height * 0.1,
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(width * 0.008),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: width * 0.015,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.006,
                        vertical: height * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: width * 0.007,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.012,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: height * 0.005),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.008,
                        vertical: height * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: width * 0.008,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.download_outlined,
                color: Colors.white60,
                size: width * 0.02,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
