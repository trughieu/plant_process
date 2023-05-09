import 'package:flutter/material.dart';

class Process {
  String? id_plant;
  Image? img;

  Process({required this.id_plant});

  factory Process.fromJson(Map<String, dynamic> item) {
    return Process(
      id_plant: item['id_plant'],
    );
  }
}
