import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:teamup/contract/CityContract.dart';
import 'package:teamup/contract/CountryContract.dart';
import 'package:teamup/contract/OrganizationSignUpFirstContract.dart';
import 'package:teamup/contract/OrganizationSignUpSecondContract.dart';
import 'package:teamup/contract/OrganizationSignUpThirdContract.dart';
import 'package:teamup/contract/OrganizationTypeContract.dart';
import 'package:teamup/contract/SignUpContract.dart';
import 'package:teamup/contract/StateContract.dart';
import 'package:teamup/module/CityModel.dart';
import 'package:teamup/module/CountryModel.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelFirst.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelSecond.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelThird.dart';
import 'package:teamup/module/OrganizationTypeModel.dart';
import 'package:teamup/module/StateModel.dart';
import 'package:teamup/presenter/CityPresenter.dart';
import 'package:teamup/presenter/CountryPresenter.dart';
import 'package:teamup/presenter/OrganizationFirstStepPresenter.dart';
import 'package:teamup/presenter/OrganizationSecondStepPresenter.dart';
import 'package:teamup/presenter/OrganizationThirdStepPresenter.dart';
import 'package:teamup/presenter/OrganizationTypePresenter.dart';
import 'package:teamup/presenter/SingUpPresenter.dart';
import 'package:teamup/presenter/StatePresenter.dart';
import 'package:teamup/screen/LoginScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';
import 'package:teamup/utils/Dialogs/orgRegistrationSuccessHelper.dart';

class OrganizationSignUp extends StatefulWidget {
  @override
  _OrganizationSignUpState createState() => _OrganizationSignUpState();
}

