import 'package:flutter/material.dart';
import 'package:mailtm_client/screens/apphome.dart';
// import 'API/Accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}