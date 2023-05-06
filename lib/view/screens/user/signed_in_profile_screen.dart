import 'package:damian_go/utils/navigator_util.dart';
import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/view/views.dart';
import 'package:flutter/material.dart';

class SignedInProfileScreen extends StatelessWidget{
  const SignedInProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Profile'),
          backgroundColor: Colors.blueGrey.shade900,
          actions: [
            IconButton(
                 onPressed: (){
                   Navigator.of(context).push(
                       NavigatorUtil.createRouteWithSlideAnimation(
                           newPage: SettingsScreen())
                   );
                 },
                icon: Icon(Icons.settings
                )
            )
          ],
        ),
        body: body(context)
    );
  }

  Widget body(context){
    return Container(
      margin: EdgeInsets.only(top: 15,left: 10, right: 10),
      child: Column(
        children: [
          profileWidget(context),
          SizedBox(height:10),
          moreUserDetails(),
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
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Birthday '),
              trailing: Text('${date.day}/${date.month}/${date.year}', style: trailingStyle),
            ),
          ],
        ),
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
          UserStarLevel(starLevel:StarLevel.Adventurer),
        ],
      ),
    );
  }
}