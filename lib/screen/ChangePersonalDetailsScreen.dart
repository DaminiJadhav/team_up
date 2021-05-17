import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:teamup/contract/ChangeDetailsContract.dart';
import 'package:teamup/module/ChangePersonalDetailsModel.dart';
import 'package:teamup/presenter/ChangeDetailsPresenter.dart';
import 'package:teamup/screen/ForgotPasswordScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class ChangePersonalDetails extends StatefulWidget {
  @override
  _ChangePersonalDetailsState createState() => _ChangePersonalDetailsState();
}

class _ChangePersonalDetailsState extends State<ChangePersonalDetails>
    implements ChangeDetailsContract {
  ChangeDetailsPresenter detailsPresenter;
  ChangeNameRequestModel nameRequestModel;
  ChangeEmailIdRequestModel emailIdRequestModel;
  ChangePasswordRequestModel passwordRequestModel;
  checkInternet _internet;
  bool isApiCallProcess = false;
  int index = 0;
  bool _passwordVisible = true;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final orgNameController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool validateFirstName = false;
  bool validateLastName = false;
  bool validateOrgName = false;
  bool validateEmail = false;
  bool validateCurrentPassword = false;
  bool validateNewPassword = false;

  bool nameChange = false;
  bool emailChange = false;
  bool passwordChange = false;

  _ChangePersonalDetailsState() {
    detailsPresenter = new ChangeDetailsPresenter(this);
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  validateNameData() {
    if (Preference.getIsStudent()) {
      setState(() {
        firstNameController.text.isEmpty
            ? validateFirstName = true
            : validateFirstName = false;
        lastNameController.text.isEmpty
            ? validateLastName = true
            : validateLastName = false;
      });
    } else {
      setState(() {
        orgNameController.text.isEmpty
            ? validateOrgName = true
            : validateOrgName = false;
      });
    }
    if (Preference.getIsStudent()) {
      if (!validateFirstName && !validateLastName) {
        editName();
      }
    } else {
      if (!validateOrgName) {
        editName();
      }
    }
  }

  editName() {
    setState(() {
      index = 1;
      isApiCallProcess = true;
    });
    nameRequestModel.id = Preference.getUserId();
    nameRequestModel.firstname =
        Preference.getIsStudent() ? firstNameController.text.trim() : "";
    nameRequestModel.lastname =
        Preference.getIsStudent() ? lastNameController.text.trim() : "";
    nameRequestModel.isStudent = Preference.getIsStudent();
    nameRequestModel.orgname =
        Preference.getIsStudent() ? "" : orgNameController.text.trim();
    nameRequestModel.isOrg = Preference.getIsOrganization();

    detailsPresenter.changeName(nameRequestModel, 'Students/PutChangeName');
  }

  validateEmailData() {
    setState(() {
      emailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
    });
    if (!EmailValidator.validate(emailController.text.trim())) {
      setState(() {
        validateEmail = true;
      });
      return false;
    }
    if (!validateEmail) {
      editEmail();
    }
  }

  editEmail() {
    setState(() {
      index = 2;
      isApiCallProcess = true;
    });
    emailIdRequestModel.id = Preference.getUserId();
    emailIdRequestModel.isOrg = Preference.getIsOrganization();
    emailIdRequestModel.isStudent = Preference.getIsStudent();
    emailIdRequestModel.email = emailController.text.trim();
    detailsPresenter.changeEmailId(
        emailIdRequestModel, 'Students/PutChangeEmail');
  }

  validatePasswordData() {
    setState(() {
      currentPasswordController.text.isEmpty
          ? validateCurrentPassword = true
          : validateCurrentPassword = false;
      newPasswordController.text.isEmpty
          ? validateNewPassword = true
          : validateNewPassword = false;
    });
    if (!validateStructure(newPasswordController.text.trim())) {
      setState(() {
        validateNewPassword = true;
      });
      toast().showToast(
          'Password should be contain 1 Upper, 1 Small, 1 Special Character and 1 Number');
      return false;
    }
    if (!validateCurrentPassword && !validateNewPassword) {
      editPassword();
    }
  }

  editPassword() {
    setState(() {
      index = 3;
      isApiCallProcess = true;
    });
    passwordRequestModel.id = Preference.getUserId();
    passwordRequestModel.isStudent = Preference.getIsStudent();
    passwordRequestModel.isOrg = Preference.getIsOrganization();
    passwordRequestModel.oldpassword = currentPasswordController.text.trim();
    passwordRequestModel.newpassword = newPasswordController.text.trim();
    detailsPresenter.changePassword(
        passwordRequestModel, 'Students/PutChangePassword');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();

    _internet = new checkInternet();
    firstNameController.text = Preference.getUserFirstName();
    lastNameController.text = Preference.getUserLastName();
    orgNameController.text = Preference.getUserFirstName();
    emailController.text = Preference.getUserEmail();
    nameRequestModel = new ChangeNameRequestModel();
    emailIdRequestModel = new ChangeEmailIdRequestModel();
    passwordRequestModel = new ChangePasswordRequestModel();
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
          child: ListView(
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
                        'Change Details',
                        style: TextStyle(fontSize: 24.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/icons/changepersonaldetails.png',
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0,right: 16.0),
            child: Text(
              'Please enter correct details. We will update for you!.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Name ',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Visibility(
            visible: Preference.getIsStudent(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: TextField(
                  controller: firstNameController,
                  enabled: nameChange,
                  decoration: InputDecoration(
                    hintText: 'First Name: Eg John Watson',
                    labelText: 'First Name',
                    hintStyle: TextStyle(color: Colors.black),
                    errorText:
                        validateFirstName ? 'Please enter First Name' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
          ),
          Visibility(
            visible: Preference.getIsStudent(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: TextField(
                  controller: lastNameController,
                  enabled: nameChange,
                  decoration: InputDecoration(
                    hintText: 'Last Name: Eg Watson',
                    labelText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.black),
                    errorText:
                        validateLastName ? 'Please enter Last Name' : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
          ),
          Visibility(
            visible: Preference.getIsOrganization(),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: TextField(
                  controller: orgNameController,
                  enabled: nameChange,
                  decoration: InputDecoration(
                    hintText: 'Name: Eg TeamUp Technology',
                    labelText: 'Name',
                    hintStyle: TextStyle(color: Colors.black),
                    errorText: validateOrgName
                        ? 'Please enter Organization Name'
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
          ),
          SizedBox(
            height: 20.0,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Email ',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
            child: TextField(
                controller: emailController,
                enabled: emailChange,
                decoration: InputDecoration(
                  hintText: 'Email: abc@pqr.com',
                  labelText: 'Email',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText:
                      validateEmail ? 'Please enter valid Email Id' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  'Change Password:',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        nameChange = false;
                        emailChange = false;
                        passwordChange = true;
                      });
                    },
                    child: Visibility(
                        visible: !passwordChange ,
                        child: Icon(Icons.edit))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
            child: TextField(
                controller: currentPasswordController,
                enabled: passwordChange,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Current Password',
                  labelText: 'Current Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText: validateCurrentPassword
                      ? 'Please enter Current Password'
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
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
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
            child: TextField(
                controller: newPasswordController,
                enabled: passwordChange,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  labelText: 'New Password',
                  hintStyle: TextStyle(color: Colors.black),
                  errorText:
                      validateNewPassword ? 'Please enter New Password' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
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
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Visibility(visible: nameChange, child: updateName()),
          Visibility(visible: emailChange, child: updateEmail()),
          Visibility(visible: passwordChange, child: updatePassword()),
        ],
      )),
    );
  }

  Widget updateName() {
    return GestureDetector(
      onTap: () {
        _internet.check().then((value) {
          if (value != null && value) {
            validateNameData();
          } else {
            toast().showToast('Please check your internet connection.');
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              'Change Name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget updateEmail() {
    return GestureDetector(
      onTap: () {
        _internet.check().then((value) {
          if (value != null && value) {
            validateEmailData();
          } else {
            toast().showToast('Please check your internet connection.');
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              'Change Email Id',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget updatePassword() {
    return GestureDetector(
      onTap: () {
        _internet.check().then((value) {
          if (value != null && value) {
            validatePasswordData();
          } else {
            toast().showToast('Please check your internet connection.');
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              'Change Password',
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
  void showChangeError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showChangeSuccess(ChangeResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      if (index == 1) {
        setState(() {
          Preference.setUserFirstName(firstNameController.text.trim());
          Preference.setUserLastName(lastNameController.text.trim());
        });
        toast().showToast(responseModel.message);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      } else if (index == 2) {
        setState(() {
          Preference.setUserEmail(emailController.text.trim());
        });
        toast().showToast(responseModel.message);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      } else if (index == 3) {
        toast().showToast(responseModel.message);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
