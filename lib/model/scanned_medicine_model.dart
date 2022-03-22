final String medTable = 'medicine';

// This is for the column name in the fields of the db
class MedicineFields {
  static final List<String> values = [
    /// Add all fields
    id, name, scannedTime
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String scannedTime = 'scannedTime';
}

class ScannedMedicineModel {
  int? id;
  String? name;
  DateTime? scannedTime;

  ScannedMedicineModel({
    this.id,
    this.name,
    this.scannedTime,
  });

  ScannedMedicineModel copy({
    int? id,
    String? name,
    DateTime? scannedTime,
  }) =>
      ScannedMedicineModel(
        id: this.id,
        name: this.name,
        scannedTime: this.scannedTime,
      );

  Map<String, dynamic> toJson() => {
        MedicineFields.id: id,
        MedicineFields.name: name,
        MedicineFields.scannedTime: scannedTime!.toIso8601String(),
      };

  static ScannedMedicineModel fromJson(Map<String, dynamic> json) =>
      ScannedMedicineModel(
        id: json[MedicineFields.id] as int,
        name: json[MedicineFields.name] as String,
        scannedTime: DateTime.parse( json[MedicineFields.scannedTime] as String),
      );
}
