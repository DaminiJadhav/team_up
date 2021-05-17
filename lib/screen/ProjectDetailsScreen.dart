import 'package:flutter/material.dart';
import 'package:teamup/Widgets/Projects.dart';
import 'package:teamup/contract/GetProjectDetailsContract.dart';
import 'package:teamup/module/GetProjectDetailsModel.dart';
import 'package:teamup/presenter/GetProjectDetailsPresenter.dart';
import 'package:teamup/screen/LeaveProjectScreen.dart';
import 'package:teamup/screen/MyNetworkUserDetails.dart';
import 'package:teamup/screen/SubmitProjectScreen.dart';
import 'package:teamup/screen/TerminateProjectAdminScreen.dart';
import 'package:teamup/screen/organizationscreens/MyNetworkOrgUser.dart';
import 'package:teamup/screen/organizationscreens/OrganizationSecondPersonScreen.dart';
import 'package:share/share.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

import 'AddMemberToProjectScreen.dart';

class ProjectScreen extends StatefulWidget {
  String projectId;
  bool isOnGoing;

  ProjectScreen(this.projectId, this.isOnGoing);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    implements GetProjectDetailsContract {
  GetProjectDetailsPresenter projectDetailsPresenter;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isDataAvailable = false;
  String bodyMessage = "";

  String pName = "";
  String pHeading = "";
  String pLevel = "";
  String pType = "";
  String pDeadline = "";
  String pCountOfTeamMember = "";
  String pField = "";
  String pDesc = "";
  String createdId = "";
  String pStartDate = "";
  bool isStd;
  bool isShowMore = true;
  int showLine = 4;
  List<Member> memberList;

  _ProjectScreenState() {
    projectDetailsPresenter = new GetProjectDetailsPresenter(this);
  }

  getProjectDetail() {
    setState(() {
      isApiCallProcess = true;
    });
    String id = widget.projectId;
    String userId = Preference.getUserId().toString();

    String url =
        "ProjectTeamMembers/GetAllProjectTeamDetails?PID=$id&UserId=$userId";
    projectDetailsPresenter.getProjectDtl(url);
  }

  _onShareTheDetails(BuildContext context) async {
    String text = pName;
    await Share.share(text, subject: pDesc);
    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
  }

  Future onBack(dynamic value) {
    setState(() {});
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        memberList.clear();
        getProjectDetail();
      } else {
        setState(() {
          bodyMessage = "No internet connection available";
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    memberList = List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getProjectDetail();
      } else {
        setState(() {
          bodyMessage = "No internet connection available";
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _MainUI(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _MainUI(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Project'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  _onShareTheDetails(context);
                },
                child: Icon(Icons.share),
              ),
            )
          ],
        ),
        body: isInternetAvailable
            ? isDataAvailable
                ? Container(
                    child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 16.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      pName,
                                      style: TextStyle(fontSize: 24.0),
                                    )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 16.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/icons/chat.png',
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ProjectAsMemberMainDesign(context),
                    ],
                  ))
                : Container(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  )
            : Container(
                child: Center(
                  child: Text(bodyMessage),
                ),
              ));
  }

  Widget ProjectAsMemberMainDesign(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Type and Team Member
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          pType,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Type',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Text(
                          pCountOfTeamMember,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Team Member',
                            style: TextStyle(fontSize: 10.0),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Level and Field
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          pLevel,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Level',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          pField,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(),
                          child: Text(
                            'Field',
                            style: TextStyle(fontSize: 10.0),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Start Date and End Date
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          pStartDate,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Start Date',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          pDeadline,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(),
                          child: Text(
                            'Deadline',
                            style: TextStyle(fontSize: 10.0),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Divider Line
          Divider(
            color: Colors.black,
          ),
          //Description area
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: pDesc.length > 300 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        child: Text(isShowMore ?'Show more' : 'Show less',style: TextStyle(
                          color: Colors.white
                        ),),
                        onPressed: () {
                          if(isShowMore){
                            setState(() {
                             isShowMore = false;
                             showLine = 50;
                            });
                          }else{
                            setState(() {
                              isShowMore = true;
                              showLine = 4;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              pDesc,
              textAlign: TextAlign.justify,
              maxLines: showLine,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0),
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
                  child: Text(
                    'Group Details:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Visibility(
                  visible: Preference.getUserId().toString() == createdId,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      child: Text(
                        'Add Member',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    AddMember(widget.projectId)))
                            .then(onBack);
                      },
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text(
                    'Go to Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Column(
            children: [
              memberList.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: memberList.length,
                      itemBuilder: (context, index) {
                        return UserDesign(
                            context,
                            memberList[index].Id.toString(),
                            memberList[index].name,
                            memberList[index].email,
                            memberList[index].username,
                            memberList[index].ImagePath,
                            memberList[index].IsStudent);
                      })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            'Team Not Available',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              minWidth: MediaQuery.of(context).size.width,
              height: 40.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              child: Text(
                'Finish Project',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SubmitProject(widget.projectId)));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Visibility(
                visible: Preference.getUserId().toString() != createdId,
                child: FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.red)),
                  child: Text(
                    'Leave Project',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LeaveProject(widget.projectId)));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget UserDesign(BuildContext context, String id, String name, String email,
      String userName, String imagePath, bool isStudent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (isStudent) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyNetworkUserStd(id)));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyNetworkOrgUser(id)));
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Container(
                            child: Container(
                              alignment: Alignment(0.0, 1.9),
                              child: CircleAvatar(
                                backgroundImage: imagePath != null
                                    ? NetworkImage(imagePath)
                                    : AssetImage('assets/art/profile.png'),
                                radius: 30.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userName != null ? userName : 'NA'),
                              Text(name != null ? name : 'NA'),
                              Text(email != null ? email : 'NA'),
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

  @override
  void showProjectDetailsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, Please try again later...";
      isInternetAvailable = false;
    });
  }

  @override
  void showProjectDetailsSuccess(GetProjectDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      setState(() {
        pName = detailsModel.project[0].projectname;
        pHeading = detailsModel.project[0].projectheading;
        pLevel = detailsModel.project[0].levels;
        pType = detailsModel.project[0].type;
        pDeadline = detailsModel.project[0].endDate;
        pStartDate = detailsModel.project[0].startDate;
        pCountOfTeamMember = detailsModel.project[0].teamMembers.toString();
        pField = detailsModel.project[0].field;
        pDesc = detailsModel.project[0].description;
        createdId = detailsModel.project[0].createdId.toString();
        isStd = detailsModel.project[0].isStd;
      });
      memberList.addAll(detailsModel.members);
      setState(() {
        isDataAvailable = true;
      });
    } else {
      setState(() {
        bodyMessage = "Something went wrong, Please try again later...";
        isInternetAvailable = false;
      });
    }
  }
}
