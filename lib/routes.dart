import 'package:flutter/cupertino.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/tip_plant/components/follow_mission.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';

import 'tip_plant/components/plants.dart';


final Map<String, WidgetBuilder> routes={
  HomePage.routeName:(context)=>HomePage(),
  Plant.routeName:(context)=>Plant(),
  Select_plant.routeName:(context)=>Select_plant(),
  Follow_mission.routeName:(context)=>Follow_mission(),

};