import 'package:flutter/material.dart';

class SignedInDrawerScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Signed in drawer'),
      ),
      body: Text('Top user'),
    );
  }

}