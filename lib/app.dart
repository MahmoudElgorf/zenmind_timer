import 'package:flutter/material.dart';
import 'pages/timer_page.dart';

class ZenMindApp extends StatelessWidget {
  const ZenMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const TimerPage(),
    );
  }
}