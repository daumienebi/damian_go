import 'dart:async';
import 'package:flutter/material.dart';

class UserStarLevel extends StatefulWidget {
  @override
  _UserStarLevelState createState() => _UserStarLevelState();
}

class _UserStarLevelState extends State<UserStarLevel> {
  Color _startColor = Colors.blue;
  Color _endColor = Colors.red;
  bool _isForward = true;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: 200,
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
          Text('Master Explorer',style: TextStyle(fontSize: 17,color: Colors.white)),
          Icon(Icons.star,color: Colors.teal,size: 40,)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
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
}