import 'package:dbms_app/home/ui/allotments.dart';
import 'package:flutter/material.dart';

import '../ui/admin_home.dart';
import '../ui/homescreen1.dart';
import '../ui/profile_screen.dart';

const String homePageStudent = 'home';
const String profilePage = 'profile';
const String homePageAdmin = 'admin_home';
const String allotmentsPage = 'allotments';
final homeNavigatorKey = GlobalKey<NavigatorState>();

void login() {}

Route<dynamic> homeRoutes(RouteSettings settings) {
  switch (settings.name) {
    case homePageStudent:
      return MaterialPageRoute(builder: (context) => const HomeScreen1());
    case profilePage:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());
    case homePageAdmin:
      return MaterialPageRoute(builder: (context) => const AdminHome());
    case allotmentsPage:
      return MaterialPageRoute(builder: (context) => const Allotments());
    default:
      throw ('this route name does not exist');
  }
}
