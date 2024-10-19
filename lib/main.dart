import 'package:flutter/material.dart';
import 'package:medi_mate/features/welcome/welcome_page_1.dart';
import 'package:medi_mate/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediMate App',
      theme: GlobalAppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home:const PageOne(),
    );
  }
}