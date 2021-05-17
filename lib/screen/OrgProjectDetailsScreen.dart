import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:teamup/screen/SubmitProjectScreen.dart';
import 'package:teamup/screen/TerminateProjectAdminScreen.dart';
import 'package:teamup/screen/organizationscreens/OrganizationSecondPersonScreen.dart';

class OrgProjectDetails extends StatefulWidget {
  String projectId;
  OrgProjectDetails(this.projectId);
  @override
  _OrgProjectDetailsState createState() => _OrgProjectDetailsState();
}

class _OrgProjectDetailsState extends State<OrgProjectDetails> {
  _onShareTheDetails(BuildContext context) async{
    String text = "This is text \n This is Body Text";
    await Share.share(text);
    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: GestureDetector(
              onTap: (){
                _onShareTheDetails(context);
              },
              child: Icon(Icons.share),
            ),
          )
        ],
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
                          alignment:Alignment.topLeft,child: Text('Project Name',style: TextStyle(
                          fontSize: 24.0
                      ),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0,right: 16.0),
                      child: GestureDetector(
                        onTap: (){},
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('assets/icons/chat.png',height: 50.0,width: 50.0,) ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ProjectByAdminMainDesign(context),
            ],
          ) ,
      ),
    );

  }
  Widget ProjectByAdminMainDesign(BuildContext context){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Headlines: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text('Team Up Project',style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('Level: ',style: TextStyle(
                          fontSize: 18.0
                      ),),
                      Text('Beginner',style: TextStyle(
                          fontSize: 18.0
                      ),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('Type: ',style: TextStyle(
                          fontSize: 18.0
                      ),),
                      Text('Software',style: TextStyle(
                          fontSize: 18.0
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('Deadline: ',style: TextStyle(
                          fontSize: 18.0
                      ),),
                      Text('10 Oct 20',style: TextStyle(
                          fontSize: 18.0
                      ),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('No.Of members: ',style: TextStyle(
                          fontSize: 18.0
                      ),),
                      Text('5',style: TextStyle(
                          fontSize: 18.0
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Field: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text('Software Development',style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Expanded(
                  child: Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18.0
                    ),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Show more'),
                onPressed: () {},
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Group Details:',style: TextStyle(
                      fontSize: 22.0
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Theme.of(context).primaryColor)),
                    child: Text('Add Member',style: TextStyle(
                        color: Colors.white
                    ),),
                    onPressed: () {},
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Go to Chat',style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          UserDesign(context),
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Show more'),
                onPressed: () {},
              ),
            ),
          ),
          Divider(
            color: Colors.black,
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
                child: Text('Finish Project',style: TextStyle(
                    color: Colors.white
                ),),
                onPressed: () {},
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Submit Files',style: TextStyle(
                    color: Colors.white
                ),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SubmitProject(widget.projectId)));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Submit the files and get your project certificate.',
              style:TextStyle(
                  fontSize: 18.0
              ) ,)),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: GestureDetector(
              onTap: (){},
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Terminate Project',style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TerminateProjectAdmin()));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget UserDesign(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPerson()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.account_circle,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username'),
                              Text('Name'),
                              Text('Email'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPerson()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.account_circle,color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username'),
                              Text('Name'),
                              Text('Email'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }


}
