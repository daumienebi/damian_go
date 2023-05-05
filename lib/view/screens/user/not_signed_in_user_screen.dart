import 'package:flutter/material.dart';

class NotSignedInUserScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Not Signed in drawer'),
      ),
      body: Center(child: Text('Top user')),
    );
  }

}