import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/GetHackathonDetailsContract.dart';
import 'package:teamup/module/GetHackathonDetailsModel.dart';
import 'package:teamup/presenter/GetHackathonDetailsPresenter.dart';
import 'package:teamup/screen/HackathonProblemStatementDetailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HackathonDetails extends StatefulWidget {
  String title;
  String hackathonId;

  HackathonDetails(this.title, this.hackathonId);

  @override
  _HackathonDetailsState createState() => _HackathonDetailsState();
}

class _HackathonDetailsState extends State<HackathonDetails>
    implements GetHackathonDetailsContract {
  GetHackathonDetailsPresenter hackathonDetailsPresenter;
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  List<HackathonList> hackathonDetailsList;
  List<NoOfProblemStatement> problemStatementList;
  bool isShowMore = true;
  int showLine = 4;

  _HackathonDetailsState() {
    hackathonDetailsPresenter = new GetHackathonDetailsPresenter(this);
  }

  getDetails() {
    hackathonDetailsList = new List();
    problemStatementList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String hackathonId = widget.hackathonId;
        hackathonDetailsPresenter.hackathonDetails(
            'Hackathon/GetHackathonDetails?HackathonId=$hackathonId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  getOnBack(dynamic valaue) {
    setState(() {});
    getDetails();
  }

  launchURL(final String newUrl) async {
    String url = 'https://' + newUrl;
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
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
        title: Text('Hackathon Details'),
      ),
      body: isInternetAvailable
          ? hackathonDetailsList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                            maxLines: 3,
                          ),
                        ),
                      ),

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                                visible: hackathonDetailsList[0].description.length > 300 ? true : false,
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
                          padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                          child: Text(
                            hackathonDetailsList[0].description,
                            textAlign: TextAlign.justify,
                            maxLines: showLine,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      // Start Date and End Date.
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                                      hackathonDetailsList[0].startDate,
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
                                      hackathonDetailsList[0].endDate,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'End Date',
                                        style: TextStyle(fontSize: 10.0),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: hackathonDetailsList[0].website != null
                            ? true
                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 16.0, bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              launchURL(hackathonDetailsList[0].website);
                            },
                            child: Container(
                              height: 50.0,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text(
                                  'website',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "Problem Statement",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      problemStatementList.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: problemStatementList.length,
                              itemBuilder: (context, index) {
                                return ProblemStatementDesign(
                                    problemStatementList[index]
                                        .problemStatementId
                                        .toString(),
                                    problemStatementList[index]
                                        .problemStatementHeading,
                                    problemStatementList[index]
                                        .teamSize
                                        .toString());
                              })
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Center(
                                  child:
                                      Text('Problem Statement not uploaded.'),
                                ),
                              ),
                            )
                    ]))
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? ''
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

  Widget ProblemStatementDesign(
      String pId, String problemStatement, String teamCount) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => HackathonProblemStatementDetails(
                      pId, widget.hackathonId)))
              .then(getOnBack);
        },
        child: Card(
          elevation: 25.0,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  problemStatement,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Team Enrolled : ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        teamCount,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  )),
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
  void showSuccess(GetHackathonDetailsModel hackathonDetailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (hackathonDetailsModel.status == 0) {
      hackathonDetailsList.add(hackathonDetailsModel.hackathonList);
      problemStatementList
          .addAll(hackathonDetailsModel.hackathonList.noOfProblemStatement);
    } else {
      toast().showToast('Something went wrong, Please try again later');
    }
  }
}
