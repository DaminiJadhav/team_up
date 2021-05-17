import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/LeaveProjectContract.dart';
import 'package:teamup/module/LeaveProjectModel.dart';
import 'package:teamup/presenter/LeaveProjectPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class LeaveProject extends StatefulWidget {
  String pId;

  LeaveProject(this.pId);

  @override
  _LeaveProjectState createState() => _LeaveProjectState();
}

class _LeaveProjectState extends State<LeaveProject>
    implements LeaveProjectContract {
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  LeaveProjectRequestModel leaveProjectRequestModel;
  LeaveProjectPresenter leaveProjectPresenter;

  //Controller
  final confirmationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //validation
  bool validateConfirmation = false;
  bool validateEmail = false;
  bool validatePassword = false;

  _LeaveProjectState() {
    leaveProjectPresenter = new LeaveProjectPresenter(this);
  }

  validateData() {
    setState(() {
      confirmationController.text.isEmpty
          ? validateConfirmation = true
          : validateConfirmation = false;
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
      passwordController.text.isEmpty
          ? validatePassword = true
          : validatePassword = false;
    });
    if (confirmationController.text.toString().trim().toUpperCase() != 'YES') {
      toast().showToast('Please Give a confirmation Yes to Leave the Project');
      return false;
    }
    // if (confirmationController.text.toString().trim() != 'Yes') {
    //   toast().showToast('Please Give a confirmation Yes to Leave the Project');
    //   return false;
    // }
    // if (confirmationController.text.toString().trim() != 'YES') {
    //   toast().showToast('Please Give a confirmation Yes to Leave the Project');
    //   return false;
    // }
    leaveProject();
  }

  leaveProject() {
    setState(() {
      isApiCallProcess = true;
    });
    leaveProjectRequestModel.projectId = widget.pId;
    leaveProjectRequestModel.isStd = Preference.getIsStudent() ? true : false;
    leaveProjectRequestModel.userId = Preference.getUserId().toString();
    leaveProjectRequestModel.confirmation =
        confirmationController.text.toString().trim().toUpperCase();
    leaveProjectRequestModel.email = emailController.text.toString().trim();
    leaveProjectRequestModel.password =
        passwordController.text.toString().trim();

    leaveProjectPresenter.projectLeave(
        leaveProjectRequestModel, 'ProjectDetails/LeaveProject');
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
    emailController.text = Preference.getUserEmail();
    confirmationController.text = "YES";
    leaveProjectRequestModel = new LeaveProjectRequestModel();
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
        title: Text('Leave Project'),
      ),
      body: isInternetAvailable
          ? Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Terminate Project',
                                style: TextStyle(fontSize: 24.0),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, right: 16.0),
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
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, top: 16.0),
                    child: Text(
                      'We are sorry to hear that from you!',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'You will lose access to the project and chats',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Are you sure?',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 8.0),
                    child: TextField(
                      enabled: false,
                      controller: confirmationController,
                      decoration: InputDecoration(
                        hintText: "Type Yes for confirmation",
                        labelText: "Confirmation",
                        hintStyle: TextStyle(color: Colors.black),
                        errorText: validateConfirmation
                            ? 'Please give a confirmation Yes or No'
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 8.0),
                    child: TextField(
                      enabled: false,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        hintStyle: TextStyle(color: Colors.black),
                        errorText: validateEmail
                            ? 'Please enter valid Email Id'
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        errorText: validatePassword
                            ? 'Please enter valid Password'
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Text(
                    'Have a nice day!',
                    style: TextStyle(fontSize: 18.0),
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom: 12.0),
                        child: Text(
                          'Leave',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        _checkInternet.check().then((value) {
                          if (value != null && value) {
                            validateData();
                          } else {
                            toast().showToast('No Internet Connection');
                          }
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0),
                    child: FlatButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom: 12.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
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
    DialogHelper.Error(context, 'Leave Project',
        'Something went wrong, While Leaving the Project');
  }

  @override
  void showSuccess(LeaveProjectResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      Navigator.of(context).pop();
      DialogHelper.Success(context, 'Leave Project', responseModel.message);
    } else {
      DialogHelper.Error(context, 'Leave Project', responseModel.message);
    }
  }
}
