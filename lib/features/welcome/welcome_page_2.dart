import 'package:flutter/material.dart';
import 'package:medi_mate/resources/screen_util.dart';

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
             SizedBox(
              height: ScreenUtils.w2SizedBox(context),
            ),
            Image.asset(
              'assets/Ambulance-Driver.png',
            ),
          ],
        )),
        Positioned(
            child: Container(
          height: ScreenUtils.w2ContHeight(context),
          margin: EdgeInsets.symmetric(vertical: ScreenUtils.w2MarginVert(context), horizontal: ScreenUtils.w2MarginHorz(context)),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(ScreenUtils.w2Padding(context)),
          child: const Text("Alerts",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center),
        )),
        Positioned(
            child: Container(
          height: ScreenUtils.w2Pos(context),
          margin: EdgeInsets.symmetric(vertical: ScreenUtils.w2MarginVert(context), horizontal: ScreenUtils.w2MarginHorz(context)),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(ScreenUtils.w2Padding2(context)),
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
