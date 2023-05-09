import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/plant_model.dart';
import '../../model/utilities.dart';

//
// class Product_plant extends StatelessWidget {
//   Product_plant({Key? key}) : super(key: key);

class Product_plant extends StatefulWidget {
  Product_plant({Key? key}) : super(key: key);

  @override
  State<Product_plant> createState() => _Product_plantState();
}

class _Product_plantState extends State<Product_plant> {
  String uri = Utilities.url;
  List<Plants_model> plants = [];
  int selectedIndex = -1;
  String? selectedProductId;

  void getProduct() async {
    final response = await http.get(Uri.parse('$uri/api/plant'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      var plant = body['plant'];
      for (var p in plant) {
        setState(() {
          plants.add(Plants_model.fromJson(p as Map<String, dynamic>));
        });
        for (int i = 0; i < plants.length; i++) {
          plants[i].img = Image.network('$uri/${plants[i].img_av}');
        }
      }
    } else {
      print("ssss");
    }
  }

  void selectItem(int index) {
    setState(() {
      if (selectedIndex == index) {
        // if the same item is selected again, deselect it
        selectedIndex = -1;
        selectedProductId = null;
      } else {
        // select a different item
        selectedIndex = index;
        selectedProductId = plants[index].id;
      }
    });
  }

// const ProductPopular({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: plants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  return ProductItem(
                      plant: plants[index],
                      isSelected: index == selectedIndex,
                      onTap: () {
                        selectItem(index);
                      });
                }),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (selectedProductId != null) {}
              print(selectedProductId);
              // handle button click event
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Plants_model plant;
  final bool isSelected;
  final VoidCallback onTap;

  ProductItem(
      {Key? key,
      required this.plant,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.yellow : Colors.transparent,
                width: 3,
              ),
            ),
            child: SizedBox(
              height: 80,
              width: 80,
              child: plant.img_av == null
                  ? const CircularProgressIndicator()
                  : plant.img!,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            plant.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}