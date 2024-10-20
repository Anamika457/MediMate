import 'package:flutter/material.dart';
import 'package:medi_mate/database/database.dart';
import 'package:medi_mate/features/help/help.dart';
import 'package:medi_mate/features/home/medicine_page.dart';
import 'package:medi_mate/models/medicine.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late List<Frequency> frequencyList = []; 
  List<Widget> sliverLists = []; 
  final TextEditingController _controller = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    refreshFrequency();
  }

  Future refreshFrequency() async {
    setState(() => isLoading = true); 

    final allFrequency = await MedicineDatabase.instance.readAllFrequencies();
    
    frequencyList = allFrequency.where((freq) => freq.timing != 'Frequency Addition').toList();

    setState(() => isLoading = false); 
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1E8B8),
                      border: Border.all(color: const Color(0xFF78C4A1), width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center( // Center the content inside the container
                      child: ListTile(
                        title: Text(
                          frequencyList.length > index ? frequencyList[index].timing : '',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center, // Center align the text
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MedicinePage(timing: frequencyList[index])),
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: frequencyList.length,
              ),
            ),
            ...sliverLists,
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
                  heroTag: 'help',
                  onPressed: () {
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()),
              );
                  },
                  backgroundColor: const Color(0xFF78C4A1),
                  shape: const CircleBorder(
                    side: BorderSide(color: Color(0xFF78C4A1), width: 2),
                  ), 
                  child: const Icon(Icons.help_outline, color: Colors.black, size: 30),
                ),
              ),
            ),
            SizedBox(
              width: 90, 
              height: 90,
              child: FloatingActionButton(
                heroTag: 'voice',
                onPressed: () {
                  // TODO: Add action for the microphone button
                },
                backgroundColor: const Color(0xFF78C4A1),
                shape: const CircleBorder(
                  side: BorderSide(color: Color(0xFF78C4A1), width: 2),
                ), 
                child: const Icon(Icons.mic, color: Colors.black, size: 40),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -40), 
              child: SizedBox(
                width: 70, 
                height: 70, 
                child: FloatingActionButton(
                  heroTag: 'add',
                  onPressed: () {
                    createList();
                  },
                  backgroundColor: const Color(0xFF78C4A1),
                  shape: const CircleBorder(
                    side: BorderSide(color: Color(0xFF78C4A1), width: 2),
                  ), 
                  child: const Icon(Icons.add, color: Colors.black, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createList() {
    sliverLists.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
      child: TextField(
        controller: _controller,
        maxLength: 30,
        decoration: const InputDecoration(
          labelText: 'Type in a frequency name.....',
          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ),
    TextButton(
      onPressed: () async {
        String newtiming = _controller.text.trim();
        if (newtiming.isNotEmpty) {
          await MedicineDatabase.instance.createFrequency(Frequency(timing: newtiming));
          await refreshFrequency();
          _controller.clear(); 
          setState(() {}); 
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter a frequency name.")),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF78C4A1)),
        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF1E8B8)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 18),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: const Text("OK"),
    ),
  ],
)
            );
          },
          childCount: 1,
        ),
      ),
    );
    setState(() {});
  }
}
