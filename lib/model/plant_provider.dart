import 'package:flutter/material.dart';
import 'package:plant_process/model/plant_model.dart';
import 'package:plant_process/model/process.dart';
import 'package:plant_process/tip_plant/components/plants.dart';

class PlantProvider extends ChangeNotifier {

  String _id = '';
  String get id => _id;

  void setId(String id) {
    _id = id;
    notifyListeners();
  }
}
