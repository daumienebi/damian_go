import 'package:flutter/material.dart';

class TopUsersScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Top users ⭐'),
      ),
      body: Center(child: Text('Top users',style: TextStyle(fontSize: 20),)),
    );
  }

}