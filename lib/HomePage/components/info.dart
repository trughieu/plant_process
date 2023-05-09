import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/process.dart';
import '../../model/utilities.dart';
import '../../tip_plant/components/plants.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String uri = Utilities.url;
  List<Process> process=[];
  void getProcess() async{
    final response=await http.get(Uri.parse('$uri/api/process'));
    if(response.statusCode==200){
      print(response.body);

    }
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
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesItem(category: categories[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  Categories category;

  CategoriesItem({required this.category});

  // const CategoriesItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(category.toString());
    return Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(5),
        child:
            category.image == null ? CircularProgressIndicator() : category.img!
        // Image.network('http://172.16.32.55:8000/${category.image}'),
        );
  }
}
