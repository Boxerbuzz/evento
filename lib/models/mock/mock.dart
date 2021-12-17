import 'package:evento/exports.dart';

class MockData {
  static List<Map<String, String>> get events => [
        {
          'date': 'Web, Apr 28. 5:30 PM',
          'name': "Jo Malone London's Mother's Day Presents",
          'location': 'Radius Gallery. Santa Cruz, CA',
          'img': 'e1',
          'backdrop': 'e1l',
          'color': ''
        },
        {
          'date': 'Mon, Jun 21. 10:00 PM',
          'name': "Collectivity Plays the Music of Jimi",
          'location': 'Longboard Margarita Bar',
          'img': 'e7',
          'backdrop': 'e7l',
          'color': '',
        },
        {
          'date': 'Mon, Dec 27. 3:00 PM',
          'name': "Flo Haven's Fundraiser",
          'location': 'The Garden. Ikoyi, Lagos',
          'img': 'e4',
          'backdrop': 'e4l',
          'color': ''
        },
        {
          'date': 'Sat, May 1. 2:00 PM',
          'name': "A Virtual Evening of Smooth Jazz",
          'location': 'Lot 13. Oakland, CA',
          'img': 'e2',
          'backdrop': 'e2',
          'color': ''
        },
        {
          'date': 'Friday, Apr 24. 1:30 PM',
          'name': "Women's Leadership Conference 2021",
          'location': '53 Bush St. San Fransisco, CA',
          'img': 'e5',
          'backdrop': '',
          'color': ''
        },
        {
          'date': 'Fri, Apr 23. 6:00 PM',
          'name': "International Kids Safe Parents Night Out",
          'location': 'Lot 13. Oakland, CA',
          'img': 'e6',
          'backdrop': '',
          'color': ''
        },
        {
          'date': 'Sun, Apr 25. 10:15 AM',
          'name': "International Gala Music Festival",
          'location': '36 Guild Street London, UK',
          'img': 'e8',
          'backdrop': '',
          'color': ''
        },
        {
          'date': 'Sat, May 1. 2:00 PM',
          'name': "A Virtual Evening of Smooth Jazz",
          'location': 'Lot 13. Oakland, CA',
          'img': 'e3',
          'backdrop': '',
          'color': ''
        },
      ];

  static Future<List<dynamic>> getEvents() async {
    await Future.delayed(2000.milliseconds);
    return events;
  }

  static List<String> avatars = ['1', '2', '3', '4', '5', '6', '7', '8'];
}
