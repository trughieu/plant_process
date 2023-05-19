import 'package:flutter/material.dart';

class Mission {
  String image;
  String type;
  String title;
  Image? img;

  Mission({required this.image, required this.type, required this.title});

  factory Mission.fromJson(Map<String, dynamic> data) {
    return Mission(
        image: data['img_mission'],
        type: data['type'],
        title: data['title']
    );
  }
}
