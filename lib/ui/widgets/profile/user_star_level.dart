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
  late Color _startColor;
  late Color _endColor;
  bool _isForward = true;
  late Timer timer;
  late StarLevelDesign starLevelDesign;

  @override
  void initState() {
    super.initState();
    starLevelDesign = StarLevelDesign
        .getStartLevelDesign(widget.starLevel);
    // initialize the start and end colors
    _startColor = starLevelDesign.startColor;
    _endColor = starLevelDesign.endColor;
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _startColor = starLevelDesign.startColor;
        _endColor = starLevelDesign.endColor;
        if (_isForward) {
          _startColor = _endColor;
          _endColor = Colors.blue;
        } else {
          _startColor = _endColor;
          _endColor = Colors.red;
        }
        _isForward = !_isForward;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      //width: 200,
      margin: EdgeInsets.all(5),
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_startColor, _endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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