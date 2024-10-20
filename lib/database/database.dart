// ignore_for_file: depend_on_referenced_packages

import 'package:medi_mate/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MedicineDatabase {
  MedicineDatabase._privateConstructor();
  static final MedicineDatabase instance = MedicineDatabase._privateConstructor();

  static Database? _database;

  factory MedicineDatabase() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'medimate.db');

    return await openDatabase(
        path, version: 2, onCreate: _createDb, onUpgrade: _upgradeDb);
  }

  Future<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE frequency ADD COLUMN name TEXT NOT NULL');
    }
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableFrequency (
        ${FrequencyFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${FrequencyFields.timing} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableMedicine (
        ${MedicineFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MedicineFields.medicineName} TEXT NOT NULL,
        ${MedicineFields.duration} TEXT NOT NULL ,
        ${MedicineFields.timing} TEXT NOT NULL,
        ${MedicineFields.photo} TEXT NOT NULL,
        FOREIGN KEY (${MedicineFields.timing}) REFERENCES $tableFrequency(${FrequencyFields.id})
      )
    ''');
  }

  Future<Frequency> createFrequency(Frequency frequency) async {
    final db = await instance.database;
    final id = await db.insert(tableFrequency, frequency.toJson());
    return frequency.copy(id: id);
  }

  Future<List<Frequency>> readAllFrequencies() async {
    final db = await instance.database;
    final result = await db.query(tableFrequency);
    return result.map((json) => Frequency.fromJson(json)).toList();
  }

  Future<Medicine> createMedicine(Medicine medicine) async {
    final db = await instance.database;
    final id = await db.insert(tableMedicine, medicine.toJson());
    return medicine.copy(id :id);
  }

  Future<List<Medicine>> readAllMedicine() async {
  final db = await instance.database;
  final result = await db.query(tableMedicine);

  // Debug: print the raw result
  print('Raw medicine data: $result');

  return result.map((json) {
    // Log a warning if id or duration is null
    if (json[MedicineFields.id] == null) {
      print('Warning: Found a medicine entry with null id: $json');
      return null; // Skip this entry
    }
    
    if (json[MedicineFields.duration] == null) {
      print('Warning: Found a medicine entry with null duration: $json');
      return null; // Skip this entry
    }

    // Debug: Log the extracted values
    print('Extracted values - ID: ${json[MedicineFields.id]}, '
          'Medicine Name: ${json[MedicineFields.medicineName]}, '
          'Duration: ${json[MedicineFields.duration]}, '
          'Timing: ${json[MedicineFields.timing]}, '
          'Photo: ${json[MedicineFields.photo]}');

    return Medicine(
      id: json[MedicineFields.id] as int, // Cast to int
      medicineName: json[MedicineFields.medicineName] as String? ?? '', 
      duration: json[MedicineFields.duration] as String, 
      timing: json[MedicineFields.timing] as String? ?? '',
      photo: json[MedicineFields.photo] as String, 
    );
  }).whereType<Medicine>().toList(); 
}
}