import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:teamup/contract/CityContract.dart';
import 'package:teamup/contract/CollegeContract.dart';
import 'package:teamup/contract/CountryContract.dart';
import 'package:teamup/contract/StateContract.dart';
import 'package:teamup/contract/StudentSignUpFirstContract.dart';
import 'package:teamup/contract/StudentSignUpSecondContract.dart';
import 'package:teamup/contract/StudentSignUpThirdContract.dart';
import 'package:teamup/module/CityModel.dart';
import 'package:teamup/module/CollegeModel.dart';
import 'package:teamup/module/CountryModel.dart';
import 'package:teamup/module/SignUpRequestModel.dart';
import 'package:teamup/module/SignUpRequestModelSecond.dart';
import 'package:teamup/module/SignUpRequestThird.dart';
import 'package:teamup/module/SignUpResponseModel.dart';
import 'package:teamup/module/StateModel.dart';
import 'package:teamup/presenter/CityPresenter.dart';
import 'package:teamup/presenter/CollegePresenter.dart';
import 'package:teamup/presenter/CountryPresenter.dart';
import 'package:teamup/presenter/SingUpPresenter.dart';
import 'package:teamup/presenter/StatePresenter.dart';
import 'package:teamup/presenter/StdSignUpThirdStepPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/SnackBar.dart';
import 'package:teamup/utils/Toast.dart';
import 'package:teamup/utils/Dialogs/orgRegistrationSuccessHelper.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
    implements
        studentSignUpFirstContract,
        studentSignUpThirdContract,
        CountryContract,
        StateContract,
        CityContract,
        CollegeContract {

  checkInternet _checkInternet;
  bool isInternetAvailable = false;

  SignUpFirstStepPresenter _signUpFirstStepPresenter;
  StdSignUpThirdStepPresenter _signUpThirdStepPresenter;
  CountryPresenter countryPresenter;
  StatePresenter statePresenter;
  CityPresenter cityPresenter;
  CollegePresenter collegePresenter;

  int UserId;
  bool darkModeOn = false;
  int _section = 1;
  bool checkBoxValue = false;
  bool _isLoading = false;
  bool _FirstNameValidate = false;
  bool _LastNameValidate = false;
  bool _EmailValidate = false;
  bool _MobileNumberValidate = false;
  bool _UsernameValidate = false;
  bool _PasswordValidate = false;
  bool validateAddress = false;
  bool validateAboutSelf = false;

  List<Country> countryList;
  List<States> stateList;
  List<City> cityList;
  List<CollegeList> collegeList;

  String firstname,
      lastName,
      emailId,
      PhoneNumber,
      smsCode,
      emailCode,
      userName,
      password;

  final txtFirstNameController = TextEditingController();
  final txtLastNameController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtMobileController = TextEditingController();

  // final txtSmsCodeController = TextEditingController();
  // final txtEmailCodeController = TextEditingController();

  final txtUsernameController = TextEditingController();
  final txtPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final aboutSelf = TextEditingController();

  var selectedCountry;
  var selectedState;
  var selectedCity;
  var selectedCollege;

  bool isCountrySelected = false;
  bool isStateSelected = false;
  bool isCitySelected = false;
  bool isCollegeSelected = false;

  bool userSelectedImage = false;
  File _image;
  String base64Image;

  String enterOTP;
  String serverOtp;

  SignUpFirstRequestModel signUpRequestModel;
  SignUpRequestThird signUpRequestThird;

  _SignUpState() {
    _signUpFirstStepPresenter = new SignUpFirstStepPresenter(this);
    _signUpThirdStepPresenter = new StdSignUpThirdStepPresenter(this);
    countryPresenter = new CountryPresenter(this);
    statePresenter = new StatePresenter(this);
    cityPresenter = new CityPresenter(this);
    collegePresenter = CollegePresenter(this);
  }

  getCountryList() {
    setState(() {
      _isLoading = true;
    });
    countryPresenter.getCountry('Students/GetCountry');
  }

  getStateList(String id) {
    setState(() {
      _isLoading = true;
    });
    statePresenter.getState('Students/GetStateByCountryId?CountryId=$id');
  }

  getCityList(String id) {
    setState(() {
      _isLoading = true;
    });
    cityPresenter.getCity('Students/GetCityByStateId?StateId=$id');
  }

  getCollegeList() {
    setState(() {
      _isLoading = true;
    });
    collegePresenter.getListOfColleges('Students/GetCollege');
  }

  Future _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      userSelectedImage = true;
    });
    List<int> imageBytes = await _image.readAsBytesSync();
    setState(() {
      base64Image = base64Encode(imageBytes);
    });
  }

  Future _imgFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      userSelectedImage = true;
    });
    List<int> imageBytes = await _image.readAsBytesSync();
    setState(() {
      base64Image = base64Encode(imageBytes);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallary'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    super.initState();
    collegeList = List();
    countryList = List();
    stateList = List();
    cityList = List();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    darkModeOn = brightness == Brightness.dark;
    signUpRequestModel = new SignUpFirstRequestModel();
    signUpRequestThird = new SignUpRequestThird();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getCollegeList();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
    Preference.init();
  }

  @override
  void dispose() {
    txtFirstNameController.dispose();
    txtLastNameController.dispose();
    txtEmailController.dispose();
    txtMobileController.dispose();
    txtUsernameController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  _signUpAPICall(
      String firstName, String lastName, String emailId, String mobileNumber) {
    if (_section == 1) {
      signUpRequestModel.firstname = firstName;
      signUpRequestModel.lastname = lastName;
      signUpRequestModel.email = emailId;
      signUpRequestModel.phone = mobileNumber;
      signUpRequestModel.collegeId = selectedCollege.toString();
      signUpRequestModel.aboutMyself = aboutSelf.text.toString().trim();
      signUpRequestModel.imagePath = base64Image;

      _signUpFirstStepPresenter.stdFirstStep(
          signUpRequestModel, 'Students/PostNewStudent');
      setState(() {
        _isLoading = true;
      });
    } else if (_section == 2) {
      signUpRequestThird.ID = UserId.toString();
      signUpRequestThird.Username = txtUsernameController.text.trim();
      signUpRequestThird.Password = txtPasswordController.text.trim();
      signUpRequestThird.City = selectedCity.toString();
      signUpRequestThird.State = selectedState.toString();
      signUpRequestThird.Country = selectedCountry.toString();
      signUpRequestThird.Address = addressController.text.trim();
      signUpRequestThird.TermConditions = true;
      //post3(signUpRequestThird);
      _signUpThirdStepPresenter.stdThirdStep(
          signUpRequestThird, 'Students/PostNewStudent');
      setState(() {
        _isLoading = true;
      });
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _MainUI(context),
      inAsyncCall: _isLoading,
      opacity: 0.3,
    );
  }

  @override
  Widget _MainUI(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                image: AssetImage('assets/art/Vector_Art_Full_Page.png'),
                fit: BoxFit.cover,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )),
                    Text(
                      'Buckle Up!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Section(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showError(e) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showSuccess(String item) {
    setState(() {
      _isLoading = false;
    });
  }

  Widget signUpLoginButton(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        if (_section == 1) {
          setState(() {
            txtFirstNameController.text.isEmpty
                ? _FirstNameValidate = true
                : _FirstNameValidate = false;
            txtLastNameController.text.isEmpty
                ? _LastNameValidate = true
                : _LastNameValidate = false;
            //txtEmailController.text.isEmpty ? _EmailValidate = true : _EmailValidate = false;
            txtMobileController.text.isEmpty
                ? _MobileNumberValidate = true
                : _MobileNumberValidate = false;
            txtMobileController.text.length < 10
                ? _MobileNumberValidate = true
                : _MobileNumberValidate = false;
            validateEmail(txtEmailController.text)
                ? _EmailValidate = false
                : _EmailValidate = true;
            aboutSelf.text.isEmpty
                ? validateAboutSelf = true
                : validateAboutSelf = false;
          });
          if (!userSelectedImage) {
            toast().showToast('Please select Profile Image');
            return false;
          }
          if (!isCollegeSelected) {
            toast().showToast('Please select College');
            return false;
          }
          if (txtMobileController.text.length != 10) {
            toast().showToast('Please Enter Valid Mobile Number');
            setState(() {
              _MobileNumberValidate = true;
            });
            return false;
          }

          if (!_FirstNameValidate == true &&
              !_LastNameValidate == true &&
              !_EmailValidate == true &&
              !_MobileNumberValidate == true) {
            setState(() {
              firstname = txtFirstNameController.text;
              lastName = txtLastNameController.text;
              emailId = txtEmailController.text;
              PhoneNumber = txtMobileController.text;
            });
            _signUpAPICall(
                txtFirstNameController.text.trim(),
                txtLastNameController.text.trim(),
                txtEmailController.text.trim(),
                txtMobileController.text.trim());

          }
        } else {
          setState(() {
            txtUsernameController.text.isEmpty
                ? _UsernameValidate = true
                : _UsernameValidate = false;
            txtPasswordController.text.isEmpty
                ? _PasswordValidate = true
                : _PasswordValidate = false;
          });
          if (!_UsernameValidate == true &&
              !_PasswordValidate == true &&
              isCountrySelected &&
              isStateSelected &&
              isCitySelected &&
              !validateAddress) {
            if (!validatePassword(txtPasswordController.text.trim())) {
              setState(() {
                _PasswordValidate = true;
              });
              toast().showToast('Password should be alphanumeric, include 1 number and 1 alphabet and 1 special character');
              return false;
            }
            _signUpAPICall("", "", "", "");
          } else {
            if (!isCountrySelected) {
              toast().showToast('Please select Country.');
              return false;
            }
            if (!isStateSelected) {
              toast().showToast('Please select State.');
              return false;
            }
            if (!isCitySelected) {
              toast().showToast('Please select City.');
              return false;
            }
            if (validateAddress) {
              setState(() {
                validateAddress = true;
              });
              return false;
            }

          }
        }
      },
      child: Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget Section(BuildContext context) {
    if (_section == 1) {
      return Container(
        // height: MediaQuery.of(context).size.height/1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text('Enter the following information',
                  style: TextStyle(color: Colors.black)),
              Text(
                'It will be safe with us!',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Container(
                  width: double.infinity,
                  height: 140,
                  child: Container(
                    alignment: Alignment(0.0, 1.9),
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        backgroundImage: userSelectedImage
                            ? FileImage(_image)
                            : AssetImage('assets/art/profile.png'),
                        radius: 70.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                          controller: txtFirstNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.black87),
                            errorText: _FirstNameValidate
                                ? 'Please Enter First Name'
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: txtLastNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: _LastNameValidate
                                ? 'Please Enter Last Name'
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: aboutSelf,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "About your self",
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: _LastNameValidate
                                ? 'Please Enter About your self'
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: txtEmailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                _EmailValidate ? 'Please Enter Email Id' : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: txtMobileController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Mobile Number",
                            errorText: _MobileNumberValidate
                                ? 'Please Enter Mobile Number'
                                : null,
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Center(
                            child: DropdownButton(
                              items: collegeList.map((index) {
                                return DropdownMenuItem(
                                  child: Text(index.collegeName),
                                  value: index.collegeId,
                                );
                              }).toList(),
                              hint: Text('Select College'),
                              underline: SizedBox(),
                              isExpanded: true,
                              onChanged: (newVal) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                setState(() {
                                  isCollegeSelected = true;
                                  selectedCollege = newVal;
                                });
                              },
                              value: selectedCollege,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'One Final Step!',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      signUpLoginButton(context, 'Next'),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'or',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      socialLogin(),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_section == 2) {
      return Container(
        // height: MediaQuery.of(context).size.height/1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text('Enter the following information',
                  style: TextStyle(color: Colors.black)),
              Text(
                'It will be safe with us!',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    children: [
                      //Country DropDown
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Center(
                              child: DropdownButton(
                                items: countryList.map((index) {
                                  return DropdownMenuItem(
                                    child: Text(index.name),
                                    value: index.id,
                                  );
                                }).toList(),
                                hint: Text('Select Country'),
                                underline: SizedBox(),
                                isExpanded: true,
                                onChanged: (newVal) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    isCountrySelected = true;
                                    selectedCountry = newVal;
                                  });
                                  getStateList(selectedCountry.toString());
                                },
                                value: selectedCountry,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //State DropDown
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Center(
                              child: DropdownButton(
                                items: stateList.map((index) {
                                  return DropdownMenuItem(
                                    child: Text(index.name),
                                    value: index.id,
                                  );
                                }).toList(),
                                hint: Text('Select State'),
                                underline: SizedBox(),
                                isExpanded: true,
                                onChanged: (newVal) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    isStateSelected = true;
                                    selectedState = newVal;
                                  });
                                  getCityList(selectedState.toString());
                                },
                                value: selectedState,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //City DropDown
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Center(
                              child: DropdownButton(
                                items: cityList.map((index) {
                                  return DropdownMenuItem(
                                    child: Text(index.name),
                                    value: index.id,
                                  );
                                }).toList(),
                                hint: Text('Select City'),
                                underline: SizedBox(),
                                isExpanded: true,
                                onChanged: (newVal) {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    isCitySelected = true;
                                    selectedCity = newVal;
                                  });
                                },
                                value: selectedCity,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: addressController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: TextStyle(color: Colors.black87),
                            errorText:
                                validateAddress ? 'Please Enter Address' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: txtUsernameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            errorText: _UsernameValidate
                                ? 'Please Enter Username'
                                : null,
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: txtPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            errorText: _PasswordValidate
                                ? 'Please Enter Valid Password'
                                : null,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Final!',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      signUpLoginButton(context, 'Submit'),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void showStudentSignUpError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
    toast().showToast('Something wnet wrong,Please try again later..');
  }

  @override
  void showStudentSignUpSuccess(SignUpFirstResponseModel success) {
    setState(() {
      _isLoading = false;
    });
    if (success.status == 99) {
      displayBottomSheet(context);
      setState(() {
        UserId = success.id;
        serverOtp = success.emailcode;
      });
      toast().showToast(success.message);
    } else {
      toast().showToast(success.message);
    }
  }

  @override
  void showStudentSignUpThirdError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
    toast().showToast('Something went wrong,Please try again later..');
  }

  @override
  void showStudentSignUpThirdSuccess(SignUpThirdResponseModel success) {
    SignUpThirdResponseModel thirdResponseModel;
    setState(() {
      _isLoading = false;
      thirdResponseModel = success;
    });
    if (thirdResponseModel.Status == 0) {
      orgRegSuccessDailogHelper.StdOk(context);
    } else {
      toast().showToast(thirdResponseModel.Message);
    }
  }

  @override
  void showCityError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showCitySuccess(CityModel cityModel) {
    setState(() {
      _isLoading = false;
    });
    if (cityModel.status == 0) {
      cityList.addAll(cityModel.cities);
    } else {
      toast().showToast('Something went wrong, Please try again later.');
    }
  }

  @override
  void showCountryError(FetchException exception) {
    setState(() {
      _isLoading = false;
      isInternetAvailable = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showCountrySuccess(CountryModel countryModel) {
    setState(() {
      _isLoading = false;
    });
    if (countryModel.status == 0) {
      countryList.addAll(countryModel.countries);
    } else {
      setState(() {
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showStateError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showStateSuccess(StateModel stateModel) {
    setState(() {
      _isLoading = false;
    });
    if (stateModel.status == 0) {
      stateList.addAll(stateModel.states);
    } else {
      toast().showToast('Something went wrong while loading State.');
    }
  }

  @override
  void showCollegeError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showCollegeSuccess(CollegeModel collegeModel) {
    setState(() {
      _isLoading = false;
    });
    if (collegeModel.status == 0) {
      collegeList.addAll(collegeModel.collegeList);
      getCountryList();
    } else {
      toast().showToast(collegeModel.message);
    }
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
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
    if (enterOTP == serverOtp) {
      toast().showToast('OTP Verified');
      Navigator.of(context).pop();
      setState(() {
        _section = 2;
      });
    } else {
      toast().showToast('Invalid OTP.');
    }
  }

  Widget socialLogin() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: 60.0,
                width: 60.0,
                child: IconButton(
                  onPressed: () {},
                  icon: new Image.asset('assets/socialMedia/google.png'),
                )),
            SizedBox(
                height: 60.0,
                width: 60.0,
                child: IconButton(
                  onPressed: () {},
                  icon: new Image.asset('assets/socialMedia/fb.png'),
                )),
          ],
        ),
      ),
    );
  }
}


