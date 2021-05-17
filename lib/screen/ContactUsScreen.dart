import 'package:flutter/material.dart';
import 'package:teamup/screen/GiveAFeedbackScreen.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 16.0),
                    child: Align(
                        alignment:Alignment.topLeft,child: Text('Contact us',style: TextStyle(
                        fontSize: 24.0
                    ),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset('assets/icons/contact.png',height: 30.0,width: 30.0,) ,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,top: 8.0,right: 16.0),
              child: Text("We are here to help. Drop us a mail.",style: TextStyle(
                  fontSize: 18.0
              ),),
            ),
            SizedBox(
              height: 60.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Text('Mail:',style:TextStyle(
                fontSize: 20.0
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0),
              child: Row(
                children: [
                  Expanded(
                      flex:3,
                      child: Text('teamup@gmail.com',style: TextStyle(
                        fontSize: 18.0
                      ),)),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        // Need to send the mail
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Theme.of(context).primaryColor)),
                      child: Center(
                        child: Text(
                          'Mail',
                          style: TextStyle(color: Colors.white,fontSize: 18.0,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Text('Contact:',style:TextStyle(
                  fontSize: 20.0
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0),
              child: Row(
                children: [
                  Expanded(
                      flex:3,
                      child: Text('9999999999',style: TextStyle(
                          fontSize: 18.0
                      ),)),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        launch("tel://999999999");
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Theme.of(context).primaryColor)),
                      child: Center(
                        child: Text(
                          'Call',
                          style: TextStyle(color: Colors.white,fontSize: 18.0,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Text('Feedback:',style:TextStyle(
                  fontSize: 20.0
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0),
              child: Row(
                children: [
                  Expanded(
                      flex:1,
                      child: Text('Write To us',style: TextStyle(
                          fontSize: 18.0
                      ),)),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GiveFeedback()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Theme.of(context).primaryColor)),
                      child: Center(
                        child: Text(
                          'Feedback',
                          style: TextStyle(color: Colors.white,fontSize: 18.0,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
