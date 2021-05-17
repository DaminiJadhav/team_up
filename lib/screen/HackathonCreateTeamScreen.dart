import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/CreateTeamContract.dart';
import 'package:teamup/module/CreateTeamModel.dart';
import 'package:teamup/presenter/CreateTeamPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

class HackathonCreateTeamScreen extends StatefulWidget {
  String problemStatementId;
  String hackathonId;

  HackathonCreateTeamScreen(this.problemStatementId, this.hackathonId);

  @override
  _HackathonCreateTeamScreenState createState() =>
      _HackathonCreateTeamScreenState();
}

class _HackathonCreateTeamScreenState extends State<HackathonCreateTeamScreen>
    implements CreateTeamContract {
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  CreateTeamRequestModel requestModel;
  CreateTeamPresenter createTeamPresenter;

  //Controller
  final nameController = TextEditingController();
  final statementController = TextEditingController();
  final teamSizeController = TextEditingController();

  //validation
  bool validateName = false;
  bool validateStatement = false;
  bool validateTeamSize = false;

  _HackathonCreateTeamScreenState() {
    createTeamPresenter = new CreateTeamPresenter(this);
  }

  validate() {
    setState(() {
      nameController.text.isEmpty ? validateName = true : validateName = false;
      statementController.text.isEmpty
          ? validateStatement = true
          : validateStatement = false;
      teamSizeController.text.isEmpty
          ? validateTeamSize = true
          : validateTeamSize = false;
    });
    if (!validateName && !validateStatement && !validateTeamSize) {
      createTeam();
    }
  }

  createTeam() {
    requestModel = new CreateTeamRequestModel();
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.problemStatementId = widget.problemStatementId;
    requestModel.hackathonId = widget.hackathonId;
    requestModel.teamName = nameController.text.toString().trim();
    requestModel.statement = statementController.text.toString().trim();
    requestModel.teamSize = teamSizeController.text.toString().trim();
    requestModel.createdByUserId = Preference.getUserId().toString();
    requestModel.createdByIsStd = Preference.getIsStudent() ? true : false;

    createTeamPresenter.createNewTeam(requestModel, 'Hackathon/CreateTeam');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
      } else {
        setState(() {
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
        title: Text('New Team'),
      ),
      body: isInternetAvailable
          ? Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create Your Own Team',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Team Name',
                            labelText: 'Team Name',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateName ? "Please enter Team Name" : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: statementController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Team Statement',
                            labelText: 'Statement',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateStatement
                                ? "Please enter Team Statement"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: teamSizeController,
                          decoration: InputDecoration(
                            hintText: 'Team Member Size',
                            labelText: 'Member Size',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateTeamSize
                                ? "Please enter Team Member Size"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        _checkInternet.check().then((value) {
                          if (value != null && value) {
                            setState(() {
                              isInternetAvailable = true;
                            });
                            validate();
                          } else {
                            setState(() {
                              isInternetAvailable = false;
                            });
                          }
                        });
                      },
                      child: Container(
                        height: 50.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    )
                  ],
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

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogHelper.Error(
        context, 'Create Team', 'Something went wrong, Please try again later');
  }

  @override
  void showSuccess(CreateTeamResponseModel createTeamResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (createTeamResponseModel.status == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
      DialogHelper.Success(
          context, 'Create Team', createTeamResponseModel.message);
    } else {
      DialogHelper.Error(
          context, 'Create Team', createTeamResponseModel.message);
    }
  }
}
