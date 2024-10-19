import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _WelcomePageThree();
}

class _WelcomePageThree extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffedeec9),
          body: Stack(children: [
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 90,
            ),
            Image.asset(
              'assets/Nurse.png',
              width: double.infinity,
            ),
          ],
        )),
        Positioned(
            child: Container(
          height: 550,
          margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 35.0),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(50.0),
          child: const Text("Voice Commands",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center),
        )),
        //
        Positioned(
            child: Container(
          height: 650,
          margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 35.0),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(50.0),
          child: const Text(
              "Use simple Voice Commands to navigate MediMate hands-free.",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 26.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center),
        )),
      ])),
    );
  }
}