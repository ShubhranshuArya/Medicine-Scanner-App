import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scanner/database/medicine_database.dart';
import 'package:medicine_scanner/model/medicine_model.dart';
import 'package:medicine_scanner/model/scanned_medicine_model.dart';

class GoogleSheetServices {
  late Dio _dio;
  String _parameter = 'medId';
  String _baseUrl =
      'https://script.google.com/macros/s/AKfycbxSAU4SdFNLf9f-g0zHaevektNp-UaYdU8Zg9a78mHytRnQx_BGjYGTl_nq3NI26T7E/exec';
  GoogleSheetServices() {
    _dio = Dio();
  }

  Future<MedicineModel?> getMedDataById(int id) async {
    try {
      Response response = await _dio.get(_baseUrl + '?$_parameter=$id');
      Iterable jsonString = response.data;
      List<MedicineModel> medicineModel =
          jsonString.map((e) => MedicineModel.fromJson(e)).toList();
      addLocalMedData(medicineModel[0]);
      return medicineModel[0];
    } on DioError catch (e) {
      print(e);
      // TODO: CHECK FOR INVALID QR CODE FROM THE SHEET
      return null;
    }
  }

  Future addLocalMedData(MedicineModel medicineModel) async {
    final medicine = ScannedMedicineModel(
      name: medicineModel.name,
      scannedTime: DateTime.now(),
    );
    await MedicineDatabase.instance.create(medicine);
  }
}
