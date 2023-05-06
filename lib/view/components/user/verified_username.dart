import 'package:flutter/material.dart';

class VerifiedUserName extends StatelessWidget {
  final String name;
  final bool isVerified;
  final bool centered;

  const VerifiedUserName({
    Key? key,
    required this.name,
    this.isVerified = false,
    this.centered = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: centered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(width: 5),
        if (isVerified)
          Icon(
            Icons.check_circle,
            color: Colors.blue,
            size: 20,
          ),
      ],
    );
  }
}