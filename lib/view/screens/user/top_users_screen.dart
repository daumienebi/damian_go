import 'package:damian_go/utils/navigator_util.dart';
import 'package:damian_go/view/views.dart';
import 'package:flutter/material.dart';

class TopUsersScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Top users'),
      ),
      body: ListView(
        children: [
          UserListTile(username: 'derick',image:'assets/images/piny.png',tempStarLevel:Icon(Icons.star,color: Colors.red,size: 35),verified: false),
          UserListTile(username: 'damian',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.cyan,size: 35),verified: true),
          UserListTile(username: 'xalo',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.green,size: 35),verified: false),
          UserListTile(username: 'john',image:'assets/images/piny.png',tempStarLevel:Icon(Icons.star,color: Colors.amber,size: 35,),verified: true),
          UserListTile(username: 'papilo',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.indigo,size: 35),verified: true),
          UserListTile(username: 'mary',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.brown,size: 35),verified: true),
          UserListTile(username: 'myron',image:'assets/images/pin.png',tempStarLevel:Icon(Icons.star,color: Colors.red,size: 35),verified: false),
          UserListTile(username: 'xalo',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.pink,size: 35),verified: false),
          UserListTile(username: 'john',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.red,size: 35),verified: true),
          UserListTile(username: 'papilo',image:'assets/images/piny.png',tempStarLevel:Icon(Icons.star,color: Colors.red,size: 35),verified: false),
          UserListTile(username: 'mary',image:'assets/images/damian.png',tempStarLevel:Icon(Icons.star,color: Colors.lightBlue,size: 35),verified: true),
          UserListTile(username: 'myron',image:'assets/images/pin.png',tempStarLevel:Icon(Icons.star,color: Colors.red,size:35),verified: false),
        ],
      ),
    );
  }
}

class UserListTile extends StatelessWidget{
  const UserListTile({super.key, required this.username, required this.image, required this.tempStarLevel, required this.verified});
  final String username;
  final String image;
  final Icon tempStarLevel;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //padding: EdgeInsets.all(5),
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(
              NavigatorUtil.createRouteWithSlideAnimation(newPage: UserDetailScreen())
          );
        },
        leading: Image.asset(image),
        title: VerifiedUserName(name: username,isVerified:verified),
        subtitle: Row(
          children: [
            Text('15 zones added',style: TextStyle(fontSize:15)),
          ],
        ),
        trailing: tempStarLevel
      ),
    );
  }
}

/*
*Leading with ranking
* leading: SizedBox(
          width: 70,
          height: 70,
          child: Row(
            children: [
              Text('#1',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,backgroundColor: Colors.black87),),
              Image.asset(image),
            ],
          ),
        ),
* */