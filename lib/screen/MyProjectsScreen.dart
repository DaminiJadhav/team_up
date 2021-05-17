import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/MyProjectListContract.dart';
import 'package:teamup/module/MyProjectListModel.dart';
import 'package:teamup/presenter/MyProjectListPresenter.dart';
import 'package:teamup/screen/MyProjectDetails.dart';
import 'package:teamup/screen/ProjectDetailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class MyProjects extends StatefulWidget {
  @override
  _MyProjectsState createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects>
    implements MyProjectListContract {
  MyProjectListPresenter presenter;

  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isDataAvailable = false;

  final searchController = TextEditingController();
  bool isSearchClick = false;

  List<MyProjectList> projectList;

  _MyProjectsState() {
    presenter = new MyProjectListPresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {});
    getMyProjects();
  }

  getMyProjects() {
    projectList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String userId = Preference.getUserId().toString();
        String isStd = Preference.getIsStudent() ? 'true' : 'false';
        presenter.getList(
            'Organizations/GetMyProjectList?UserId=$userId&IsStd=$isStd');
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    getMyProjects();
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
        title: Text('My Projects'),
      ),
      body: isInternetAvailable
          ? projectList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                      style: TextStyle(fontSize: 24.0),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 16.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/icons/closeaccount.png',
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0,right: 16.0),
                          child: Text(
                            'All the projects that i have done till date. Tap on the project to see more',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0,right:16.0),
                          child: AnimSearchBar(
                            rtl: false,
                            width: MediaQuery.of(context).size.width,
                            textController: searchController,
                            helpText: "Search Projects",
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
                            itemCount: projectList.length,
                            itemBuilder: (context, index) {
                              return newMainContainer(
                                  projectList[index].projectId.toString(),
                                     projectList[index].projectName,
                                     projectList[index].level,
                                     projectList[index].type,
                                     projectList[index].field,
                                     projectList[index].isApproved);


                            }),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isDataAvailable
                        ? isApiCallProcess ? '' : 'Projects not available.'
                        : ''),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget MainContaintDesign(String pId, String pName, String type, String field,
      String level, String submittedOn, bool isApproved) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
                MaterialPageRoute(builder: (context) => MyProjectDetails(pId)))
            .then(getOnBack);
      },
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRect(
            child: Banner(
              message: isApproved ? "Approved" : "Pending",
              location: BannerLocation.topEnd,
              color: isApproved ? Colors.green : Colors.red,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            pName,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Level: ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Flexible(
                                child: Text(
                                  level,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  'Type: ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  type,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Submitted On: ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  submittedOn != null ? submittedOn : 'NA',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Field: ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Flexible(
                                child: Text(
                                  field,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget newMainContainer(String id, String projectName,
      String levels, String type, String field, bool isApproved) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => MyProjectDetails(id)))
              .then(getOnBack);
        },
        child: Card(
          child: ClipRect(
            child: Banner(
              message: isApproved ? "Approved" : "Pending",
              location: BannerLocation.topEnd,
              color: isApproved ? Colors.green : Colors.red,
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
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                      //     child: Container(
                      //       decoration: new BoxDecoration(
                      //         color: Theme.of(context).primaryColor,
                      //         shape: BoxShape.rectangle,
                      //         borderRadius: new BorderRadius.circular(5.0),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(
                      //             left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               deadLine,
                      //               style: TextStyle(
                      //                   fontSize: 10.0,
                      //                   decoration: TextDecoration.underline,
                      //                   color: Colors.white),
                      //             ),
                      //             Text(
                      //               'Deadline',
                      //               style: TextStyle(
                      //                   color: Colors.white, fontSize: 8.0),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
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
  void showSuccess(MyProjectListModel projectListModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (projectListModel.status == 0) {
      setState(() {
        isDataAvailable = true;
      });
      projectList.addAll(projectListModel.myProjectList);
    } else {
      toast().showToast(projectListModel.message);
    }
  }
}
