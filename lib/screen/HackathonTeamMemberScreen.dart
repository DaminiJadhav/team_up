import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/HackathonTeamDetailsContract.dart';
import 'package:teamup/module/HackathonTeamDetailsModel.dart';
import 'package:teamup/presenter/HackathonTeamDetailsPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';

class HackathonMember extends StatefulWidget {
  String teamId;

  HackathonMember(this.teamId);

  @override
  _HackathonMemberState createState() => _HackathonMemberState();
}

class _HackathonMemberState extends State<HackathonMember>
    implements HackathonTeamDetailsContract {
  HackathonTeamDetailsPresenter teamDetailsPresenter;

  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  List<TeamDetails> teamList;
  List<TeamMember> memberList;

  _HackathonMemberState() {
    teamDetailsPresenter = new HackathonTeamDetailsPresenter(this);
  }

  getDetails() {
    teamList = new List();
    memberList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String teamId = widget.teamId;
        teamDetailsPresenter
            .getTeamDetails('Hackathon/GetTeamDetails?TeamId=$teamId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    getDetails();
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
        title: Text("Members's"),
      ),
      body: isInternetAvailable
          ? Container(
              child: teamList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Team Name : ',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                  child: new Container(
                                    padding: new EdgeInsets.only(left: 8.0),
                                    child: new Text(
                                      teamList[0].teamName,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 4.0),
                            child: Text(
                              'Statement : ',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 4.0),
                            child: Text(
                              teamList[0].statement,
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Text(
                              'Team Members',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          memberList.isNotEmpty
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: memberList.length,
                                  itemBuilder: (context, index) {
                                    return MemberListDesign(
                                        memberList[index].id.toString(),
                                        memberList[index].name,
                                        memberList[index].isStd);
                                  })
                              : Container(
                                  child: Center(
                                    child: Text('Team Member not available.'),
                                  ),
                                ),
                          SizedBox(
                            height: 30.0,
                          ),
                          RequestJoinButton(),
                        ],
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text(isApiCallProcess
                            ? 'Loading'
                            : 'Something went wrong, Please try again later.'),
                      ),
                    ),
            )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget MemberListDesign(String id, String MemberName, bool isStd) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MemberName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Divider(),
          ],
        ));
  }

  Widget RequestJoinButton() {
    return Center(
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Theme.of(context).primaryColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Request to Join',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(HackathonTeamDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      teamList.add(detailsModel.teamDetails);
      memberList.addAll(detailsModel.teamDetails.teamMembers);
    } else {
      toast().showToast(detailsModel.message);
    }
  }
}
