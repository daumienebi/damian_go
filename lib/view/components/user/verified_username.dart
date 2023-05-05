import 'package:flutter/material.dart';

class VerifiedUserName extends StatelessWidget {
  final String name;
  final bool isVerified;

  const VerifiedUserName({
    Key? key,
    required this.name,
    this.isVerified = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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