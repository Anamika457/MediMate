const String tableFrequency = 'frequency';
const String tableMedicine = 'medicine';

class FrequencyFields {
  static final List<String> values = [id, timing];

  static const String id = '_id';
  static const String timing = 'timing';
}

class MedicineFields {
  static final List<String> values = [
    id,
    medicineName,
    timing,
    duration,
    photo
  ];

  static const String id = '_id';
  static const String medicineName = 'medicine_name';
  static const String timing = 'timing';
  static const String duration = 'duration';
  static const String photo = 'photo';
}

class Frequency {
  final int? id;
  final String timing;

  Frequency({
    this.id,
    required this.timing,
  });

  Frequency copy({
    int? id,
    String? timing,
  }) =>
      Frequency(
        id: id ?? this.id,
        timing: timing ?? this.timing,
      );

  static Frequency fromJson(Map<String, dynamic> json) => Frequency(
    id: json[FrequencyFields.id],
    timing: json[FrequencyFields.timing],
  );

  Map<String, dynamic> toJson() => {
    FrequencyFields.id: id,
    FrequencyFields.timing: timing,
  };
}

class Medicine {
  final int? id;
  final String medicineName;
  final String duration;
  final String timing;
  final String photo;

  Medicine({
    this.id,
    required this.medicineName,
    required this.duration,
    required this.timing,
    required this.photo,

  });

  Medicine copy({
    int? id,
    String? medicineName,
    String? duration,
    String? timing,
    String? photo,

  }) =>
      Medicine(
        id: id ?? this.id,
        medicineName: medicineName ?? this.medicineName,
        duration: duration ?? this.duration,
        timing: timing ?? this.timing,
        photo: photo ?? this.photo,
      );

  static Medicine fromJson(Map<String, dynamic> json) => Medicine(
    id: json[MedicineFields.id],
    medicineName: json[MedicineFields.medicineName],
    duration: json[MedicineFields.duration],
    timing: json[MedicineFields.timing],
    photo: json[MedicineFields.photo],
  );

  Map<String, dynamic> toJson() => {
    MedicineFields.id: id,
    MedicineFields.medicineName: medicineName,
    MedicineFields.duration: duration,
    MedicineFields.timing: timing,
    MedicineFields.photo: photo,

  };
}