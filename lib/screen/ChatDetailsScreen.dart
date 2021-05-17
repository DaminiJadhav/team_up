import 'package:flutter/material.dart';

class ChatDetails extends StatefulWidget {
  String Username;

  ChatDetails(this.Username);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Username),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: Theme.of(context).platform == TargetPlatform.iOS
                      ? 16.0
                      : 8.0,left: 8.0,right: 8.0),
                  child: BottomWidget() //Your widget here,
              ),
            ),
          ),

        ],
      )
    );
  }
}



class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
                decoration: new InputDecoration(
                    hintText: 'Enter Message..',
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(25.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        // Click listener handle from here
                      },
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Icon(Icons.send),
                          ),
                        ),
                      )
                    )
                ),

    );
  }
}

