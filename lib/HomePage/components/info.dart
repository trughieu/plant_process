import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/process.dart';
import '../../model/utilities.dart';
import 'package:bson/bson.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String uri = Utilities.url;
  List<Process> process = [];

  void getProcess() async {
    final response = await http.get(Uri.parse('$uri/api/process'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      var processes = body['process'];
      // print(processes['id_plant']);
      for (var e in processes) {
        print(e['id_plant']);
      }

      // collection plant
      final plantResponse = await http.get(Uri.parse('$uri/api/plant'));
      if (plantResponse.statusCode == 200) {
        final plantBody = jsonDecode(plantResponse.body);
        var plants = plantBody['plant'];
        for (var e in plants) {
          print(e['_id']);
        }
        //Loop
        for (var pro in processes) {
          var p = Process.fromJson(pro);
          // find the img plant for this process
          var plant = plants.firstWhere((pl) => pl['_id'] == pro['id_plant'],
              orElse: () => null);
          if (plant != null) {
            // Build the complete URL to the image
            var imgUri = Uri.parse(uri).resolve(plant['img_av']).toString();
            print("img" + imgUri);
            // Load the image and store it in the process object
            p.img = Image.network(imgUri);
          }
          setState(() {
            // add vao list Process
            process.add(p);
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProcess();
  }

  @override
  Widget build(BuildContext context) {
    // final categories = Categories.init();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: process.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        ProcessItem(process: process[index]),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProcessItem extends StatelessWidget {
  Process process;

  ProcessItem({required this.process});

  // const CategoriesItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(process.toString());
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.yellow, width: 3)),
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(5),
        child: process.img == null ? CircularProgressIndicator() : process.img!
        // Image.network('http://172.16.32.55:8000/${category.image}'),
        );
  }
}
