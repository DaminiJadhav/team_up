import 'package:flutter/material.dart';
import 'package:teamup/screen/EditProblemStatementScreen.dart';

class ProblemStatementDetails extends StatefulWidget {
  String Title;
  String Statement;
  ProblemStatementDetails(this.Title,this.Statement);
  @override
  _ProblemStatementDetailsState createState() => _ProblemStatementDetailsState();
}

class _ProblemStatementDetailsState extends State<ProblemStatementDetails> {
  bool darkModeOn = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    var whichMode=mode.brightness;
    if(whichMode == Brightness.dark){
      setState(() {
        darkModeOn = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right:16.0,top: 4.0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                  // print('click..');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProblemStatement('1',widget.Title,widget.Statement)
                  ));
                },
                child: Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.edit,  color: darkModeOn ? Colors.white:Colors.black,),
                  ),
                  label: Text('Edit',style: TextStyle(
                    color: darkModeOn ? Colors.white:Colors.black,
                    fontSize: 18.0
                  ),),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:8.0,left:16.0,right: 16.0,bottom: 16.0),
            child: Text(widget.Statement,textAlign: TextAlign.justify,style: TextStyle(
              fontSize: 18.0,
              color: darkModeOn ? Colors.white:Colors.black,
            ),),
          ),
        ],
      ),
    );
  }
}
