import 'package:flutter/material.dart';
import 'package:teamup/screen/ChatDetailsScreen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView(
        children: [
          cardDesign(context,"A"),
          cardDesign(context,"B"),
          cardDesign(context,"C"),
          cardDesign(context,"D"),
          cardDesign(context,"E"),
          cardDesign(context,"F"),
          cardDesign(context,"G"),
          cardDesign(context,"H"),
          cardDesign(context,"I"),
          cardDesign(context,"J"),
          cardDesign(context,"K"),
          cardDesign(context,"L"),
          cardDesign(context,"M"),
          cardDesign(context,"N"),
          cardDesign(context,"O"),
          cardDesign(context,"P"),
          cardDesign(context,"Q"),
          cardDesign(context,"R"),
        ],
      ),
    );
  }
}
Widget cardDesign(BuildContext context,String name){
  return Card(
    elevation: 5.0,
    clipBehavior: Clip.antiAlias,
    shadowColor: Theme.of(context).accentColor,
    child: ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatDetails(name)));
      },
      leading: CircleAvatar(
        backgroundColor:Theme.of(context).primaryColor,
        child: Text(
          name,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      title: Text('$name Sdaemon Info'),
      subtitle: Text('Last Message..'),
    ),
  );
}