class _OrganizationSignUpState extends State<OrganizationSignUp>
    implements
        OrganizationType,
        organizationSignUpFirstContract,
        organizationSignUpThirdContract,
        CountryContract,
        CityContract,
        StateContract {
  checkInternet _checkInternet;
  OrgSignUpFirst signUpFirst;
  OrgSignUpThird signUpThird;
  int id;

  String enterOTP;
  String serverOtp;

  bool userSelectedImage = false;
  File _image;
  String base64Image;

  DateTime estDate = DateTime.now();
  bool isDateSelect = false;
  bool isOrgTypeSelect = false;
  bool isNetworkAvailable = false;

  List<OrganizationTypeModel> _organizationType = List<OrganizationTypeModel>();
  List<Country> countryList;
  List<States> stateList;
  List<City> cityList;

  OrganizationTypePresenter organizationTypePresenter;
  organizationFirstStepPresenter firstStepPresenter;
  organizationThirdStepPresenter thirdStepPresenter;
  CountryPresenter countryPresenter;
  StatePresenter statePresenter;
  CityPresenter cityPresenter;

  _OrganizationSignUpState() {
    organizationTypePresenter = new OrganizationTypePresenter(this);
    firstStepPresenter = new organizationFirstStepPresenter(this);
    thirdStepPresenter = new organizationThirdStepPresenter(this);
    countryPresenter = new CountryPresenter(this);
    statePresenter = new StatePresenter(this);
    cityPresenter = new CityPresenter(this);
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

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool _isLoading = false;
  int section = 1;
  var _mySelection;
  var checkBoxValue = false;

  var selectedCountry;
  bool isCountrySelected = false;
  var selectedState;

  var isStateSelected = false;
  var selectedCity;
  bool isCitySelected = false;

  final orgNameController = TextEditingController();
  final orgAboutIsController = TextEditingController();
  final orgEmailIdController = TextEditingController();
  final orgMobileNumberController = TextEditingController();
  final orgWebsiteController = TextEditingController();
  final orgSpecialityController = TextEditingController();
  final orgSmsCodeController = TextEditingController();
  final orgEmailCodeController = TextEditingController();
  final orgUsernameController = TextEditingController();
  final orgPasswordController = TextEditingController();
  final orgAddressController = TextEditingController();

  bool _nameValidate = false;
  bool _aboutUsValidate = false;
  bool _emailValidate = false;
  bool _mobileValidate = false;
  bool _webSiteValidate = false;
  bool _specialityValidate = false;
  bool _userNameValidate = false;
  bool _passwordValidate = false;
  bool _addressValidate = false;
  bool _passwordVisible = true;

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

  getCountryList() {
    setState(() {
      _isLoading = true;
    });
    countryPresenter.getCountry('Students/GetCountry');
  }

  getStateList(String countryId) {
    setState(() {
      _isLoading = true;
    });
    statePresenter
        .getState('Students/GetStateByCountryId?CountryId=$countryId');
  }

  getCityList(String stateId) {
    setState(() {
      _isLoading = true;
    });
    cityPresenter.getCity('Students/GetCityByStateId?StateId=$stateId');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    signUpFirst = new OrgSignUpFirst();
    signUpThird = new OrgSignUpThird();
    countryList = new List();
    stateList = new List();
    cityList = new List();
    // API Call
    _checkInternet.check().then((value) {
      if (value != null && value) {
        _isLoading = true;
        organizationTypePresenter
            .organizationType("TypeList/GetOrganizationType");
      } else {
        toast().showToast('Please check your internet connection..');
        setState(() {
          isNetworkAvailable = true;
        });
      }
    });
  }

  Future<void> _dateDialog() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: estDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != estDate)
      setState(() {
        isDateSelect = true;
        estDate = picked;
      });
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == this.estDate &&
        now.month == this.estDate &&
        now.year == this.estDate;
  }

  void firstStepApiCall(
      String orgName,
      String aboutUs,
      String orgType,
      String Email,
      String Mobile,
      String webSite,
      String specialities,
      String estDate) {
    signUpFirst.id = "";
    signUpFirst.orgName = orgName;
    signUpFirst.aboutUs = aboutUs;
    signUpFirst.email = Email;
    signUpFirst.phone = Mobile;
    signUpFirst.website = webSite;
    signUpFirst.specialties = specialities;
    signUpFirst.establishmentDate = estDate;
    signUpFirst.orgTypeId = orgType;
    signUpFirst.imagePath = base64Image;
    signUpFirst.termConditions = checkBoxValue;
    setState(() {
      _isLoading = true;
    });
    firstStepPresenter.firstStep(
        signUpFirst, 'Organizations/PostNewOrganizations');
  }

  void thirdStepApiCall(String Id, String userName, String password) {
    setState(() {
      _isLoading = true;
    });
    signUpThird.id = Id;
    signUpThird.username = userName;
    signUpThird.password = password;
    signUpThird.address = orgAddressController.text.trim();
    signUpThird.country = selectedCountry;
    signUpThird.state = selectedState;
    signUpThird.city = selectedCity;
    thirdStepPresenter.thirdStep(
        signUpThird, 'Organizations/PostNewOrganizations');
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
                    child: isNetworkAvailable
                        ? Container(
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height/1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  Text('Enter the following information',
                                      style: TextStyle(color: Colors.black)),
                                  Text(
                                    'It will be safe with us!',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 80.0,
                                          ),
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.black,
                                            size: 60.0,
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Text(
                                            'No Internet Connection..',
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : UiSection(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget UiSection(BuildContext context) {
    if (section == 1) {
      return Container(
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
                height: 20.0,
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
                            : AssetImage('assets/art/personal.png'),
                        radius: 70.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Company Logo',
                style: TextStyle(fontSize: 16.0),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                          controller: orgNameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Organization Name",
                            hintStyle: TextStyle(color: Colors.black87),
                            errorText: _nameValidate
                                ? 'Please Enter Organization Name'
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
                          controller: orgAboutIsController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "About Us",
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: _aboutUsValidate
                                ? 'Please enter about us'
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: DropdownButton(
                            items: _organizationType.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.Name),
                                value: item.ID.toString(),
                              );
                            }).toList(),
                            hint: Text('Select Organization Type'),
                            underline: SizedBox(),
                            isExpanded: true,
                            onChanged: (newVal) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                isOrgTypeSelect = true;
                                _mySelection = newVal;
                              });
                            },
                            value: _mySelection,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgEmailIdController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                _emailValidate ? 'Please Enter Email Id' : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgMobileNumberController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Mobile Number",
                            errorText: _mobileValidate
                                ? 'Please Enter Mobile Number'
                                : null,
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgWebsiteController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Website",
                            errorText: _webSiteValidate
                                ? 'Please Enter Website'
                                : null,
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgSpecialityController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Speciality",
                            errorText: _specialityValidate
                                ? 'Please Enter Speciality'
                                : null,
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: GestureDetector(
                          onTap: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                            _dateDialog();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(isDateSelect
                                      ? "${estDate.toLocal()}".split(' ')[0]
                                      : 'Select Establish Date'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Term's and Conditions",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Checkbox(
                                value: checkBoxValue,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    checkBoxValue = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'One More Step!',
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
    } else if (section == 3) {
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
                      TextField(
                          controller: orgUsernameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            errorText: _userNameValidate
                                ? 'Please enter username'
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: DropdownButton(
                            items: countryList.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name),
                                value: item.id.toString(),
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: DropdownButton(
                            items: stateList.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name),
                                value: item.id.toString(),
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: DropdownButton(
                            items: cityList.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name),
                                value: item.id.toString(),
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
                              getCityList(selectedCity.toString());
                            },
                            value: selectedCity,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgAddressController,
                          decoration: InputDecoration(
                            errorText: _addressValidate
                                ? 'Please Enter address'
                                : null,
                            hintText: "Address",
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
                        height: 10.0,
                      ),
                      TextField(
                          controller: orgPasswordController,
                          obscureText: _passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            errorText: _passwordValidate
                                ? 'Please enter valid password'
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

  Widget signUpLoginButton(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (section == 1) {
          setState(() {
            orgNameController.text.isEmpty
                ? _nameValidate = true
                : _nameValidate = false;
            orgAboutIsController.text.isEmpty
                ? _aboutUsValidate = true
                : _aboutUsValidate = false;
            orgEmailIdController.text.isEmpty
                ? _emailValidate = true
                : _emailValidate = false;
            orgMobileNumberController.text.isEmpty
                ? _mobileValidate = true
                : _mobileValidate = false;
            orgWebsiteController.text.isEmpty
                ? _webSiteValidate = true
                : _webSiteValidate = false;
            orgSpecialityController.text.isEmpty
                ? _specialityValidate = true
                : _specialityValidate = false;
            validateEmail(orgEmailIdController.text)
                ? _emailValidate = false
                : _emailValidate = true;
          });
          if (orgMobileNumberController.text.length != 10) {
            setState(() {
              _mobileValidate = true;
            });
            return false;
          }
          if (!userSelectedImage) {
            toast().showToast('Please select Company Logo');
            return false;
          }
          if (!checkBoxValue) {
            toast().showToast("Please Agree Term's and Condition");
            return false;
          }
          if (isOrgTypeSelect == false) {
            toast().showToast('Please Select Organization Type');
          } else if (isDateSelect == false) {
            toast().showToast('Please Select Establish Date..');
          } else {
            // Check the Internet and call the API from here..
            _checkInternet.check().then((value) {
              if (value != null && value) {
                firstStepApiCall(
                    orgNameController.text,
                    orgAboutIsController.text,
                    _mySelection,
                    orgEmailIdController.text,
                    orgMobileNumberController.text,
                    orgWebsiteController.text,
                    orgSpecialityController.text,
                    estDate.toString());
              } else {
                toast().showToast('Please check your Internet Connection');
              }
            });
          }
        } else if (section == 3) {
          setState(() {
            orgUsernameController.text.isEmpty
                ? _userNameValidate = true
                : _userNameValidate = false;
            orgPasswordController.text.isEmpty
                ? _passwordValidate = true
                : _passwordValidate = false;
            orgAddressController.text.isEmpty
                ? _addressValidate = true
                : _addressValidate = false;
          });
          if (!isCountrySelected) {
            toast().showToast('Please select Country');
            return false;
          }
          if (!isStateSelected) {
            toast().showToast('Please select State');
            return false;
          }
          if (!isCitySelected) {
            toast().showToast('Please select City');
            return false;
          }
          if (!validatePassword(orgPasswordController.text.trim())) {
            setState(() {
              _passwordValidate = true;
            });
            toast().showToast('Password should be alphanumeric, include 1 number and 1 alphabet and 1 special character');
            return false;
          }

          if (!_userNameValidate &&
              !_passwordValidate &&
              !_addressValidate &&
              isCountrySelected &&
              isStateSelected &&
              isCitySelected) {
            _checkInternet.check().then((value) {
              if (value != null && value) {
                thirdStepApiCall(id.toString(), orgUsernameController.text,
                    orgPasswordController.text);
              } else {
                toast().showToast('Please check your Internet Connection');
              }
            });
          } else {
            toast().showToast('All the fields are compulsory..');
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

  @override
  void showError(FetchException e) {
    toast().showToast('Something went wrong, Please try again later..');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showSuccess(List<OrganizationTypeModel> item) {
    setState(() {
      _isLoading = false;
      _organizationType = item;
    });
    getCountryList();
  }

  @override
  void showFirstStepError(FetchException e) {
    toast().showToast('Something went wrong,please try again later..');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showFirstStepSuccess(OrgSignUpFirstResponseModel success) {
    setState(() {
      _isLoading = false;
    });
    if (success.status == 99) {
      displayBottomSheet(context);
      setState(() {
        id = success.id;
        serverOtp = success.emailcode;
      });
       print(serverOtp);
      toast().showToast(success.message);
    } else {
      toast().showToast(success.message);
    }
  }

  @override
  void showThirdStepError(FetchException exception) {
    toast().showToast('Something went wrong,please try again later..');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showThirdStepSuccess(orgSignUpThirdResponseModel success) {
    orgSignUpThirdResponseModel thirdResponseModel;
    setState(() {
      _isLoading = false;
      thirdResponseModel = success;
    });
    if (thirdResponseModel.Status == 0) {
      orgRegSuccessDailogHelper.Ok(context);
    } else {
      toast().showToast('Something went wrong,please try again later..');
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
    if (enterOTP == serverOtp) {
      toast().showToast('OTP Verified');
      Navigator.of(context).pop();
      setState(() {
        section = 3;
      });
    } else {
      toast().showToast('Invalid OTP.');
    }
  }

  @override
  void showCountryError(FetchException exception) {
    setState(() {
      _isLoading = false;
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
      toast().showToast('Somwthing went wrong, Please try again later.');
    }
  }

  @override
  void showStateError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showStateSuccess(StateModel stateModel) {
    setState(() {
      _isLoading = false;
    });
    if (stateModel.status == 0) {
      stateList.addAll(stateModel.states);
    } else {
      toast().showToast('Something went wrong, Please try again later');
    }
  }

  @override
  void showCityError(FetchException exception) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showCitySuccess(CityModel cityModel) {
    setState(() {
      _isLoading = false;
    });
    if (cityModel.status == 0) {
      cityList.addAll(cityModel.cities);
    } else {
      toast().showToast('Something went wrong, Please try again later');
    }
  }
}
