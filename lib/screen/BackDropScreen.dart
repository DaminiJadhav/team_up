import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamup/Widgets/Events.dart';
import 'package:teamup/Widgets/Hackathon.dart';
import 'package:teamup/Widgets/Notification.dart';
import 'package:teamup/Widgets/Projects.dart';
import 'package:teamup/Widgets/Search.dart';
import 'package:teamup/screen/AboutUsScreen.dart';
import 'package:teamup/screen/AdAndEventScreen.dart';
import 'package:teamup/screen/AppSettingScreen.dart';
import 'package:teamup/screen/GetStartedScreen.dart';
import 'package:teamup/screen/MyHackathon.dart';
import 'package:teamup/screen/MyNetworkScreen.dart';
import 'package:teamup/screen/MyProjectsScreen.dart';
import 'package:teamup/screen/ProfileScreen.dart';
import 'package:teamup/screen/organizationscreens/OrganizationProfileScreen.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;
  final int currentIndex;
  final Function callBack;

  TwoPanels({this.controller, this.currentIndex, this.callBack});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 15.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanel = height - header_height;
    final fronPanel = -header_height;

    return new RelativeRectTween(
            begin: new RelativeRect.fromLTRB(0.0, backPanel, 0.0, fronPanel),
            end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(new CurvedAnimation(
            parent: widget.controller, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return new Container(
      child: new Stack(
        children: [
          new Container(
            color: theme.primaryColor,
            child: new Center(
              child: backPanelMenuList(
                  context, widget.currentIndex, widget.callBack),
              //     Text(
              //   'Back Panel',
              //   style: TextStyle(fontSize: 24.0, color: Colors.white),
              // )
            ),
          ),
          new PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: new Material(
              shadowColor: Colors.white,
              // color: Colors.white,
              elevation: 12.0,
              borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(16.0),
                topRight: new Radius.circular(16.0),
              ),
              child: new Column(
                children: [
                  new Container(
                    height: header_height,
                    child: Center(
                      child: Text(''),
                    ),
                  ),
                  new Expanded(
                      child: new Center(
                    child: mainContainer(context, widget.currentIndex),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preference.init();
  }

  void logout() {
    toast().showToast("Logout Successfully..");
    setState(() {
      Preference.setIsLogin(false);
      // Preference.setUserId(0);
      // Preference.setUserFirstName('');
      // Preference.setUserLastName('');
      // Preference.setUserEmail('');
      // Preference.setUserMobile('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  Widget backPanelMenuList(
      BuildContext context, int tabIndex, Function callback) {
    return ListView(
      children: [
        Center(
          child: Center(
            child: UserAccountsDrawerHeader(
              accountName: Text(Preference.getIsStudent()
                  ? Preference.getUserFirstName() +
                      " " +
                      Preference.getUserLastName()
                  : Preference.getUserFirstName()),
              accountEmail: Text(Preference.getUserEmail()),
              currentAccountPicture: CircleAvatar(
                  radius: 100.0,
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white
                          : Colors.white,
                  child: Preference.getUserImage() == null
                      ? Text(
                          '${Preference.getUserFirstName()[0]}',
                          style: TextStyle(fontSize: 40.0),
                        )
                      : Container(
                          alignment: Alignment(0.0, 1.9),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(Preference.getUserImage()),
                            radius: 100.0,
                          ),
                        )
                  //Image.network(Preference.getUserImage()),
                  ),
            ),
          ),
        ),

        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Go To Profile ",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            onTap: () {
              if (Preference.getIsStudent()) {
                callback(context, Profile());
              } else {
                callback(context, OrganizationProfile());
              }
            },
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.event_seat, color: Colors.white),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Get Started",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, GetStarted());
            },
          ),
        ),
        // Divider(
        //   color: Colors.black,
        // ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.next_week,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "My Projects",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, MyProjects());
            },
          ),
        ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.network_check,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "My Network",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, MyNetwork());
            },
          ),
        ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.code,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "My Hackathon",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, MyHackathon());
            },
          ),
        ),
        // Divider(
        //   color: Colors.black,
        // ),

        Divider(
          color: Colors.white,
        ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.settings, color: Colors.white),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "App Setting",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, AppSetting());
            },
          ),
        ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "About Us",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, AboutUs());
            },
          ),
        ),
        // Divider(
        //   color: Colors.black,
        // ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Ads & Events",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                textAlign: TextAlign.left,
              ),
            ),
            onTap: () {
              callback(context, AdsAndEvents());
            },
          ),
        ),
        // Divider(
        //   color: Colors.black,
        // ),
        Center(
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Confirm",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  content: Text('Do you want to Logout your account?'),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    new FlatButton(
                        onPressed: () {
                          logout();
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            exit(0);
                          });
                        },
                        child: Text('Yes'))
                  ],
                ),
              );
            },
          ),
        ),
        // Positioned(
        //   child: new Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Icon(Icons.ac_unit)),
        // ),
        SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}

Widget mainContainer(BuildContext context, int tabIndex) {
  Widget child;
  if (tabIndex == 0) {
    child = dashEventContainer(context);
  } else if (tabIndex == 1) {
    child = dashProjectContainer(context);
  } else if (tabIndex == 2) {
    child = dashHackathonContainer();
  } else if (tabIndex == 3) {
    //child = dashSearchContainer(context);
    child = dashNotificationContainer(context);
  } else {
    child = dashNotificationContainer(context);
  }
  return new Container(
    child: child,
  );
}

Widget dashEventContainer(BuildContext context) {
  return events();
}

Widget dashProjectContainer(BuildContext context) {
  return projects();
}

Widget dashSearchContainer(BuildContext context) {
  return Container(child: search(context));
}

Widget dashNotificationContainer(BuildContext context) {
  return Container(child: notification());
}

Widget dashHackathonContainer() {
  return Container(child: HackathonScreen());
}
