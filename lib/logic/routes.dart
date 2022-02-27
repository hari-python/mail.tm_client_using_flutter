// 1.
import 'package:flutter/material.dart';
import 'package:mailtm_client/screens/apphome.dart';
import 'package:mailtm_client/screens/viewmail.dart';

class RouteGenerator {
// 2.
  static const String homePage = '/';
  static const String viewMail = '/mail';
// 3.
  RouteGenerator._();
// 3.
  static Route<dynamic> generateRoute(RouteSettings settings,) {
//4.
    switch (settings.name) {
      case homePage:
// .5
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case viewMail:
        return MaterialPageRoute(
          builder: (_) =>  MailScreen(details:settings.arguments),
        );
      default:
        throw const FormatException("Route not found");
    }
  }
}
