import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:teamup/contract/ForgetPasswordContract.dart';
import 'package:teamup/module/ForgetPasswordModel.dart';
import 'package:teamup/presenter/ForgetPasswordPresenter.dart';
import 'package:teamup/screen/ChangePassword.dart';
import 'package:teamup/utils/CheckInternet.dart';

import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    implements ForgetPasswordContract {
  bool isApiCallProcess = false;
  ForgetPasswordPresenter _forgetPasswordPresenter;
  ForgetPasswordRequestModel requestModel;
  checkInternet _checkInternet;
  String serverOTP = "";
  String enterOTP;
  String userId;
  String userType;

  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  String emailErrorMsg = "Please enter Email Id";

  bool validateEmail = false;
  bool validateNewPassword = false;
  bool validateConfirmNewPassword = false;

  _ForgotPasswordState() {
    _forgetPasswordPresenter = new ForgetPasswordPresenter(this);
  }

  validateData() {
    setState(() {
      emailErrorMsg = "Please enter Email Id";
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
    });
    if (!EmailValidator.validate(emailController.text.trim())) {
      setState(() {
        emailErrorMsg = "Please enter valid Email Id";
        validateEmail = true;
      });
      return false;
    }
    if (!validateEmail) {
      submit();
    }
  }

  submit() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.isStudent = Preference.getIsStudent();
    requestModel.isOrg = Preference.getIsOrganization();
    requestModel.isAdmin = false;
    requestModel.username = emailController.text.trim();

    _forgetPasswordPresenter.passwordForget(
        requestModel, 'Login/ForgetPassword');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    requestModel = new ForgetPasswordRequestModel();
    _checkInternet = new checkInternet();
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
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
            image: AssetImage('assets/art/Vector_Art_Full_Page.png'),
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.close,
                    size: 50.0,
                    color: Colors.white,
                  )),
            ),
          ),
          Image.asset(
            'assets/icons/forgotpassword.png',
            height: 100.0,
            width: 100.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Forgot your password?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0))),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'No Worries! Enter your email and \n ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).primaryColor,
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey[200]),
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                      controller: emailController,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          hintText: "Email Id",
                                          labelText: 'Email Id',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400]),
                                          errorText: validateEmail
                                              ? emailErrorMsg
                                              : null,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      loginButton(context),
                      SizedBox(
                        height: 60.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _checkInternet.check().then((value) {
          if (value != null && value) {
            validateData();
          } else {
            toast().showToast('Please check your internet connection.');
          }
        });
      },
      child: Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  void showForgetPasswordError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showForgetPasswordSuccess(
      ForgetPasswordResponseModel forgetPasswordResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (forgetPasswordResponseModel.status == 0) {
      setState(() {
        serverOTP = forgetPasswordResponseModel.otp;
        userId = forgetPasswordResponseModel.id.toString();
        userType = forgetPasswordResponseModel.user;
      });
      // print(serverOTP);
      toast().showToast('OTP sent successfully');
      displayBottomSheet(context);
    } else {
      toast().showToast(forgetPasswordResponseModel.message);
    }
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        builder: (ctx) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Please enter the 4 Digit Code ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: PinEntryTextField(
                      onSubmit: (String pin) {
                        setState(() {
                          enterOTP = pin;
                        });
                        validateOtp();
                      }, // end onSubmit
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text('Resend OTP',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular.ttf',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Theme.of(context).primaryColorLight,
                              )),
                        ),
                        // Countdown(
                        //   seconds: 120,
                        //   build: (_, double time) => Text(
                        //     time.toString(),
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        //   interval: Duration(milliseconds: 60),
                        //   onFinished: () {
                        //     setState(() {
                        //       isTimeEnd = true;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Text('Resend OTP',
                  //       style: TextStyle(
                  //         fontFamily: 'Poppins-Regular.ttf',
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 12,
                  //         color: Theme.of(context).primaryColorLight,
                  //       )),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 110.0, right: 110.0, top: 8.0, bottom: 8.0),
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: RaisedButton(
                  //       color: Theme.of(context).primaryColor,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       onPressed: () {
                  //         _checkInternet.check().then((value) {
                  //           if (value != null && value) {
                  //             validateOtp();
                  //           } else {
                  //             toast().showToast(
                  //                 'Please check your internet connection..');
                  //           }
                  //         });
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(12.0),
                  //         child: new Text(
                  //           "Verify",
                  //           style: TextStyle(
                  //               color: Theme.of(context).primaryColorLight,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  validateOtp() {
    if (serverOTP == enterOTP) {
      toast().showToast('OTP verified Successfully.');
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChangePassword(userId)));
    } else {
      toast().showToast('Invalid OTP.');
    }
  }
}
