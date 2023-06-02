import 'package:flutter/material.dart';
import 'package:plant_process/model/plant_model.dart';
import 'package:plant_process/model/process.dart';
import 'package:plant_process/tip_plant/components/plants.dart';

class PlantProvider extends ChangeNotifier {
  String _id = '';

  String get id => _id;
  String _idLoaiCay = '';

  String get idLoaiCay => _idLoaiCay;

  void setId(String id) {
    _id = id;
    notifyListeners();
  }
  void setIdLoaiCay(String idLoaiCay){
    _idLoaiCay=idLoaiCay;
    notifyListeners();
  }
}
