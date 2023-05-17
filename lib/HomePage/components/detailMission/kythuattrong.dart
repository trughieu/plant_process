import 'package:flutter/material.dart';

import '../../../model/mission.dart';

class Ktt extends StatefulWidget {
  final Mission mission;

  const Ktt({Key? key, required this.mission}) : super(key: key);

  @override
  State<Ktt> createState() => _KttState();
}

class _KttState extends State<Ktt> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
