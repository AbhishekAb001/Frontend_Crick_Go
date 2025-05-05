import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;
  final RxString selectedTournament = 'IPL 2024'.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    // Clear existing notifications
    notifications.clear();

    // Add tournament-specific notifications
    switch (selectedTournament.value) {
      case 'IPL 2024':
        notifications.addAll([
          {
            'title': 'IPL 2024 Season Started',
            'description':
                'Chennai Super Kings vs Royal Challengers Bangalore match begins in 30 minutes',
            'time': '30 minutes ago',
            'isRead': false,
            'type': 'tournament',
            'tournament': 'IPL 2024',
          },
          {
            'title': 'Live Match Update',
            'description':
                'CSK: 185/4 (18.2) vs RCB: 156/3 (15.0) - CSK needs 32 runs in 10 balls',
            'time': '2 hours ago',
            'isRead': false,
            'type': 'live',
            'tournament': 'IPL 2024',
          },
          {
            'title': 'Player Performance',
            'description': 'Virat Kohli scored 89 runs in 47 balls against CSK',
            'time': '3 hours ago',
            'isRead': true,
            'type': 'player',
            'tournament': 'IPL 2024',
          },
          {
            'title': 'Team Update',
            'description':
                'Chennai Super Kings moves to top of the points table',
            'time': '1 day ago',
            'isRead': true,
            'type': 'team',
            'tournament': 'IPL 2024',
          }
        ]);
        break;

      case 'T20 World Cup 2024':
        notifications.addAll([
          {
            'title': 'T20 World Cup 2024 Schedule',
            'description':
                'India vs Australia match scheduled for June 15, 2024',
            'time': '1 hour ago',
            'isRead': false,
            'type': 'tournament',
            'tournament': 'T20 World Cup 2024',
          },
          {
            'title': 'Live Match Update',
            'description':
                'India: 195/4 (18.0) vs Australia: 165/3 (15.0) - India needs 31 runs in 12 balls',
            'time': '2 hours ago',
            'isRead': false,
            'type': 'live',
            'tournament': 'T20 World Cup 2024',
          },
          {
            'title': 'Player Performance',
            'description':
                'Rohit Sharma scored 92 runs in 49 balls against Australia',
            'time': '3 hours ago',
            'isRead': true,
            'type': 'player',
            'tournament': 'T20 World Cup 2024',
          },
          {
            'title': 'Team Update',
            'description': 'India qualifies for Super 8 stage',
            'time': '1 day ago',
            'isRead': true,
            'type': 'team',
            'tournament': 'T20 World Cup 2024',
          }
        ]);
        break;

      case 'Asia Cup 2024':
        notifications.addAll([
          {
            'title': 'Asia Cup 2024 Venue',
            'description':
                'India-Pakistan match to be played at Gaddafi Stadium, Lahore',
            'time': '2 hours ago',
            'isRead': false,
            'type': 'tournament',
            'tournament': 'Asia Cup 2024',
          },
          {
            'title': 'Live Match Update',
            'description':
                'India: 245/6 (20.0) vs Pakistan: 198/4 (16.0) - Pakistan needs 48 runs in 24 balls',
            'time': '3 hours ago',
            'isRead': false,
            'type': 'live',
            'tournament': 'Asia Cup 2024',
          },
          {
            'title': 'Player Performance',
            'description':
                'Babar Azam scored 85 runs in 62 balls against India',
            'time': '4 hours ago',
            'isRead': true,
            'type': 'player',
            'tournament': 'Asia Cup 2024',
          },
          {
            'title': 'Team Update',
            'description': 'Pakistan announces squad for Asia Cup 2024',
            'time': '2 days ago',
            'isRead': true,
            'type': 'team',
            'tournament': 'Asia Cup 2024',
          }
        ]);
        break;
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
    }
  }

  void changeTournament(String tournament) {
    selectedTournament.value = tournament;
    loadNotifications();
  }

  void addNotification(Map<String, dynamic> notification) {
    notifications.insert(0, notification);
  }
}
