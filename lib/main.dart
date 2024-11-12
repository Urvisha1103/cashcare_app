// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:cashcare/create_account.dart';
import 'package:cashcare/dashboard.dart';
import 'package:cashcare/login_screen.dart';
import 'package:cashcare/splash_screen.dart';
import 'package:flutter/material.dart';
import 'animation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
