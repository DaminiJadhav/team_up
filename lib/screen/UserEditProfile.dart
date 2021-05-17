import 'package:flutter/material.dart';

class UserEditProfile extends StatefulWidget {
  String Title;
  UserEditProfile(this.Title);
  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Title),
      ),
      body: Container(
        child: Text('Test Screen'),
      ),
    );
  }
}
