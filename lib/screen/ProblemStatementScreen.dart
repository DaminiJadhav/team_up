import 'package:flutter/material.dart';
import 'package:teamup/screen/ProblemStatementDetailsScreen.dart';

class ProblemStatement extends StatefulWidget {
  @override
  _ProblemStatementState createState() => _ProblemStatementState();
}

class _ProblemStatementState extends State<ProblemStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem Statement'),
      ),
      body: ListView(
            children: [
              cardViewDesign(context,'We need Urgent Basis PHP developer. We Have issue in curl.','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'B','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'C','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'D','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'E','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'F','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'G','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
              cardViewDesign(context,'H','It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like'),
            ],
      ),
    );
  }
}

Widget cardViewDesign(BuildContext context,String Title,String Statement){
  return Card(
    elevation: 10.0,
    clipBehavior: Clip.antiAlias,
    shadowColor: Theme.of(context).primaryColor,
    child: ListTile(
      onTap: (){
        // print('im click $Title');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>ProblemStatementDetails(Title,Statement)
        ));
      },
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(Title,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(Statement,overflow: TextOverflow.ellipsis,maxLines: 5,style: TextStyle(
          fontSize: 18.0
        ),),
      ),
    ),
  );
}