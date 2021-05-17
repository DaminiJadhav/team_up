import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teamup/screen/LoginScreen.dart';
import 'package:teamup/screen/SignUpScreen.dart';

// import 'package:flutter_svg/svg.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class SelectLogin extends StatefulWidget {
  @override
  _SelectLoginState createState() => _SelectLoginState();
}

class _SelectLoginState extends State<SelectLogin> {
  int _value;
  bool isNextClick = false;

  @override
  void initState() {
    super.initState();
    Preference.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(
                //   height: 50.0,
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Let's get to know you",
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text("Find the place which belongs to you",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Preference.setIsStudent(false);
                        Preference.setIsOrganization(true);
                        _value = 0;
                        isNextClick = true;
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => Login()));

                    },
                    child: CircleAvatar(
                        radius: 60.0,
                        backgroundColor: _value == 0
                            ? Theme
                            .of(context)
                            .primaryColor
                            : Colors.transparent,
                        child: Image.asset(
                          'assets/art/organization.png',
                          height: 80.0,
                          width: 80.0,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Organization',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Preference.setIsStudent(true);
                      Preference.setIsOrganization(false);
                      _value = 1;
                      isNextClick = true;
                    });

                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: CircleAvatar(
                    // height: 100,
                    // width: 100,
                      radius: 60.0,
                      backgroundColor: _value == 1
                          ? Theme
                          .of(context)
                          .primaryColor
                          : Colors.transparent,
                      child: Image.asset(
                        'assets/art/personal.png',
                        height: 80.0,
                        width: 80.0,
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Personal',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // Container(
                //     child: Align(
                //         alignment: FractionalOffset.bottomCenter,
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 30.0),
                //           child: GestureDetector(
                //             onTap: () {
                //               if (isNextClick) {
                //                 if (Preference.getIsStudent() == true &&
                //                     Preference.getIsOrganization() == false ||
                //                     Preference.getIsStudent() == false &&
                //                         Preference.getIsOrganization() == true) {
                //                   Navigator.of(context).pop();
                //                   Navigator.of(context)
                //                       .push(MaterialPageRoute(
                //                       builder: (context) => Login()));
                //                 }
                //               } else {
                //                 toast().showToast('Please select your role');
                //               }
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 32.0, right: 32.0),
                //               child: Container(
                //                 height: 50.0,
                //                 margin: EdgeInsets.symmetric(horizontal: 20.0),
                //                 decoration: BoxDecoration(
                //                     color: Theme
                //                         .of(context)
                //                         .primaryColor,
                //                     borderRadius: BorderRadius.circular(20.0)),
                //                 child: Center(
                //                   child: Text(
                //                     'Next',
                //                     style: TextStyle(
                //                         fontSize: 20.0,
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ))
                //   //loginButton(context)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget loginButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: GestureDetector(
      onTap: () {
        if (Preference.getIsStudent() == true &&
            Preference.getIsOrganization() == false ||
            Preference.getIsStudent() == false &&
                Preference.getIsOrganization() == true) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Login()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}
