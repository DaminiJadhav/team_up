import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/OnGoingProjectContract.dart';
import 'package:teamup/module/OnGoingProjectModel.dart';
import 'package:teamup/presenter/OnGoingProjectPresenter.dart';
import 'package:teamup/screen/AddProjectOrganization.dart';
import 'package:teamup/screen/AddProjectScreen.dart';
import 'package:teamup/screen/OrgProjectDetailsScreen.dart';
import 'package:teamup/screen/ProjectDetailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class projects extends StatefulWidget {
  @override
  _projectsState createState() => _projectsState();
}

class _projectsState extends State<projects> implements OnGoingProjectContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isDataAvailableToLoad = false;
  String bodyMessage = "";

  final searchController = TextEditingController();
  bool isSearchClick = false;

  checkInternet _checkInternet;
  OnGoingProjectPresenter onGoingProjectPresenter;

  List<Project> projectList;

  _projectsState() {
    onGoingProjectPresenter = OnGoingProjectPresenter(this);
  }

  searchProject(String projectName) {
    setState(() {
      isSearchClick = true;
    });
    print('Search is Ok');
  }

  getOnGoingProjectList() {
    bool isStd = Preference.getIsStudent();
    bool isOrg = Preference.getIsOrganization();
    String userId = Preference.getUserId().toString();
    String stdUserId = isStd ? userId : '';
    String orgUserId = isOrg ? userId : '';
    setState(() {
      isApiCallProcess = true;
    });
    onGoingProjectPresenter.getOnProjectList(
        "ProjectDetails/GetOnGoingProject?StdId=$stdUserId&OrgId=$orgUserId");
  }

  Future onBack(dynamic value) {
    projectList = List();
    setState(() {});
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getOnGoingProjectList();
      } else {
        setState(() {
          bodyMessage = "Please check your internet connection...";
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        projectList = List();
        getOnGoingProjectList();
      } else {
        setState(() {
          bodyMessage = "Please check your internet connection...";
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
      body: isInternetAvailable
          ? isDataAvailableToLoad
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, left: 16.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'My Projects',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                'assets/icons/project.png',
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
                        helpText: "Search Projects",
                        suffixIcon: isSearchClick ? Icons.clear : Icons.search,
                        onSuffixTap: () {
                          if (isSearchClick) {
                            setState(() {
                              searchController.text = "";
                              isSearchClick = false;
                            });
                          } else {
                            setState(() {
                              searchController.text.isNotEmpty
                                  ? searchProject(
                                      searchController.text.toString().trim())
                                  : toast()
                                      .showToast('Please enter project name.');
                              // isSearchClick = !isSearchClick;
                              // searchController.clear();
                            });
                          }
                        },
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 0.0),
                      child: Center(
                        child: Text(
                          'My On-Going Project',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    projectList.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Center(
                                child: Text(
                                  'On going projects not available yet.',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: projectList.length,
                                  itemBuilder: (context, index) {
                                    return newMainContainer(
                                        projectList[index].id.toString(),
                                        projectList[index].projectname,
                                        projectList[index].endDate,
                                        projectList[index].levels,
                                        projectList[index].type,
                                        projectList[index].field);
                                    // MainContaintDesign(
                                    //   projectList[index].id.toString(),
                                    //   projectList[index].projectname,
                                    //   projectList[index].levels,
                                    //   projectList[index].endDate,
                                    //   projectList[index].description,
                                    //   projectList[index].type,
                                    //   projectList[index].field);
                                  })
                            ],
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
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Preference.getIsOrganization()
              ? Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => AddProjectOrganization(),
                  ))
                  .then(onBack)
              : Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => AddProject(),
                  ))
                  .then(onBack);
        },
        tooltip: 'Add New Project',
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 40.0,
        ),
      ),
    );
  }

  Widget newMainContainer(String id, String projectName, String deadLine,
      String levels, String type, String field) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => ProjectScreen(id, true)))
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
                      projectName,
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
                                deadLine,
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
                              levels,
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
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
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
                              type,
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
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
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
                              field,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Text(
                            'Field',
                            style: TextStyle(fontSize: 10.0),
                          )
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
  void showOnGoingProjectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, Please try again later..";
      isInternetAvailable = false;
    });
  }

  @override
  void showOnGoingProjectSuccess(OnGoingProjectModel success) {
    setState(() {
      isApiCallProcess = false;
    });
    if (success.status == 0) {
      projectList.addAll(success.project);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        bodyMessage = "Something went wrong, Please try again later..";
        isInternetAvailable = true;
        isDataAvailableToLoad = true;
      });
    }
  }
}
