import 'package:flutter/material.dart';

class Clout extends StatelessWidget {
  final int followers;
  final int following;

  const Clout({
    Key? key,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            '${following.toString()} following',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 5),
        TextButton(
          onPressed: () {},
          child: Text(
            '${followers.toString()} followers',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}