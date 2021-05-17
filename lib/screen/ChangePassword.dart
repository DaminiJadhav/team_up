import 'package:flutter/material.dart';
import 'package:teamup/contract/UpdatePasswordContract.dart';
import 'package:teamup/module/UpdatePasswordModel.dart';
import 'package:teamup/presenter/UpdatePasswordPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class ChangePassword extends StatefulWidget {
  String id;

  ChangePassword(this.id);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    implements UpdatePasswordContract {
  UpdatePasswordPresenter updatePasswordPresenter;
  UpdatePasswordRequestModel requestModel;

  bool isApiCallProcess = false;

  checkInternet _checkInternet;
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool validateConfirmPassword = false;
  bool validateNewPassword = false;
  bool _passwordVisible = true;

  String newPassword = 'Please enter new password';
  String errorConfirmPassword = 'Please enter confirm password';

  _ChangePasswordState() {
    updatePasswordPresenter = new UpdatePasswordPresenter(this);
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  updatePassword() {
    setState(() {
      newPassword = 'Please enter new password';
      errorConfirmPassword = 'Please enter confirm password';
      newPasswordController.text.isEmpty
          ? validateNewPassword = true
          : validateNewPassword = false;
      confirmPasswordController.text.isEmpty
          ? validateConfirmPassword = true
          : validateConfirmPassword = false;
    });
    if (confirmPasswordController.text.trim() !=
        newPasswordController.text.trim()) {
      setState(() {
        errorConfirmPassword = "Password does not match.";
        validateConfirmPassword = true;
      });
    } else {
      setState(() {
        validateConfirmPassword = false;
      });
    }
    if (!validatePassword(newPasswordController.text.trim())) {
      setState(() {
        newPassword =
            'Password should be 1 Character, 1 Number, 1 Special character';
        validateNewPassword = true;
        validateConfirmPassword = true;

      });
      toast().showToast('Password should be alphanumeric, include 1 number and 1 alphabet and 1 special character');
      return false;
    }
    if (!validateNewPassword && !validateConfirmPassword) {
      update();
    }
  }

  update() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.id = widget.id;
    requestModel.password = newPasswordController.text.toString().trim();
    requestModel.isStudent = Preference.getIsStudent();
    requestModel.isorg = Preference.getIsOrganization();
    updatePasswordPresenter.updatePassword(
        requestModel, 'Login/UpdatePassword');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new UpdatePasswordRequestModel();
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
        title: Text('Change Password'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Change Password',
                            style: TextStyle(fontSize: 28.0),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'assets/icons/changepersonaldetails.png',
                          height: 70.0,
                          width: 70.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                child: Text(
                  'Please enter correct details.\n We will update for you!.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
                child: TextField(
                    controller: newPasswordController,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      labelText: 'New Password',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: validateNewPassword ? newPassword : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
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
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.black),
                    errorText:
                        validateConfirmPassword ? errorConfirmPassword : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
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
                  ),
                  onChanged: (text) {
                    if (text != newPasswordController.text.trim()) {
                      setState(() {
                        errorConfirmPassword = "Password does not match.";
                        validateConfirmPassword = true;
                      });
                    } else {
                      setState(() {
                        validateConfirmPassword = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _checkInternet.check().then((value) {
          if (value != null && value) {
            updatePassword();
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
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showSuccess(UpdatePasswordResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast('Password Change Successfully');
      Navigator.of(context).pop();
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
