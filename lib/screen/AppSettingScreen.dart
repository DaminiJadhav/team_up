import 'package:flutter/material.dart';
import 'package:teamup/screen/ChangePersonalDetailsScreen.dart';
import 'package:teamup/screen/CloseAccountScreen.dart';
import 'package:teamup/screen/ContactUsScreen.dart';
import 'package:teamup/screen/FAQScreen.dart';
import 'package:teamup/screen/GiveAFeedbackScreen.dart';
import 'package:teamup/screen/LegalsScreen.dart';
import 'package:teamup/screen/RateUsScreen.dart';

class AppSetting extends StatefulWidget {
  @override
  _AppSettingState createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  bool isPushSelected = true;

  _navigatorScreen(BuildContext context, Widget pageName){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pageName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Setting'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context, ChangePersonalDetails());
                },
                child: Container(
                  child: Text('Change Password',style: TextStyle(
                    fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context, GiveFeedback());
                },
                child: Container(
                  child: Text('Give us a feedback',style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context, FAQ());
                },
                child: Container(
                  child: Text("FAQ's",style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: GestureDetector(
            //     onTap: (){
            //     _navigatorScreen(context, RateUs());
            //     },
            //     child: Container(
            //       child: Text('Rate Us',style: TextStyle(
            //           fontSize: 18.0
            //       ),),
            //     ),
            //   ),
            // ),
            // Divider(
            //   color: Colors.black,
            // ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context, ContactUs());
                },
                child: Container(
                  child: Text('Contact Us',style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context, Legalas());
                },
                child: Container(
                  child: Text('Legals',style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){
                  _navigatorScreen(context,CloseAccount());
                },
                child: Container(
                  child: Text('Deactivate Account',style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text('Push Notification',style: TextStyle(
                            fontSize: 18.0
                        ),),
                      ),

                        Expanded(
                          flex: 1,
                          child: Switch(
                            activeColor: Theme.of(context).primaryColor,
                            value: isPushSelected,
                            onChanged: (value){
                              setState(() {
                                isPushSelected = value;

                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



