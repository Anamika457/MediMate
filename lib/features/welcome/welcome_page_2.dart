import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _WelcomePageTwo();
}

class _WelcomePageTwo extends State<PageTwo> {
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
              height: 120,
            ),
            Image.asset(
              'assets/Ambulance-Driver.png',
            ),
          ],
        )),
        Positioned(
            child: Container(
          height: 550,
          margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 35.0),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(45.0),
          child: const Text("Alerts & Notifications",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center),
        )),
        Positioned(
            child: Container(
          height: 600,
          margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 35.0),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(20.0),
          child: const Text(
              "We’ll help you stay on track with your medications.",
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