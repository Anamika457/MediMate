import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:medi_mate/features/welcome/welcome_page_2.dart';
import 'package:medi_mate/features/welcome/welcome_page_3.dart';

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
                      const SizedBox(
                        height: 80,
                      ),
                      Image.asset(
                        'assets/Doctor.png',
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 35.0),
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(5.0),
                        child: const Text("Hey there!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34.0,
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 35.0),
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(5.0),
                        child: const Text(
                            "Welcome to MediMate, your personalized health companion designed to help you manage your well-being with ease.",
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
              bottom: 150,
              left: 0,
              right: 0,
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
              top: 0,
              left: 0,
              child: Image.asset('assets/path.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset('assets/path_bottom.png'),
            )
          ],
        ),
      ),
    );
  }
}
