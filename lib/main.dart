import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_mate/features/welcome/welcome_page_1.dart';
import 'package:medi_mate/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(426, 926), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
    return MaterialApp(
      title: 'MediMate App',
      theme: GlobalAppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home:const PageOne(),
    );
  },
    );
}}
