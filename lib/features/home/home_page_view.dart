import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Medi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xFF78C4A1), 
                ),
              ),
              TextSpan(
                text: 'Mate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black, 
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF1E8B8),
      ),
      backgroundColor: const Color(0xFFF1E8B8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            timeCard("Morning"),
            const SizedBox(height: 20),
            timeCard("Afternoon"),
            const SizedBox(height: 20),
            timeCard("Evening"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: const Offset(0, -40),
              child: SizedBox(
                width: 70, 
                height: 70, 
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO: Add action for the help button
                  },
                  backgroundColor: const Color(0xFF78C4A1),
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Color(0xFF78C4A1), 
                      width: 2, 
                    ),
                  ), 
                  child: const Icon(Icons.help_outline, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 90, 
              height: 90,
              child: FloatingActionButton(
                onPressed: () {
                  // TODO: Add action for the microphone button
                },
                backgroundColor: const Color(0xFF78C4A1),
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Color(0xFF78C4A1), 
                    width: 2, 
                  ),
                ), 
                child: const Icon(Icons.mic, color: Colors.black),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -40), 
              child: SizedBox(
                width: 70, 
                height: 70, 
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO: Add action for the add button
                  },
                  backgroundColor: const Color(0xFF78C4A1),
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Color(0xFF78C4A1), 
                      width: 2, 
                    ),
                  ), 
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeCard(String title) {
    return Card(
      color: const Color(0xFFF1E8B8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFF78C4A1), width: 2),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 165,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF78C4A1),
            ),
          ),
        ),
      ),
    );
  }
}
