import 'package:flutter/material.dart';

class ZoneCount extends StatelessWidget {
  final int count;

  const ZoneCount({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.place),
        SizedBox(width: 4),
        Text('${count.toString()} zones added',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}