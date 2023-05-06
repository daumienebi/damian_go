import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/view/views.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('User Profile'),
        actions: [
          followUserButton()
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
            children: [
              profileWidget(context),
              moreUserDetails()
            ],
        ),
      ),
    );
  }

  Widget followUserButton(){
    return Container(
      padding: EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.white),
        child: Text('Follow',style: TextStyle(color: Colors.black87)),
        onPressed: (){

        },
      ),
    );
  }

  Widget profileWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.all(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60, // or any other size you want
            backgroundImage: AssetImage('assets/images/damian.png'),
            backgroundColor: Colors.transparent,
          ),
          VerifiedUserName(name: '@derick',isVerified: true,centered: true),
          Clout(followers: 10,following: 0),
          ZoneCount(count: 15),
          UserStarLevel(starLevel:StarLevel.Adventurer),
        ],
      ),
    );
  }

  Widget moreUserDetails() {
    final date = DateTime.now();
    final trailingStyle =
    TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,fontSize: 16);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User details',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Username '),
              trailing: Text('derick', style: trailingStyle),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Nº of Zones '),
              trailing: Text('15', style: trailingStyle),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Joined '),
              trailing: Text('${date.day}/${date.month}/${date.year}', style: trailingStyle),
            ),
          ],
        ),
      ),
    );
  }
}