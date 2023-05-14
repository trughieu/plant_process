import 'dart:convert';

import 'package:flutter/material.dart';

class Process {
  String? id_plant;
  Image? img;
  String? name;
  String? image;
  String? description;

  Process({required this.id_plant});

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=<String,dynamic>{};
    data['id_plant']=this.id_plant;
    return data;
  }
  factory Process.fromJson(Map<String, dynamic> item) {
    return Process(
      id_plant: item['id_plant'],
    );

  }
  String Json() => json.encode(toJson());
  factory Process.from(String source)=> Process.fromJson(json.decode(source));

}
