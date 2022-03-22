import 'package:medicine_scanner/model/scanned_medicine_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicineDatabase {
  static final MedicineDatabase instance = MedicineDatabase._init();

  static Database? _database;

  MedicineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('medicine.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute("CREATE TABLE $medTable( ${MedicineFields.id} $idType, ${MedicineFields.name} $textType, ${MedicineFields.scannedTime} $textType)");
  }

  Future<ScannedMedicineModel> create(ScannedMedicineModel medicine) async {
    final db = await instance.database;
    final id = await db. insert(medTable, medicine.toJson());
    return medicine.copy(id: id);
  }

  // Future<ScannedMedicineModel> readScannedMedicine(int id) async {
  //   final db = await instance.database;

  //   final maps = await db.query(
  //     medTable,
  //     columns: MedicineFields.values,
  //     where: '${MedicineFields.id} = ?',
  //     whereArgs: [id],
  //   );

  //   if (maps.isNotEmpty) {
  //     return ScannedMedicineModel.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID $id not found');
  //   }
  // }

  Future<List<ScannedMedicineModel>> readAllScannedMedicine() async {
    final db = await instance.database;

    final orderBy = '${MedicineFields.scannedTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $medTable ORDER BY $orderBy');

    final result = await db.query(medTable, orderBy: orderBy);

    return result.map((json) => ScannedMedicineModel.fromJson(json)).toList();
  }

  // Future<int> update(ScannedMedicineModel scannedMedicine) async {
  //   final db = await instance.database;

  //   return db.update(
  //     medTable,
  //     scannedMedicine.toJson(),
  //     where: '${MedicineFields.id} = ?',
  //     whereArgs: [scannedMedicine.id],
  //   );
  // }

  // Future<int> delete(int id) async {
  //   final db = await instance.database;

  //   return await db.delete(
  //     medTable,
  //     where: '${MedicineFields.id} = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
