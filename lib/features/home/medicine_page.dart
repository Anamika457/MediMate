import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_mate/database/database.dart';
import 'package:medi_mate/models/medicine.dart';

class MedicinePage extends StatefulWidget {
  final Frequency timing;

  const MedicinePage({Key? key, required this.timing}) : super(key: key);

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  bool isLoading = false;
  late Map<String, List<Medicine>> medicinesList = {};
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    refreshMedicines();
  }

  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path; // Return the image path
  }

  void refreshMedicines() async {
    setState(() => isLoading = true);

    final allMedicine = await MedicineDatabase.instance.readAllMedicine();

    medicinesList = {};
    for (Medicine note in allMedicine) {
      if (!medicinesList.containsKey(note.timing)) {
        medicinesList[note.timing] = []; 
      }
       medicinesList[note.timing]!.add(note); 
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: medicinesList[widget.timing.timing]?.length ?? 0,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                Medicine medicine = medicinesList[widget.timing.timing]![index];
                return cardFunc(medicine);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(56.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentPageIndex > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text(
                    'Previous',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentPageIndex < (medicinesList[widget.timing.timing]?.length ?? 0) - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey[900],
      floatingActionButton: FloatingActionButton(
  onPressed: () async {
    TextEditingController nameController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    String? photoPath; // Declare photoPath here

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Medicine Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter medicine name...',
                  ),
                ),
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter duration (in days)...',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextButton(
                  onPressed: () async {
                    // Pick the image and set the path
                    String? pickedPath = await _pickImage();
                    if (pickedPath != null) {
                      photoPath = pickedPath; // Store the picked path
                    }
                  },
                  child: const Text('Pick Image'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && durationController.text.isNotEmpty) {
                  // Create a new Medicine object with the picked image path
                  Medicine newMedicine = Medicine(
                    medicineName: nameController.text,
                    duration: durationController.text,
                    timing: widget.timing.timing,
                    photo: photoPath ?? '', // Use the picked photo path or an empty string
                  );
                  await MedicineDatabase.instance.createMedicine(newMedicine);
                  refreshMedicines(); // Refresh the list
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all fields.")),
                  );
                }
              },
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  },
  backgroundColor: Colors.white,
  child: const Icon(Icons.add),
)

        );}}


  Widget cardFunc(Medicine medicine) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: const BorderSide(color: Colors.black, width: 5.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 350,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                medicine.medicineName,
                style: const TextStyle(
                  fontSize: 27,
                ),
                textAlign: TextAlign.center,
              ),
              if (medicine.photo.isNotEmpty)
                Image.file(File(medicine.photo), height: 150, width: 150),
            ],
          ),
        ),
      ),
    );
  }

