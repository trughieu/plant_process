import 'package:flutter/material.dart';
import 'package:plant_process/provider/progressbar.dart';
import 'package:provider/provider.dart';

class CustomProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, _) {
        return LinearProgressIndicator(
          value: progressProvider.progress,
          minHeight: 10, // Độ cao của thanh tiến trình
          backgroundColor: Colors.grey, // Màu nền của thanh tiến trình
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Màu của thanh tiến trình
        );
      },
    );
  }
}
