import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvGlobal {
  final GlobalKey<NavigatorState> navKey = GlobalKey();

  NavigatorState? get nav => navKey.currentState!;

  Map<String, WidgetBuilder> myRoutes = {
    '*': (_) => const WelcomeScreen(),
    'home': (_) => const MainScreen(),
    'login': (_) => const AuthScreen(),
    'notification': (_) => const NotificationScreen(),
    'details': (_) => const DetailScreen(),
    'profile': (_) => const ProfileScreen(),
    'create': (_) => const CreateEventScreen(),
    'explore': (_) => const ExploreScreen(),
    'search': (_) => const SearchScreen(),
  };
}
