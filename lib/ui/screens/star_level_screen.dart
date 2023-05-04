import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/star_level_util.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

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
          description: 'Less than 50 zones',
          starLevel: StarLevel.Beginner,
          starLevelDesign: StarLevelDesign.beginnerStarLevelDesign,
        ),
        LevelListTile(
            description: 'Less than 100 zones',
            starLevel: StarLevel.Explorer,
            starLevelDesign: StarLevelDesign.explorerStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 150 zones',
            starLevel: StarLevel.Adventurer,
            starLevelDesign: StarLevelDesign.adventurerStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 200 zones',
            starLevel: StarLevel.Discoverer,
            starLevelDesign: StarLevelDesign.discovererStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 250 zones',
            starLevel: StarLevel.Navigator,
            starLevelDesign: StarLevelDesign.navigatorStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 300 zones',
            starLevel: StarLevel.Pioneer,
            starLevelDesign: StarLevelDesign.pioneerStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 350 zones',
            starLevel: StarLevel.Trekker,
            starLevelDesign: StarLevelDesign.trekkerStarLevelDesign
        ),
        LevelListTile(
            description: 'Less than 400 zones',
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
      subtitle: Text(description),
      trailing: InkWell(
        child: Icon(Icons.info_outline),
        onTap:(){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Container(
                    child: UserStarLevel(starLevel: starLevel),
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