import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teamup/contract/AddMemberContract.dart';
import 'package:teamup/contract/AllMemberListContract.dart';
import 'package:teamup/module/AddMemberModel.dart';
import 'package:teamup/module/AllMemberListModel.dart';
import 'package:teamup/presenter/AddMemberPresenter.dart';
import 'package:teamup/presenter/AllMemberListPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddMember extends StatefulWidget {
  String pId;

  AddMember(this.pId);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember>
    implements AllMemberListContract, AddMemberContract {
  AllMemberListPresenter allMemberListPresenter;
  AddMemberPresenter addMemberPresenter;
  AddMemberRequestModel addMemberRequestModel;

  String radioSelectedValue = "Organization";
  List listForRadio = ["Organization", "Student"];
  String selectedId = "0";

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  bool isDataAvailableToLoad = false;
  String bodyMessage = "";

  bool addButtonVisibility = false;
  String clickedUserId = "";
  bool isItemSelected = false;

  String memberId = "", memberName = "";
  bool isMemberStd = false;
  bool isMemberOrg = false;

  List<Member> memberList;

  _AddMemberState() {
    allMemberListPresenter = new AllMemberListPresenter(this);
    addMemberPresenter = new AddMemberPresenter(this);
  }

  shoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirm",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: Text(
            'Are you sure? Do you want to add $memberName to your Project?'),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              setState(() {
                addButtonVisibility = false;
              });
              Navigator.of(context).pop(false);
            },
          ),
          new FlatButton(
              onPressed: () {
                addMember();
                Navigator.of(context).pop();
              },
              child: Text('Yes'))
        ],
      ),
    );
  }

  addMember() {
    addMemberRequestModel.projectId = widget.pId;
    addMemberRequestModel.memberId = memberId;
    addMemberRequestModel.memberIsOrg = isMemberOrg ? "true" : "";
    addMemberRequestModel.memberIsFaculty = "";
    addMemberRequestModel.memberIsStudent = isMemberOrg ? '' : "true";
    addMemberRequestModel.addedById = Preference.getUserId().toString();
    addMemberRequestModel.addedByOrg =
        Preference.getIsOrganization() ? "true" : "";
    addMemberRequestModel.addedByStudent =
        Preference.getIsStudent() ? "true" : "";
    addMemberRequestModel.addedByFaculty = "";
    setState(() {
      isApiCallProcess = true;
      addButtonVisibility = false;
    });
    addMemberPresenter.addMemberToProject(
        addMemberRequestModel, "ProjectTeamMembers/PostProjectTeamMember");
  }

  getMemberList() {
    setState(() {
      memberList.clear();
      isDataAvailableToLoad = false;
      isApiCallProcess = true;
    });
    String pId = widget.pId;
    String subUrl = selectedId == "0"
        ? "Organizations/GetAllOrganization?ProjectId=$pId"
        : "Students/GetAllStudent?ProjectId=$pId";
    allMemberListPresenter.getAllMember(subUrl);
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    memberList = List();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getMemberList();
      } else {
        setState(() {
          bodyMessage = "Please check your internet connection...";
          isInternetAvailable = false;
        });
      }
    });
    addMemberRequestModel = new AddMemberRequestModel();
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
        title: Text('Add Member'),
      ),
      body: isInternetAvailable
          ? isDataAvailableToLoad
              ? Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Select User Type ',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          addRadioButton(0, 'Organization'),
                          addRadioButton(1, 'Student'),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                memberList.isNotEmpty
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: memberList.length,
                                        itemBuilder: (context, index) {
                                          return cardDesign(
                                              memberList[index].id.toString(),
                                              memberList[index].name,
                                              memberList[index].isStudent);
                                        })
                                    : Container(
                                        child: Center(
                                          child: Text('Member not available.'),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: addButtonVisibility,
                      //   child: Container(
                      //     child: Align(
                      //       alignment: FractionalOffset.bottomCenter,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           _checkInternet.check().then((value) {
                      //             if (value != null && value) {
                      //               shoDialog();
                      //             } else {
                      //               toast().showToast(
                      //                   'Please check your internet connection...');
                      //             }
                      //           });
                      //         },
                      //         child: Container(
                      //             height: Platform.isIOS ? 70 : 60,
                      //             alignment: Alignment.center,
                      //             width: MediaQuery.of(context).size.width,
                      //             color: Theme.of(context).primaryColor,
                      //             child: Text('Add',
                      //                 style:
                      //                     Theme.of(context).textTheme.title)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                )
          : Container(
              child: Center(
                child: Text(bodyMessage),
              ),
            ),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: listForRadio[btnValue],
          groupValue: radioSelectedValue,
          onChanged: (value) {
            setState(() {
              radioSelectedValue = value;
              radioSelectedValue == "Organization"
                  ? selectedId = "0"
                  : selectedId = "1";
              getMemberList();
              // addButtonVisibility = false;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Widget cardDesign(String id, String name, bool isStudent) {
    return Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          onTap: () {
            setState(() {
              // addButtonVisibility = true;
              memberId = id;
              memberName = name;
              if (selectedId == "0") {
                isMemberOrg = true;
              } else {
                isMemberStd = true;
              }
            });
            _checkInternet.check().then((value) {
              if (value != null && value) {
                shoDialog(context);
              } else {
                toast().showToast('Please check your internet connection...');
              }
            });
          },
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              name[0],
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          title: Text(name),
        ),
      ),
    );
  }

  @override
  void showAllMemberError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, Please try again later...";
      isInternetAvailable = false;
    });
  }

  @override
  void showAllMemberSuccess(AllMemberListModel allMemberListModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (allMemberListModel.status == 0) {
      memberList.addAll(allMemberListModel.member);
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

  @override
  void showAddMemberError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showAddMemberSuccess(AddMemberResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast('Member Added Successfully...');
      getMemberList();
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
