import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medi_mate/features/notifications/notifications.dart';
import 'package:medi_mate/features/welcome/welcome_page_1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
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
    return const MaterialApp(
      title: 'MediMate App',
      debugShowCheckedModeBanner: false,
      home:PageOne(),
    );
  },
    );
}}
