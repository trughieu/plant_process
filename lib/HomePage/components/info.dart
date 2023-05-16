import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_process/model/plant_provider.dart';
import 'package:plant_process/tip_plant/components/plants.dart';
import '../../model/process.dart';
import '../../model/utilities.dart';
import 'package:bson/bson.dart';
import 'package:provider/provider.dart';

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
            print("plant ne$plant");
            // Build the complete URL to the image
            var imgUri = Uri.parse(uri).resolve(plant['img_av']).toString();
            var name = plant['name'].toString();
            var des = plant['description'].toString();
            print("img" + imgUri);
            // Load the image and store it in the process object
            p.image = imgUri.toString();
            p.name = name;
            p.description = des;

            print("ađa" + name);
            print("ađa" + des);

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

  ProcessItem({super.key, required this.process});

  // const CategoriesItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(process.img);
    return GestureDetector(
      onTap: () {
        if (process.id_plant != null) {
          Provider.of<PlantProvider>(context, listen: false)
              .setId(process.id_plant!);
          print(process.id_plant);
          print("des${process.description}");
          print("asasa${process.img.toString()}");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Plant(
                name: process.name.toString(), img: process.image.toString(),des: process.description.toString(),),
          ),
        );
      },
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.yellow, width: 3)),
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(5),
              child: Image(
                image: NetworkImage(process.image.toString()),
              )
              // Image.network('http://172.16.32.55:8000/${category.image}'),
              )
        ],
      ),
    );
  }
}
