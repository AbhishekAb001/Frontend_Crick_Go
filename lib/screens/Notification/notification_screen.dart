import 'package:cricket_management/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:cricket_management/controllers/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E1E1E),
            Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      notificationController.markAllAsRead();
                    },
                    child: Text(
                      'Mark all as read',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.01,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            _buildTournamentSelector(width),
            SizedBox(height: height * 0.02),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: notificationController.notifications.length,
                    itemBuilder: (context, index) {
                      final notification =
                          notificationController.notifications[index];
                      return FadeInUp(
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        child: Container(
                          margin: EdgeInsets.only(bottom: height * 0.015),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.1),
                                Colors.purple.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: notification['isRead']
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(width * 0.015),
                            leading:
                                _buildNotificationIcon(notification['type']),
                            title: Text(
                              notification['title'],
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.012,
                                fontWeight: notification['isRead']
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.01),
                                Text(
                                  notification['description'],
                                  style: GoogleFonts.poppins(
                                    fontSize: width * 0.01,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(height: height * 0.005),
                                Row(
                                  children: [
                                    Text(
                                      notification['time'],
                                      style: GoogleFonts.poppins(
                                        fontSize: width * 0.009,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.01,
                                        vertical: height * 0.002,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        notification['tournament'],
                                        style: GoogleFonts.poppins(
                                          fontSize: width * 0.008,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: !notification['isRead']
                                ? Container(
                                    width: width * 0.008,
                                    height: width * 0.008,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              notificationController.markAsRead(index);
                            },
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentSelector(double width) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTournamentButton('IPL 2024', width),
              SizedBox(width: width * 0.01),
              _buildTournamentButton('T20 World Cup 2024', width),
              SizedBox(width: width * 0.01),
              _buildTournamentButton('Asia Cup 2024', width),
            ],
          ),
        ));
  }

  Widget _buildTournamentButton(String tournament, double width) {
    final isSelected =
        notificationController.selectedTournament.value == tournament;
    return GestureDetector(
      onTap: () => notificationController.changeTournament(tournament),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: width * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Text(
          tournament,
          style: GoogleFonts.poppins(
            fontSize: width * 0.01,
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'tournament':
        icon = Icons.emoji_events;
        color = Colors.amber;
        break;
      case 'match':
        icon = Icons.sports_cricket;
        color = Colors.green;
        break;
      case 'live':
        icon = Icons.live_tv;
        color = Colors.red;
        break;
      case 'team':
        icon = Icons.group;
        color = Colors.blue;
        break;
      case 'player':
        icon = Icons.person;
        color = Colors.purple;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}
