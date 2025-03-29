import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Tournament Added',
      'description': 'IPL 2024 has been added to the tournament list',
      'time': '2 minutes ago',
      'isRead': false,
      'type': 'tournament',
    },
    {
      'title': 'Match Result',
      'description': 'India won by 5 wickets against Australia',
      'time': '1 hour ago',
      'isRead': true,
      'type': 'match',
    },
    {
      'title': 'Live Score Update',
      'description': 'IND: 256/4 (35.2) vs AUS: 245/8 (40.0)',
      'time': '2 hours ago',
      'isRead': false,
      'type': 'live',
    },
    {
      'title': 'Team Update',
      'description': 'Virat Kohli added to Indian Cricket Team',
      'time': '1 day ago',
      'isRead': true,
      'type': 'team',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1E1E),
            const Color(0xFF0A0A0A),
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
                      // Mark all as read
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
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
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
                        leading: _buildNotificationIcon(notification['type']),
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
                            Text(
                              notification['time'],
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.009,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        trailing: !notification['isRead']
                            ? Container(
                                width: width * 0.008,
                                height: width * 0.008,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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