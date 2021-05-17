import 'package:flutter/material.dart';

class TerminateProjectAdmin extends StatefulWidget {
  @override
  _TerminateProjectAdminState createState() => _TerminateProjectAdminState();
}

class _TerminateProjectAdminState extends State<TerminateProjectAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminate Project'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 16.0),
                    child: Align(
                        alignment:Alignment.topLeft,child: Text('Terminate Project',style: TextStyle(
                        fontSize: 28.0
                    ),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,right: 16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset('assets/icons/project.png',height: 70.0,width: 70.0,) ,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left:32.0,top: 16.0),
              child: Text('We are sorry to hear that from you!',style: TextStyle(
                fontSize: 18.0
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:32.0),
              child: Text('You and your members will lose access to the project',style: TextStyle(
                  fontSize: 18.0
              ),),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:32.0),
              child: Text('Are you sure?',style: TextStyle(
                  fontSize: 18.0
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:24.0,right: 24.0,top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type Yes for confirmation",
                  labelText: "Confirmation",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:24.0,right: 24.0,top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Email",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:24.0,right: 24.0,top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(child: Text('Have a nice day!',style: TextStyle(
              fontSize: 24.0
            ),)),
            SizedBox(
              height: 40.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Cancel',style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {},
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Confirm',style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
