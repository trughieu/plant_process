import 'package:flutter/cupertino.dart';
import 'package:plant_process/HomePage/homepage.dart';

import 'tip_plant/components/plants.dart';


final Map<String, WidgetBuilder> routes={
  HomePage.routeName:(context)=>HomePage(),
  Plant.routeName:(context)=>Plant(),
};