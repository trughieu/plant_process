import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/classificationProcess/components/body.dart';
import 'package:plant_process/InitProcess/components/time/timePlant.dart';

class ClassificationProcesssPage extends StatelessWidget {
  static String routeName = '/classificationProcess';

  ClassificationProcesssPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
        title: const Text(
          "Khởi tạo quy trình",
          style: TextStyle(
              fontFamily: 'Inter-Medium-500.ttf',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      body:Container(
        child: Column(
          children: [
            const Body(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, TimePlant.routeName);
                    print("da click");
                // if (selectedProductId != null) {
                //   Navigator.pushNamed(context, ClassificationProcesssPage.routeName);
                // }
                // print(selectedProductId);

                // handle button click event
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
