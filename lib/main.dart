import 'package:flutter/material.dart';
import 'package:ticketmaster/screens/event_page.dart';
import 'package:ticketmaster/screens/home.dart';
import 'package:ticketmaster/screens/widget_setting.dart';

import 'navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: hexToColor("#23262F"),centerTitle: true,toolbarHeight: 50),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
