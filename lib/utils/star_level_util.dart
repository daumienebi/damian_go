import 'package:damian_go/utils/constants.dart';
import 'package:flutter/material.dart';

class StarLevelUtil{
  static String getStarLevelName(StarLevel starLevel){
    String starLevelText;
    switch(starLevel){
      case  StarLevel.Beginner:{
        starLevelText = 'Beginner';
      }
      break;
      case StarLevel.Explorer:
        starLevelText = 'Explorer';
        break;
      case StarLevel.Adventurer:
        starLevelText = 'Adventurer';
        break;
      case StarLevel.Discoverer:
        starLevelText = 'Discoverer';
        break;
      case StarLevel.Navigator:
        starLevelText = 'Navigator';
        break;
      case StarLevel.Pioneer:
        starLevelText = 'Pioneer';
        break;
      case StarLevel.Trekker:
        starLevelText = 'Trekker';
        break;
      case StarLevel.Master_Explorer:
        starLevelText = 'Master Explorer';
        break;
    }
    return starLevelText;
  }
}

/// The design for each star level
class StarLevelDesign{
  StarLevelDesign({required this.starLevel,required this.backgroundColor,required this.icon});
  static double iconSize = 40;
  // define the values
  final StarLevel starLevel;
  final Color backgroundColor;
  final Icon icon;

  static var beginnerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Beginner,
      backgroundColor: Colors.white,
      icon: Icon(Icons.star,color: Colors.red,size: iconSize)
  );
  static var explorerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Explorer,
      backgroundColor: Colors.blueGrey.shade700,
      icon: Icon(Icons.star,color: Colors.lightBlue,size: iconSize)
  );
  static var adventurerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Adventurer,
      backgroundColor: Colors.amber,
      icon: Icon(Icons.star,color: Colors.green,size: iconSize)
  );
  static var discovererStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Discoverer,
      backgroundColor: Colors.red.shade700,
      icon: Icon(Icons.star,color: Colors.amber,size: iconSize)
  );
  static var navigatorStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Navigator,
      backgroundColor: Colors.white,
      icon: Icon(Icons.star,color: Colors.indigo,size: iconSize)
  );
  static var pioneerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Pioneer,
      backgroundColor: Colors.yellow,
      icon: Icon(Icons.star,color: Colors.brown,size: iconSize)
  );
  static var trekkerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Trekker,
      backgroundColor: Colors.white,
      icon: Icon(Icons.star,color:Colors.pink,size: iconSize)
  );
  static var masterExplorerStarLevelDesign = StarLevelDesign(
      starLevel: StarLevel.Master_Explorer,
      backgroundColor: Colors.cyanAccent.shade200,
      icon: Icon(Icons.star,color: Colors.blueGrey.shade900,size: iconSize)
  );
  // Add one for Damian too

  static StarLevelDesign getStartLevelDesign(StarLevel starLevel){
    StarLevelDesign starLevelDesign;
    switch(starLevel){
      case StarLevel.Beginner :{
        starLevelDesign = beginnerStarLevelDesign;
      }
      break;
      case StarLevel.Explorer :{
        starLevelDesign = explorerStarLevelDesign;
      }
      break;
      case StarLevel.Adventurer :{
        starLevelDesign = adventurerStarLevelDesign;
      }
      break;
      case StarLevel.Discoverer :{
        starLevelDesign = discovererStarLevelDesign;
      }
      break;
      case StarLevel.Navigator :{
        starLevelDesign =  navigatorStarLevelDesign;
      }
      break;
      case StarLevel.Pioneer :{
        starLevelDesign = pioneerStarLevelDesign;
      }
      break;
      case StarLevel.Trekker :{
        starLevelDesign = trekkerStarLevelDesign;
      }
      break;
      case StarLevel.Master_Explorer :{
        starLevelDesign = masterExplorerStarLevelDesign;
      }
      break;
    }
    return starLevelDesign;
  }
}

class StarLevelCode{
  int get Beginner => 1;
  int get Explorer => 2;
  int get Adventurer => 3;
  int get Discoverer => 4;
  int get Navigator => 5;
  int get Pioneer => 6;
  int get Trekker => 7;
  int get Master_Explorer => 8;
}