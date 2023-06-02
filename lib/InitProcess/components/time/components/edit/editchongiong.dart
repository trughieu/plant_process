import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:plant_process/progressbar.dart';

class editChonGiong extends StatefulWidget {
  static String routeName = '/editchongiong';
  final String id;
  const editChonGiong({Key? key, required this.id}) : super(key: key);

  @override
  State<editChonGiong> createState() => _editChonGiongState();
}

class _editChonGiongState extends State<editChonGiong> {




  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
