import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:teamup/contract/AllHackathonContract.dart';
import 'package:teamup/module/AllHackathonModel.dart';
import 'package:teamup/presenter/AllHackathonPresenter.dart';
import 'package:teamup/screen/AddHackathonScreen.dart';
import 'package:teamup/screen/HackathonDetailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

class HackathonScreen extends StatefulWidget {
  @override
  _HackathonScreenState createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen>
    implements AllHackathonContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isDataAvailableToLoad = false;
  String bodyMessage = "Loading...";

  final searchController = TextEditingController();
  bool isSearchClick = false;

  checkInternet _checkInternet;
  AllHackathonPresenter hackathonPresenter;
  List<HackathonList> hackathonList;

  _HackathonScreenState() {
    hackathonPresenter = new AllHackathonPresenter(this);
  }

  getHackathonList() {
    hackathonList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        hackathonPresenter.getListHackathon('Hackathon/GetAllHackathon');
      } else {
        setState(() {
          bodyMessage = "Please check your internet connection";
          isInternetAvailable = false;
        });
      }
    });
  }

  Future onBack(dynamic value) {
    setState(() {});
    getHackathonList();
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    getHackathonList();
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
      body: isInternetAvailable
          ? isDataAvailableToLoad
              ? ListView(
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
                                    'Hackathon & Competition',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                    ),
                                    maxLines: 2,
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                'assets/icons/hackathon.png',
                                height: 30.0,
                                width: 30.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AnimSearchBar(
                        rtl: false,
                        width: MediaQuery.of(context).size.width,
                        textController: searchController,
                        helpText: "Search Hackathon",
                        suffixIcon: isSearchClick ? Icons.clear : Icons.search,
                        onSuffixTap: () {
                          setState(() {
                            isSearchClick = !isSearchClick;
                            searchController.clear();
                          });
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only( bottom: 4.0,left:0.0),
                      child: Center(
                        child: Text(
                          'Upcoming Hackathon & Competition',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    hackathonList.isNotEmpty
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: hackathonList.length,
                            itemBuilder: (context, index) {
                              return newMainContainer(
                                  hackathonList[index].hackathonId.toString(),
                                  hackathonList[index].hackathonName,
                                  hackathonList[index].lastDate,
                                  hackathonList[index].winningPrice,
                              hackathonList[index].problemStatementCount.toString(),
                              hackathonList[index].registeredTeamCount.toString());
                            })
                        : Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top:50.0),
                              child: Center(
                                child: Text('Currently Hackathon not available.',style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                  ],
                )
              : Container(
                  child: Center(
                    child: Text(''),
                  ),
                )
          : Container(
              child: Center(
                child: Text(bodyMessage),
              ),
            ),
      floatingActionButton: Preference.getIsOrganization()
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) => AddHackathon(),
                    ))
                    .then(onBack);
              },
              tooltip: 'Add New Hackathon',
              child: Icon(Icons.add, color: Theme.of(context).primaryColor,size: 40.0,),
            )
          : null,
    );
  }

  Widget newMainContainer(String id, String hackathonTitle, String lastDate, String winningPrice,String pCount,String teamRegi) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => HackathonDetails(hackathonTitle, id)))
              .then(onBack);
        },
        child: Card(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          hackathonTitle,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: Column(
                            children: [
                              Text(
                                lastDate,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    decoration: TextDecoration.underline,
                                    color: Colors.white),
                              ),
                              Text(
                                'Deadline',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 8.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            winningPrice !=null ? winningPrice : 'NA',
                            style: TextStyle(fontSize: 14.0),
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
                            'Winning Price',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          pCount!=null ? pCount : '0',
                            style: TextStyle(fontSize: 14.0),
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
                              'Problem Statement',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            teamRegi!=null ? teamRegi : '0',
                            style: TextStyle(fontSize: 14.0),
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
                              "Team Registered",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
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
      bodyMessage = "Something went wrong, please try again later";
      isInternetAvailable = false;
    });
  }

  @override
  void showSuccess(AllHackathonModel hackathonModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (hackathonModel.status == 0) {
      hackathonList.addAll(hackathonModel.hackathonList);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        bodyMessage = hackathonModel.message;
        isInternetAvailable = false;
      });
    }
  }
}
