import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:teamup/contract/MyNetworkContract.dart';
import 'package:teamup/module/MyNetworkModel.dart';
import 'package:teamup/presenter/MyNetworkPresenter.dart';
import 'package:teamup/screen/MyNetworkUserDetails.dart';
import 'package:teamup/screen/OrganizationPersonDettailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

import 'organizationscreens/MyNetworkOrgUser.dart';

class MyNetwork extends StatefulWidget {
  @override
  _MyNetworkState createState() => _MyNetworkState();
}

class _MyNetworkState extends State<MyNetwork> implements MyNetworkContract {
  MyNetworkPresenter myNetworkPresenter;

  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  checkInternet _checkInternet;
  String bodyMessage = "";


  final searchController = TextEditingController();
  bool isSearchClick = false;

  List<Member> networkList;

  _MyNetworkState() {
    myNetworkPresenter = new MyNetworkPresenter(this);
  }

  getMyNetworkList() {
    setState(() {
      isApiCallProcess = true;
    });
    bool isStd = Preference.getIsStudent();
    String userId = Preference.getUserId().toString();
    String stdId = isStd ? userId : "";
    String orgId = isStd ? "" : userId;
    String url = "ProjectTeamMembers/GetProjectMembers?std=$stdId&org=$orgId";
    myNetworkPresenter.getMyNetwork(url);
  }

  @override
  void initState() {
    super.initState();
    networkList = List();
    Preference.init();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getMyNetworkList();
      } else {
        setState(() {
          bodyMessage = "no internet connection available";
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
        title: Text('My Network'),
      ),
      body: isInternetAvailable
          ? isDataAvailableToLoad
              ? ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Your Network',
                                style: TextStyle(fontSize: 24.0),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/icons/mynetwork.png',
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 16.0, bottom: 16.0,right: 16.0),
                      child: Text(
                        'Keep Connecting. Keep Growing Keep Learning. Keep Building',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0,right:16.0),
                      child: AnimSearchBar(
                        rtl: false,
                        width: MediaQuery.of(context).size.width,
                        textController: searchController,
                        helpText: "Search Connection",
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

                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              networkList.isEmpty
                                  ? Container(
                                      child: Center(
                                        child: Text(
                                            'Members not available in your Network.'),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: networkList.length,
                                      itemBuilder: (context, index) {
                                        return cardDesign(
                                            networkList[index].Id.toString(),
                                            networkList[index].name,
                                            networkList[index].email,
                                            networkList[index].IsStudent,
                                            networkList[index].imageUrl);
                                      })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Center(
                    child: Text('Loading..'),
                  ),
                )
          : Container(
              child: Center(
                child: Text(bodyMessage),
              ),
            ),
    );
  }

  Widget cardDesign(
      String id, String name, String emailId, bool isStudent, String imageUrl) {
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).primaryColor,
      child: ListTile(
        onTap: () {
          if (isStudent) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyNetworkUserStd(id)));
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyNetworkOrgUser(id)));
          }
        },
        leading: Container(
          child: CircleAvatar(
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl)
                : AssetImage('assets/art/profile.png'),
            radius: 30.0,
          ),
        ),
        title: Text(name),
        subtitle: Text(emailId),
      ),
    );
  }

  @override
  void showMyNetworkError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, Please try again later...";
      isInternetAvailable = false;
    });
  }

  @override
  void showMyNetworkSuccess(MyNetworkModel myNetworkModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (myNetworkModel.status == 0) {
      networkList.addAll(myNetworkModel.members);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        bodyMessage = "Something went wrong, Please try again later...";
        isInternetAvailable = false;
      });
    }
  }
}
