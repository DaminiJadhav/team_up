import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainNotificationDesign(),
    );
  }

  Widget MainNotificationDesign() {
    return Card(
      elevation: 25.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [],
      ),
    );
  }
}
