import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scanner/model/medicine_model.dart';

class GoogleSheetServices {
  late Dio _dio;
  String _parameter = 'medId';
  String _baseUrl =
      'https://script.google.com/macros/s/AKfycbw9wF0DzpRDXY25NB-ea7MfgBR47yKwmc6ZgDeovc8D3bec9ZPnt2xWL_CO79zFGhav/exec';

  GoogleSheetServices() {
    _dio = Dio();
  }

  Future<MedicineModel?> getMedDataById(int id) async {
    try {
      Response response = await _dio.get(_baseUrl + '?$_parameter=$id');
      Iterable jsonString = response.data;
      List<MedicineModel> medicineModel =
          jsonString.map((e) => MedicineModel.fromJson(e)).toList();
      return medicineModel[0];
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }
}
