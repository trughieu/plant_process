import 'dart:convert';

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.id;
    data['img_av'] = this.img_av;
    data['name']=this.name;
    return data;
  }
  factory Plants_model.fromJson(Map<String, dynamic> item) {
    return Plants_model(
      id: item['_id'],
      name: item['name'],
      img_av: item['img_av'],
      originate: item['originate'],
      process: item['process'],
    );
  }
  String Json() => json.encode(toJson());
  factory Plants_model.from(String source)=> Plants_model.fromJson(json.decode(source));
}
