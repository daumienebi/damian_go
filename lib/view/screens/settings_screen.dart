import 'package:damian_go/utils/constants.dart';
import 'package:damian_go/utils/navigator_util.dart';
import 'package:damian_go/view/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Settings'),
      ),
      body: Column(
          children: [
            Expanded(child: settings(context)),
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
          ]
      ),
    );
  }

  Widget settings(BuildContext context){
    return ListView(
      children: [
        _SettingsListTile(
            title: 'Stars Level',
            subtitle: 'Available star levels',
            iconData: Icons.star,
            onTap: (){
              Navigator.of(context).push(
                  NavigatorUtil.createRouteWithSlideAnimation(newPage: StarLevelScreen()));
            }
        ),
        _SettingsListTile(
            title: 'Share app',
            subtitle: 'Share the app with a friend',
            iconData: Icons.share,
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

        ),
        _SettingsListTile(
          title: 'Rate app',
          subtitle: 'Rate the app on Playstore',
          iconData: FontAwesomeIcons.googlePlay,
          onTap: () async{
            String appId = Constants.playStoreId;
            final url = Uri.parse('https://play.google.com/store/apps/details?id=$appId');
            print(url);
            await launchUrl(url,mode: LaunchMode.externalApplication);
          },
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

  Future<String> getVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return Future.value(version);
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
    final titleStyle = TextStyle(fontSize: 17,color: dangerZone ? Colors.red : Colors.black87);
    final Color iconColor = Colors.blueGrey.shade500;
    // TODO: implement build
    return ListTile(
        title: Text(title,style: titleStyle),
        subtitle: Text(subtitle),
        leading: Icon(iconData,color: iconColor),
        trailing: Icon(Icons.arrow_forward_ios_sharp,size: 10,),
        onTap: onTap ?? (){}
    );
  }

}