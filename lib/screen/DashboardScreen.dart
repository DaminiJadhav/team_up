import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:teamup/Widgets/Notification.dart';
import 'package:teamup/screen/AddHackathonScreen.dart';
import 'package:teamup/screen/AddProjectOrganization.dart';
import 'package:teamup/screen/AddProjectScreen.dart';
import 'package:teamup/screen/BackDropScreen.dart';
import 'package:teamup/screen/ChatScreen.dart';
import 'package:teamup/utils/SharedPreference.dart';

class Dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool hideFabButton = true;
  int _currentIndex = 0;

  bool isFirstTimeOpen;

  bool get isPanelVisible {
    final AnimationStatus status = _controller.status;
    if (status == AnimationStatus.completed) {
      setState(() {
        hideFabButton = false;
      });
    } else {
      setState(() {
        hideFabButton = true;
      });
    }
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void nextPage(BuildContext context, Widget pageName) {
    _controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => pageName,
    ));
  }

  void navigationScreen(BuildContext context, Widget pageName) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => pageName,
    ));
  }

  //Push Notification Code
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return notification();
    }));
  }

  showNotification(String title, String body, String screen) async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description');
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platform,
        payload: screen);
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    //Notification code -------------------------------
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    //---------------------------------------------------
    isFirstTimeOpen = true;
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 100), value: 1.0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTimeOpen) {
      Future.delayed(Duration.zero, () => _showAlert(context));
      isFirstTimeOpen = false;
    }
    return new Scaffold(
      appBar: new AppBar(
        // title: Text('Team Up'),
        title: EasyRichText(
          "Team Up",
          patternList: [
            EasyRichTextPattern(
                targetString: 'Up', superScript: true,style: TextStyle(
              color: Hexcolor('#dee5f3'),
            )),
            // EasyRichTextPattern(
            //     targetString: 'subscript', subScript: true),
          ],
        ),
        elevation: 0.0,
        leading: new IconButton(
          onPressed: () {
            _controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
          },
          icon: new AnimatedIcon(
              icon: AnimatedIcons.close_menu, progress: _controller.view),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                navigationScreen(context, ChatScreen());
              },
              child: Icon(Icons.message),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text('Event')),
          BottomNavigationBarItem(
              icon: Icon(Icons.pages), title: Text('Project')),
          BottomNavigationBarItem(
              icon: Icon(Icons.code), title: Text('Hackathon')),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text('Notification')),
        ],
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
        },
      ),
      body: new TwoPanels(
          controller: _controller,
          currentIndex: _currentIndex,
          callBack: nextPage),
      // floatingActionButton: floatButton(_currentIndex, context, hideFabButton),
    );
  }
}

void _showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Events',
        style: Theme.of(context).textTheme.title,
      ),
      content: Image.asset('assets/introImages/Image1.png'),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

Widget floatButton(int Index, BuildContext context, bool isPanelOpen) {
  if (Index == 1 && isPanelOpen == true) {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Preference.getIsOrganization()
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddProjectOrganization(),
                ))
              : Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddProject(),
                ));
        },
        tooltip: 'Add New Project',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  } else if (Index == 2 &&
      isPanelOpen == true &&
      Preference.getIsOrganization()) {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddHackathon(),
          ));
        },
        tooltip: 'Add New Hackathon',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  } else {
    return Container();
  }
}
