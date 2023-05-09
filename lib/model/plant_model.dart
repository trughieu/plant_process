import 'package:flutter/material.dart';

class Plants_model {
  String? originate;
  String name;
  String img_av;
  String? process;
  Image? img;
  String id;

  Plants_model(
      {required this.id,
      required this.img_av,
      required this.name,
      this.process,
      this.originate});

  factory Plants_model.fromJson(Map<String, dynamic> item) {
    return Plants_model(
      id: item['_id'],
      name: item['name'],
      img_av: item['img_av'],
      originate: item['originate'],
      process: item['process'],
    );
  }
}
