import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
         
            const Text(
              'Command Help',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF78C4A1),
              ),
            ),
            const SizedBox(height: 20), 
            timeCard(" 'Morning'- Redirects to meds to be had in the morning."),
            const SizedBox(height: 20),
            timeCard("'Afternoon'- Redirects to meds to be had in the afternoon"),
            const SizedBox(height: 20),
            timeCard("'Evening'- Redirects to meds to be had in the night."),
          ],
        ),
      ),
    );
  }
}

Widget timeCard(String title) {
  final commandRegex = RegExp(r"'(.*?)'");
  final matches = commandRegex.allMatches(title);
  
  List<TextSpan> textSpans = [];
  int lastMatchEnd = 0;

  for (var match in matches) {
    if (match.start > lastMatchEnd) {
      textSpans.add(TextSpan(
        text: title.substring(lastMatchEnd, match.start),
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF78C4A1), 
        ),
      ));
    }

    textSpans.add(TextSpan(
      text: match.group(0), 
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black, 
      ),
    ));

    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < title.length) {
    textSpans.add(TextSpan(
      text: title.substring(lastMatchEnd),
      style: const TextStyle(
        fontSize: 20,
        color: Color(0xFF78C4A1), 
      ),
    ));
  }

  return Card(
    color: const Color(0xFFF1E8B8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(color: Color(0xFF78C4A1), width: 2),
    ),
    child: SizedBox(
      width: double.infinity,
      height: 165,
      child: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Center(
          child: RichText(
            text: TextSpan(children: textSpans),
            textAlign: TextAlign.center, 
          ),
        ),
      ),
    ),
  );
}
