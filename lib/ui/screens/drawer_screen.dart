import 'package:damian_go/ui/components/components.dart';
import 'package:damian_go/ui/screens/star_level_screen.dart';
import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: prefer_const_constructors

class DrawerScreen extends StatelessWidget{
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Profile'),
          backgroundColor: Colors.blueGrey.shade900,
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
          optionsWidget(context),
          //Display the current app version
          Padding(
            padding: EdgeInsets.only(top:10,bottom: 15),
            child: FutureBuilder(
                future: getVersion(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Container(
                      child: Text(
                        'Version : ${snapshot.data}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38
                        ),
                      ),
                    );
                  }else return Text("");
                }),
          ),
        ],
      ),
    );
  }

  Widget profileWidget(BuildContext context){
    return Container(
      padding: EdgeInsets.all(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
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
          VerifiedUserName(name: '@derick',isVerified: true),
          Clout(followers: 10,following: 0),
          ZoneCount(count: 15),
          UserStarLevel(starLevel:StarLevel.Adventurer),
        ],
      ),
    );
  }

  Widget optionsWidget(context){
    return Expanded(
      child: Container(
        child: ListView(
          children: _optionsList(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 3)
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _optionsList(context){
    List<Widget> widgets = [];
    final subTitleStyle = TextStyle(fontSize: 14);
    final titleStyle = TextStyle(fontSize: 17);
    final Color iconColor = Colors.blueGrey.shade500;

    widgets.add(InkWell(
      child: ListTile(
          title: Text('Star levels',style: titleStyle),
          subtitle: Text('Available levels as you add zones'),
          leading: Icon(Icons.star,color: iconColor),
          trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10,),
          onTap: ()=> Navigator.of(context).push(
              NavigatorUtil.createRouteWithSlideAnimation(newPage: StarLevelScreen())
          )
      ),
    ));

    widgets.add(ListTile(
        title: Text('Share with a friend',style: titleStyle),
        subtitle: Text('Share the app with friends'),
        leading: Icon(Icons.share,color: iconColor),
        trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10,),
        onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
            barrierColor: Colors.black26,
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 7, right: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
                height: 120,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Share the app',textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(height: 5,),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: socialMediaButtons(context),
                        ),
                      ),
                    ]),
              );
            });
      },
    ));

    widgets.add(ListTile(
      title: Text('Delete account',style: titleStyle),
      leading: Icon(Icons.delete,color: iconColor),
      subtitle: Text('Permanently delete your account'),
      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10,),
      onTap: (){
      },
    ));

    widgets.add(ListTile(
      title: Text('Logout',style: titleStyle),
      leading: Icon(Icons.logout,color: iconColor),
      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10,),
      onTap: (){
      },
    ));
    return widgets;
  }

  Future<String> getVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return Future.value(version);
  }

  socialButton({required String socialMedia,required Icon icon,
    Function()? onClicked}) {
    final listTextStyle = TextStyle(color: Colors.black54);
    return Container(
      child: Column(
        children: [
          InkWell(
            child: icon,
            onTap: onClicked,
          ),
          Text(socialMedia, style: listTextStyle,),
        ],
      ),
    );
  }
  /// Method to launch each share option for the [SocialMedia]
  Future share(SocialMedia platform,BuildContext context) async {
    String text = 'Test text';
    String appId = 'com.devdaumienebi.yonunca';
    final urlString = 'https://play.google.com/store/apps/details?id=$appId';
    final urlShare = Uri.encodeComponent(urlString);
    final urls = {
      SocialMedia.Facebook:
      'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
      SocialMedia.Twitter:
      'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
      SocialMedia.Whatsapp: 'https://api.whatsapp.com/send?text=$text $urlShare',
    };
    final url = Uri.parse(urls[platform]!);
    await launchUrl(url,mode: LaunchMode.externalApplication);
  }

  List<Widget> socialMediaButtons(context) {
    //Very shitty work around
    // TODO : Change it later on
    List<Widget> items = [];
    items.add(SizedBox(
      width: 10,
    ));
    items.add(socialButton(
        socialMedia: SocialMedia.Whatsapp.name,
        icon: Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.green,
          size: 40,
        ),
        onClicked: (){
          Navigator.pop(context);
          share(SocialMedia.Whatsapp,context);
        }));
    items.add(SizedBox(
      width: 15,
    ));
    items.add(socialButton(
        socialMedia: SocialMedia.Twitter.name,
        icon: Icon(
          FontAwesomeIcons.twitter,
          color: Colors.lightBlueAccent,
          size: 40,
        ),
        onClicked: (){
          Navigator.pop(context);
          share(SocialMedia.Twitter,context);
        }));
    items.add(SizedBox(
      width: 15,
    ));
    items.add(socialButton(
        socialMedia: SocialMedia.Email.name,
        icon: Icon(
          Icons.email,
          color: Colors.redAccent,
          size: 40,
        ),
        onClicked: (){
          Navigator.pop(context);
          share(SocialMedia.Facebook,context);
        }));
    items.add(SizedBox(
      width: 15,
    ));
    items.add(socialButton(
        socialMedia: SocialMedia.Facebook.name,
        icon: Icon(
          FontAwesomeIcons.facebook,
          color: Colors.indigo,
          size: 40,
        ),
        onClicked: (){
          Navigator.pop(context);
          share(SocialMedia.Facebook,context);
        }));
    items.add(SizedBox(
      width: 15,
    ));
    items.add(
        socialButton(
            socialMedia: 'Copy link',
            icon: Icon(
              Icons.copy,
              color: Colors.grey,
              size: 40,
            ),
            onClicked: () async{
              String appId = 'com.devdaumienebi.yonunca';
              final urlString = 'https://play.google.com/store/apps/details?id=$appId';
              await Clipboard.setData(ClipboardData(text:urlString));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Link copied'),
                      duration: Duration(seconds: 2)
                  )
              );
            }
        )
    );
    return items;
  }
}