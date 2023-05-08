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
                   showModalBottomSheet(
                       barrierColor: Colors.black26,
                       backgroundColor: Colors.transparent,
                       context: context,
                       builder: (BuildContext context) {
                         double height = MediaQuery.of(context).size.height;
                         return Container(
                           height: height * 0.3,
                           padding: const EdgeInsets.all(10),
                           margin: const EdgeInsets.only(left: 7, right: 7),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child: Expanded(
                             child: ListView(
                               //scrollDirection: Axis.horizontal,
                               children: [
                                 _SettingsListTile(
                                   title: 'Help',
                                   subtitle: 'Help about the app',
                                   iconData: Icons.logout,
                                 ),
                                 _SettingsListTile(
                                   title: 'Delete account',
                                   subtitle: 'Permanently delete your account',
                                   iconData: Icons.delete,
                                   dangerZone: true,
                                 ),
                                 _SettingsListTile(
                                   title: 'Log out',
                                   subtitle: '',
                                   iconData: Icons.logout,
                                   dangerZone: true,
                                 ),
                               ],
                             ),
                           ),
                         );
                       });
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
    TextStyle(color: Colors.black54, fontWeight: FontWeight.w400,fontSize: 16);
    final leadingStyle = TextStyle(color: Colors.black87);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Username ',style: leadingStyle,),
              trailing: Text('derick', style: trailingStyle),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Nº of Zones ',style: leadingStyle),
              trailing: Text('15', style: trailingStyle),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Joined ',style: leadingStyle,),
              trailing: Text('${date.day}/${date.month}/${date.year}', style: trailingStyle),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Birthday ',style: leadingStyle,),
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

class _SettingsListTile extends StatelessWidget{
  final String title;
  final String subtitle;
  final IconData iconData;
  final bool dangerZone;
  final Function()? onTap;

  const _SettingsListTile({super.key, required this.title, required this.subtitle, required this.iconData, this.onTap, this.dangerZone = false});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 16,color: dangerZone ? Colors.red : Colors.black87);
    final Color iconColor = Colors.blueGrey.shade500;
    // TODO: implement build
    return ListTile(
        title: Text(title,style: titleStyle),
        subtitle: Text(subtitle),
        leading: Icon(iconData,color: iconColor),
        trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10),
        onTap: onTap ?? (){}
    );
  }
}