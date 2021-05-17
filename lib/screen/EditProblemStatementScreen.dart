import 'package:flutter/material.dart';

class EditProblemStatement extends StatefulWidget {
  String problemStatementId;
  String problemStatementTitle;
  String problemStatement;
  EditProblemStatement(this.problemStatementId,this.problemStatementTitle,this.problemStatement);
  @override
  _EditProblemStatementState createState() => _EditProblemStatementState();
}

class _EditProblemStatementState extends State<EditProblemStatement> {
  final textEditingControllerTitle = TextEditingController();
  final textEditingControllerStatement = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingControllerTitle.text = widget.problemStatementTitle;
    textEditingControllerStatement.text=widget.problemStatement;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text('Edit Problem Statement',style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: TextField(
                maxLines: 2,
                controller: textEditingControllerTitle,
                decoration: InputDecoration(
                  hintText: "Title",
                  labelText: "Title",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: TextField(
                maxLines: 10,
                controller: textEditingControllerStatement,
                decoration: InputDecoration(
                  hintText: "Problem Statement",
                  labelText: "Problem Statement",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
