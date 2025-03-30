import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../../service/theme_controller.dart';

class SettingsPage extends GetView<ThemeController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    final mq = MediaQuery.of(context);

    return Obx(() => Scaffold(
          backgroundColor:
              controller.isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
          body: Stack(
            children: [
              Obx(() => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          controller.isDarkMode
                              ? Theme.of(context).colorScheme.surface
                              : Colors.blue[50]!,
                          controller.isDarkMode
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Colors.white,
                        ],
                      ),
                    ),
                  )),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: mq.size.width * 0.03,
                  vertical: mq.size.height * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideInDown(
                      child: Container(
                        padding: EdgeInsets.all(mq.size.width * 0.02),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.purple.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.blue.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.blue,
                              size: getSize(context, 2.5),
                            ),
                            SizedBox(width: mq.size.width * 0.01),
                            Text(
                              "Settings",
                              style: GoogleFonts.poppins(
                                fontSize: getSize(context, 2.5),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mq.size.height * 0.04),
                    ...buildEnhancedSections(context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  double getSize(BuildContext context, double factor) =>
      MediaQuery.of(context).size.width * 0.01 * factor;

  List<Widget> buildEnhancedSections(BuildContext context) {
    return [
      FadeInLeft(
        child: _buildSection(
          context,
          "Profile Settings",
          [_buildProfileTile(context)],
          icon: Icons.person,
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.3),
              Colors.purple.withOpacity(0.3)
            ],
          ),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      FadeInRight(
        child: _buildSection(
          context,
          "Preferences",
          [
            Obx(() => _buildEnhancedSwitchTile(
                  context,
                  "Dark Mode",
                  controller.isDarkMode,
                  Icons.dark_mode,
                  (val) => controller.toggleTheme(),
                )),
            _buildEnhancedSwitchTile(
              context,
              "Notifications",
              true,
              Icons.notifications,
              (val) {},
            ),
            _buildEnhancedSwitchTile(
              context,
              "Live Score Alerts",
              true,
              Icons.sports_cricket,
              (val) {},
            ),
          ],
          icon: Icons.settings_applications,
          gradient: LinearGradient(
            colors: [
              Colors.orange.withOpacity(0.3),
              Colors.red.withOpacity(0.3)
            ],
          ),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      FadeInUp(
        child: _buildSection(
          context,
          "About",
          [
            _buildEnhancedSettingTile(context, "Version", "1.0.0", Icons.info),
            _buildEnhancedSettingTile(
                context, "Terms of Service", "", Icons.description),
            _buildEnhancedSettingTile(
                context, "Privacy Policy", "", Icons.privacy_tip),
          ],
          icon: Icons.info_outline,
          gradient: LinearGradient(
            colors: [
              Colors.green.withOpacity(0.3),
              Colors.teal.withOpacity(0.3)
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildEnhancedSettingTile(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: getSize(context, 2)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: getSize(context, 1.2),
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: getSize(context, 1),
                  color: Colors.grey[400],
                ),
              )
            : null,
        trailing:
            Icon(Icons.arrow_forward_ios, color: Colors.blue.withOpacity(0.7)),
        onTap: () =>
            Get.toNamed('/${title.toLowerCase().replaceAll(' ', '_')}'),
      ),
    );
  }

  Widget _buildEnhancedSwitchTile(BuildContext context, String title,
      bool value, IconData icon, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: SwitchListTile(
        secondary: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: getSize(context, 2)),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: getSize(context, 1.2),
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        inactiveTrackColor: Colors.grey[800],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children,
      {IconData? icon, LinearGradient? gradient}) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[800]!, width: 1),
        gradient: gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white70, size: getSize(context, 2)),
                  SizedBox(width: 10),
                ],
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: getSize(context, 1.5),
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/profile_edit'),
      child: Container(
        margin: EdgeInsets.all(getSize(context, 1)),
        padding: EdgeInsets.all(getSize(context, 1.5)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: getSize(context, 4),
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://resources.pulse.icc-cricket.com/ICC/photo/2024/02/08/3d7b5e7f-7f20-447d-8fb3-77dd252c9e98/Rohit-Sharma.jpg'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Icon(Icons.verified, size: 15, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: getSize(context, 1)),
            Text(
              "Rohit Sharma",
              style: GoogleFonts.poppins(
                fontSize: getSize(context, 1.4),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Team India Captain",
              style: GoogleFonts.poppins(
                fontSize: getSize(context, 1),
                color: Colors.blue[300],
              ),
            ),
            SizedBox(height: getSize(context, 1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(context, "Matches", "400+"),
                _buildStatItem(context, "Runs", "15000+"),
                _buildStatItem(context, "Avg", "48.7"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: getSize(context, 1.2),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: getSize(context, 0.9),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
