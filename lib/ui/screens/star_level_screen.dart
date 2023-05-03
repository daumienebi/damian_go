import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { Facebook, Twitter, Instagram, Whatsapp,Enlace}
class StarLevelScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Star levels'),
      ),

      body: starLevels(),
    );
  }

  Widget starLevels(){
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.star,color: Colors.red,size: 40,),
          title: Text('Beginner'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.blue,size: 40,),
          title: Text('Explorer'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.green,size: 40,),
          title: Text('Adventurer'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.yellow,size: 40,),
          title: Text('Discoverer'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.black,size: 40,),
          title: Text('Navigator'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.brown,size: 40,),
          title: Text('Pioneer'),
        ),ListTile(
          leading: Icon(Icons.star,color: Colors.pink,size: 40,),
          title: Text('Trekker'),
        ),
        ListTile(
          leading: Icon(Icons.star,color: Colors.teal,size: 40,),
          title: Text('Master Explorer'),
        )
      ],
    );
  }

}