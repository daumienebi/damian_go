import 'package:damian_go/view/components/components.dart';
import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/star_level_util.dart';
import 'package:flutter/material.dart';

class StarLevelScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Star levels'),
      ),
      body: starLevels(context),
    );
  }

  Widget starLevels(BuildContext context){
    return ListView(
      padding: EdgeInsets.all(5),
      children: [
        LevelListTile(
          description: 'From 1 to 50 zones',
          starLevel: StarLevel.Beginner,
          starLevelDesign: StarLevelDesign.beginnerStarLevelDesign,
        ),
        LevelListTile(
            description: 'From 51 to 100 zones',
            starLevel: StarLevel.Explorer,
            starLevelDesign: StarLevelDesign.explorerStarLevelDesign
        ),
        LevelListTile(
            description: 'From 101 to 150 zones',
            starLevel: StarLevel.Adventurer,
            starLevelDesign: StarLevelDesign.adventurerStarLevelDesign
        ),
        LevelListTile(
            description: 'From 151 to 200 zones',
            starLevel: StarLevel.Discoverer,
            starLevelDesign: StarLevelDesign.discovererStarLevelDesign
        ),
        LevelListTile(
            description: 'From 201 to 250 zones',
            starLevel: StarLevel.Navigator,
            starLevelDesign: StarLevelDesign.navigatorStarLevelDesign
        ),
        LevelListTile(
            description: 'From 251 to 300 zones',
            starLevel: StarLevel.Pioneer,
            starLevelDesign: StarLevelDesign.pioneerStarLevelDesign
        ),
        LevelListTile(
            description: 'From 301 to 350 zones',
            starLevel: StarLevel.Trekker,
            starLevelDesign: StarLevelDesign.trekkerStarLevelDesign
        ),
        LevelListTile(
            description: 'From 351 to 400 zones',
            starLevel: StarLevel.Master_Explorer,
            starLevelDesign: StarLevelDesign.masterExplorerStarLevelDesign
        )
      ]
    );
  }
}

class LevelListTile extends StatelessWidget {
  final String description;
  final StarLevel starLevel;
  final StarLevelDesign starLevelDesign;
  const LevelListTile({
    Key? key, required this.description, required this.starLevel, required this.starLevelDesign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: starLevelDesign.icon,
      subtitle: Text(description,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w500)),
      trailing: InkWell(
        child: Icon(Icons.info_outline),
        onTap:(){
          showDialog(
              barrierColor: Colors.black26,
              context: context,
              builder: (context){
                return Container(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    content: SizedBox(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Insert the star level description here in few words, not too much text'),
                            UserStarLevel(starLevel: starLevel),
                          ]
                      ),
                    ),
                  ),
                );
              }
          );
        },
      ),
      title: Text('${StarLevelUtil.getStarLevelName(starLevel)}'),
    );
  }
}