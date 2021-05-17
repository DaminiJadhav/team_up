import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/HackathonProblemStatementDetailsContract.dart';
import 'package:teamup/module/HackathonProblemStatementDetailsModel.dart';
import 'package:teamup/presenter/HackathonProblemStatementDetailsPresenter.dart';
import 'package:teamup/screen/HackathonTeamMemberScreen.dart';
import 'package:teamup/screen/HackathonTeamsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';

import 'HackathonCreateTeamScreen.dart';

class HackathonProblemStatementDetails extends StatefulWidget {
  String problemId;
  String hackthonId;

  HackathonProblemStatementDetails(this.problemId, this.hackthonId);

  @override
  _HackathonProblemStatementDetailsState createState() =>
      _HackathonProblemStatementDetailsState();
}

class _HackathonProblemStatementDetailsState
    extends State<HackathonProblemStatementDetails>
    implements HackathonProblemStatementDetailsContract {
  HackathonProblemStatementDetailsPresenter detailsPresenter;
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  List<ProblemStatementDetails> problemDetailsList;
  List<TeamList> teamList;

  _HackathonProblemStatementDetailsState() {
    detailsPresenter = new HackathonProblemStatementDetailsPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getDetails();
  }

  getDetails() {
    problemDetailsList = new List();
    teamList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String pId = widget.problemId;
        String hId = widget.hackthonId;
        detailsPresenter.getDetails(
            'Hackathon/GetProblemStatementDetails?HackathonId=$hId&ProblemStatementId=$pId');
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
        title: Text('Problem Statement'),
      ),
      body: isInternetAvailable
          ? problemDetailsList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                        child: Text(
                          problemDetailsList[0].problemStatementHeading,
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          'Description ',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 4.0),
                        child: Text(
                          problemDetailsList[0].description,
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: Center(
                          child: Text(
                            'Existing Teams',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      teamList.isNotEmpty
                          ? TeamListDesign(
                              teamList[0].teamId.toString(),
                              teamList[0].teamName,
                              teamList[0].teamSize.toString())
                          : Container(
                              child: Center(
                                child: Text('Team Not Available'),
                              ),
                            ),
                      Visibility(
                        visible: teamList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(
                                'Show more',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            HackathonTeams(widget.problemId)))
                                    .then(getOnBack);
                              },
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Start Your own Team',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0,right: 16.0),
                        child: Text(
                          'Find people from around the globe to help you win the hackathon.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            child: Text(
                              'Create a Team',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          HackathonCreateTeamScreen(widget.problemId,widget.hackthonId)))
                                  .then(getOnBack);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? 'Loading'
                        : 'Something went wrong, Please try again later.'),
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
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => HackathonMember(teamId)))
              .then(getOnBack);
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
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
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
    toast().showToast('Something went wrong,Please try again later.');
  }

  @override
  void showSuccess(HackathonProblemStatementDetailsModel successModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (successModel.status == 0) {
      problemDetailsList.add(successModel.problemStatementDetails);
      teamList.addAll(successModel.problemStatementDetails.teamList);
    } else {
      toast().showToast(successModel.message);
    }
  }
}
