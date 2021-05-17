import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:teamup/contract/CloseAccountContract.dart';
import 'package:teamup/module/CloseAccountModel.dart';
import 'package:teamup/presenter/CloseAccountPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class CloseAccount extends StatefulWidget {
  @override
  _CloseAccountState createState() => _CloseAccountState();
}

class _CloseAccountState extends State<CloseAccount>
    implements CloseAccountContract {
  CloseAccountPresenter closeAccountPresenter;
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool _passwordVisible = true;
  CloseAccountRequestModel closeAccountRequestModel;

  final reasonController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String emailErrorMsg = "Please enter Email Id";

  bool validateReason = false;
  bool validateEmail = false;
  bool validatePassword = false;

  _CloseAccountState() {
    closeAccountPresenter = new CloseAccountPresenter(this);
  }

  validateData() {
    setState(() {
      reasonController.text.isEmpty
          ? validateReason = true
          : validateReason = false;
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
      passwordController.text.isEmpty
          ? validatePassword = true
          : validatePassword = false;
    });

    if (!EmailValidator.validate(emailController.text.trim())) {
      setState(() {
        emailErrorMsg = "Please enter valid Email Id";
        validateEmail = true;
      });
      return false;
    }
   if(!validateReason && !validateEmail && !validatePassword){
     submitData();
   }
  }

  submitData() {
    closeAccountRequestModel.id = Preference.getUserId();
    closeAccountRequestModel.email = emailController.text.trim();
    closeAccountRequestModel.password = passwordController.text.trim();
    closeAccountRequestModel.isStudent = Preference.getIsStudent();
    closeAccountRequestModel.isOrg = Preference.getIsOrganization();
    closeAccountRequestModel.reason = reasonController.text.trim();
    setState(() {
      isApiCallProcess= true;
    });
    closeAccountPresenter.closeAcc(closeAccountRequestModel, 'Students/PutCloseAccount');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    emailController.text=Preference.getUserEmail();
    _checkInternet = new checkInternet();
    closeAccountRequestModel = new CloseAccountRequestModel();
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
        title: Text('Deactivate Account'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Deactivate Account',
                            style: TextStyle(fontSize: 24.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/icons/closeaccount.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 8.0,right: 24.0),
              child: Text(
                'We are sorry to hear that from you. You will be remembered always.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 32.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: FormFieldWidget(),
            ),
            Center(
                child: Text(
              'Your account will be de-activate temporarily.',
              style: TextStyle(fontSize: 16.0),
            )),
            Center(
                child: Text(
              'To Re-Activate account contact to Admin',
              style: TextStyle(fontSize: 16.0),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Image.asset('assets/icons/closeaccountbye.png')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Good Bye!',
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
            ),
            FormSubmitButto(),
          ],
        ),
      ),
    );
  }

  Widget FormFieldWidget() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: 'Reason for closing',
                  labelText: 'Reason for closing',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: validateReason ? "Please enter Reason" : null,
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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email:Eg abc@pqr.com',
                  labelText: 'Email',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: validateEmail ? emailErrorMsg : null,
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
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: TextField(
                controller: passwordController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: validatePassword ? "Please enter Password" : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget FormSubmitButto() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          _checkInternet.check().then((value) {
            if (value != null && value) {
              validateData();
            } else {
              toast().showToast('Please check your internet connection...');
            }
          });
        },
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              'Deactivate Account',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showCloseAccountError(FetchException exception) {
    print(exception.toString());
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showCloseAccountSuccess(CloseAccountResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      setState(() {
        Preference.setIsLogin(false);
      });
      toast().showToast(
          "Your account has been closed successfully. I'll Miss you !...");
      Future.delayed(const Duration(milliseconds: 5000), () {
        exit(0);
      });
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
