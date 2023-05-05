import 'dart:async';
import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/star_level_util.dart';
import 'package:flutter/material.dart';

class UserStarLevel extends StatefulWidget {
  const UserStarLevel({super.key, required this.starLevel});

  @override
  _UserStarLevelState createState() => _UserStarLevelState();

  final StarLevel starLevel;
}

class _UserStarLevelState extends State<UserStarLevel> {
  late StarLevelDesign starLevelDesign;
  @override
  void initState() {
    super.initState();
    starLevelDesign = StarLevelDesign
        .getStartLevelDesign(widget.starLevel);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        //color: starLevelDesign.backgroundColor
        color: Colors.cyan.shade800
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              '${StarLevelUtil.getStarLevelName(widget.starLevel)}',
              style: TextStyle(fontSize: 17,color: Colors.white)
          ),
          starLevelDesign.icon,
        ],
      ),
    );
  }
}