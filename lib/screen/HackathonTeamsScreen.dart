import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/HackathonTeamListContract.dart';
import 'package:teamup/module/HackathonTeamListModel.dart';
import 'package:teamup/presenter/HackathonTeamListPresenter.dart';
import 'package:teamup/screen/HackathonTeamMemberScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';

class HackathonTeams extends StatefulWidget {
  String pId;

  HackathonTeams(this.pId);

  @override
  _HackathonTeamsState createState() => _HackathonTeamsState();
}

class _HackathonTeamsState extends State<HackathonTeams>
    implements HackathonTeamListContract {
  HackathonTeamListPresenter teamListPresenter;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;

  List<TeamList> teamList;

  _HackathonTeamsState() {
    teamListPresenter = new HackathonTeamListPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getList();
  }

  getList() {
    teamList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String pId = widget.pId;
        teamListPresenter
            .getList('Hackathon/GetTeamList?ProblemStatementId=$pId');
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
    getList();
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
        title: Text('Teams'),
      ),
      body: isInternetAvailable
          ? teamList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: teamList.length,
                          itemBuilder: (context, index) {
                            return TeamListDesign(
                                teamList[index].teamId.toString(),
                                teamList[index].teamName,
                                teamList[index].teamSize.toString());
                          }),
                    ],
                  )),
                )
              : Container(
                  child: Center(
                    child: Text(
                        isApiCallProcess ? 'Loading' : "Team's not available"),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget TeamListDesign(String teamId, String TeamName, String TeamSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HackathonMember(teamId))).then(getOnBack);
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Team Name : ',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Flexible(
                      child: new Container(
                        padding: new EdgeInsets.only(left: 8.0),
                        child: new Text(
                          TeamName,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Team Size : ',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Flexible(
                      child: new Container(
                        padding: new EdgeInsets.only(left: 8.0),
                        child: new Text(
                          TeamSize,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(HackathonTeamListModel hackathonTeamListModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (hackathonTeamListModel.status == 0) {
      teamList.addAll(hackathonTeamListModel.teamList);
    } else {
      toast().showToast(hackathonTeamListModel.message);
    }
  }
}
