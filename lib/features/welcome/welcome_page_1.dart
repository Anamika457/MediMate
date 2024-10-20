import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:medi_mate/features/welcome/welcome_page_2.dart';
import 'package:medi_mate/features/welcome/welcome_page_3.dart';
import 'package:medi_mate/resources/screen_util.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _WelcomePageOne();
}

class _WelcomePageOne extends State<PageOne> {
  int _currentPage = 0;
  final _totalPages = 3;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffedeec9),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenUtils.w1SizedBox(context),
                      ),
                      Image.asset(
                        'assets/Doctor.png',
                      ),
                      Container(
                        margin:  EdgeInsets.symmetric(
                        vertical: ScreenUtils.w1MarginVert(context), horizontal: ScreenUtils.w1MarginHorz(context)),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.all(ScreenUtils.w1Padding(context)),
                        child: const Text("Hey there!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0,
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                        vertical: ScreenUtils.w1MarginVert(context), horizontal: ScreenUtils.w1MarginHorz(context)),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.all(ScreenUtils.w1Padding(context)),
                        child: const Text(
                            "Welcome to MediMate, your easy health companion.",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 26.0,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
                const PageTwo(),
                const PageThree()
              ],
            ),
            Positioned(
              bottom: ScreenUtils.w1Pos(context),
              left: ScreenUtils.w1PosW(context),
              right:ScreenUtils.w1PosW(context),
              child: Center(
                child: DotsIndicator(
                  dotsCount: _totalPages,
                  position: _currentPage,
                  decorator: const DotsDecorator(
                    color: Color(0xFFCCCCCC), 
                    activeColor: Color(0xff77bfa3), 
                  ),
                ),
              ),
            ),
            Positioned(
              top: ScreenUtils.w1MarginVert(context),
          left: ScreenUtils.w1PosW(context),
              child: Image.asset('assets/path.png'),
            ),     
          ],
        ),
      ),
    );
  }
}
