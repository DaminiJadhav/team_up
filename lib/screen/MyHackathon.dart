import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/MyHackathonListContract.dart';
import 'package:teamup/module/MyHackathonListModel.dart';
import 'package:teamup/presenter/MyHackathonListPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

import 'HackathonDetailsScreen.dart';

class MyHackathon extends StatefulWidget {
  @override
  _MyHackathonState createState() => _MyHackathonState();
}

class _MyHackathonState extends State<MyHackathon>
    implements MyHackathonListContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;

  final searchController = TextEditingController();
  bool isSearchClick = false;

  List<ListOfMyHackathon> hackathonList;

  //Presenter
  MyHackathonListPresenter myHackathonListPresenter;

  _MyHackathonState() {
    myHackathonListPresenter = new MyHackathonListPresenter(this);
  }

  getList() {
    hackathonList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String userId = Preference.getUserId().toString();
        myHackathonListPresenter
            .getMyList('Hackathon/GetListOfMyHackathon?OrgId=$userId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  getOnBack(dynamic value) {
    setState(() {});
    getList();
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
        title: Text('My Hackathon'),
      ),
      body: isInternetAvailable
          ? hackathonList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Hackathon & Competition',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                        ),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 16.0),
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
                          padding: const EdgeInsets.only(
                              left: 24.0, bottom: 4.0, top: 8.0),
                          child: Text(
                            'Hackathon & Competition',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: AnimSearchBar(
                            rtl: false,
                            width: MediaQuery.of(context).size.width,
                            textController: searchController,
                            helpText: "Search Hackathon",
                            suffixIcon:
                                isSearchClick ? Icons.clear : Icons.search,
                            onSuffixTap: () {
                              setState(() {
                                isSearchClick = !isSearchClick;
                                searchController.clear();
                              });
                            },
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: hackathonList.length,
                            itemBuilder: (context, index) {
                              return newMainContainer(
                                  hackathonList[index].hackathonId.toString(),
                                  hackathonList[index].hackathonName,
                                  hackathonList[index].lastDate,
                                  hackathonList[index]
                                      .problemStatementCount
                                      .toString(),
                                  hackathonList[index]
                                      .registeredTeamCount
                                      .toString(),
                              hackathonList[index].winningPrice);
                            })
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? ''
                        : 'Your hackathon is not available.'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget newMainContainer(String id, String hackathonTitle, String lastDate,
      String pCount, String teamRegi,String winningPrice) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => HackathonDetails(hackathonTitle, id)))
              .then(getOnBack);
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
                            pCount != null ? pCount : '0',
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
                            teamRegi != null ? teamRegi : '0',
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
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(MyHackathonListModel listModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (listModel.status == 0) {
      hackathonList.addAll(listModel.listOfMyHackathon);
    } else {
      toast().showToast(listModel.message);
    }
  }
}
