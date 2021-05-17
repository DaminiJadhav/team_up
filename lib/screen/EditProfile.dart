import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamup/contract/CityContract.dart';
import 'package:teamup/contract/CountryContract.dart';
import 'package:teamup/contract/GetPersonDetailsContract.dart';
import 'package:teamup/contract/StateContract.dart';
import 'package:teamup/contract/UpdatePersonDetailsContract.dart';
import 'package:teamup/module/CityModel.dart';
import 'package:teamup/module/CountryModel.dart';
import 'package:teamup/module/GetPersonDetailsModel.dart';
import 'package:teamup/module/StateModel.dart';
import 'package:teamup/module/UpdatePersonDetailsModel.dart';
import 'package:teamup/presenter/CityPresenter.dart';
import 'package:teamup/presenter/CountryPresenter.dart';
import 'package:teamup/presenter/GetPersonDetailsPresenter.dart';
import 'package:teamup/presenter/StatePresenter.dart';
import 'package:teamup/presenter/UpdatePersonDetailsPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    implements
        GetPersonDetailsContract,
        CountryContract,
        StateContract,
        CityContract,
        UpdatePersonDetailsContract {
  GetPersonDetailsPresenter getPersonDetailsPresenter;
  CountryPresenter countryPresenter;
  StatePresenter statePresenter;
  CityPresenter cityPresenter;
  UpdatePersonDetailsPresenter updatePersonDetailsPresenter;
  UpdatePersonDetailsModel updateModel;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  String bodyMsg = "";
  checkInternet _checkInternet;

  bool isFirstTime = false;

  bool userSelectedImage = false;
  String _imageUrl;
  File _image;
  String base64Image;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();

  bool validateFirstName = false;
  bool validateLastName = false;
  bool validateAddress = false;
  bool isCountrySelected = false;
  bool isStateSelected = false;
  bool isCitySelected = false;

  String countryHint = "Select Country";
  String stateHint = "Select State";
  String cityHint = "Select City";
  var sCountryId;
  var sStateId;
  var sCityId;
  var CountryId;
  List<Country> countryList;
  var StateId;
  List<States> stateList;
  var CityId;
  List<City> cityList;

  _EditProfileState() {
    getPersonDetailsPresenter = new GetPersonDetailsPresenter(this);
    countryPresenter = new CountryPresenter(this);
    statePresenter = new StatePresenter(this);
    cityPresenter = new CityPresenter(this);
    updatePersonDetailsPresenter = new UpdatePersonDetailsPresenter(this);
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

  getDetails() {
    setState(() {
      isApiCallProcess = true;
    });
    String userId = Preference.getUserId().toString();
    getPersonDetailsPresenter
        .personDetails('Students/GetStudents?StdId=$userId');
  }

  getCountry() {
    setState(() {
      isApiCallProcess = true;
    });
    countryPresenter.getCountry('Students/GetCountry');
  }

  getStateList(String id) {
    setState(() {
      isApiCallProcess = true;
    });
    statePresenter.getState('Students/GetStateByCountryId?CountryId=$id');
  }

  getCityList(String id) {
    setState(() {
      isApiCallProcess = true;
    });
    cityPresenter.getCity('Students/GetCityByStateId?StateId=$id');
  }

  validateData() {
    setState(() {
      firstNameController.text.isEmpty
          ? validateFirstName = true
          : validateFirstName = false;
      lastNameController.text.isEmpty
          ? validateLastName = true
          : validateLastName = false;
      addressController.text.isEmpty
          ? validateAddress = true
          : validateAddress = false;
    });
    if (!validateFirstName && !validateLastName && !validateAddress) {
      updateInfo();
    }
  }

  updateInfo() {
    setState(() {
      isApiCallProcess = true;
    });
    updateModel.id = Preference.getUserId().toString();
    updateModel.firstname = firstNameController.text.trim();
    updateModel.lastname = lastNameController.text.trim();
    updateModel.address = addressController.text.trim();
    updateModel.city = CityId == null ? sCityId : CityId.toString();
    updateModel.state = StateId == null ? sStateId : StateId.toString();
    updateModel.country = CountryId == null ? sCountryId : CountryId.toString();
    updateModel.imagePath = base64Image == null ? _imageUrl : base64Image;
    updateModel.IsImageChange = userSelectedImage;
    updatePersonDetailsPresenter.updateInfo(
        updateModel, 'Students/PutGetStudents');
  }

  @override
  void initState() {
    super.initState();
    countryList = new List();
    stateList = new List();
    cityList = new List();
    updateModel = new UpdatePersonDetailsModel();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getDetails();
      } else {
        setState(() {
          bodyMsg = "Please check your internet connection.";
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
        title: Text('Edit Profile'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
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
                            : _imageUrl != null
                                ? NetworkImage(_imageUrl)
                                : AssetImage('assets/art/personal.png'),
                        radius: 70.0,
                      ),
                    ),
                  ),
                ),
              ),
              //First Name TextField
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
                child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: 'First Name',
                      labelText: 'First Name',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateFirstName ? "Please enter First Name" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              // Last Name TextField
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
                child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateLastName ? "Please enter Last Name" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              // Country Drop Down
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Center(
                      child: DropdownButton(
                        items: countryList.map((index) {
                          return DropdownMenuItem(
                            child: Text(index.name),
                            value: index.id,
                          );
                        }).toList(),
                        hint: Text(countryHint),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (newVal) {
                          setState(() {
                            isCountrySelected = true;
                            CountryId = newVal;
                            getStateList(CountryId.toString());
                          });
                        },
                        value: CountryId,
                      ),
                    ),
                  ),
                ),
              ),
              //State Drop Down
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Center(
                      child: DropdownButton(
                        items: stateList.map((index) {
                          return DropdownMenuItem(
                            child: Text(index.name),
                            value: index.id,
                          );
                        }).toList(),
                        hint: Text(stateHint),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (newVal) {
                          print(newVal);
                          setState(() {
                            isStateSelected = true;
                            StateId = newVal;
                            getCityList(StateId.toString());
                          });
                        },
                        value: StateId,
                      ),
                    ),
                  ),
                ),
              ),
              //City Drop Down
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Center(
                      child: DropdownButton(
                        items: cityList.map((index) {
                          return DropdownMenuItem(
                            child: Text(index.name),
                            value: index.id,
                          );
                        }).toList(),
                        hint: Text(cityHint),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (newVal) {
                          setState(() {
                            isCitySelected = true;
                            CityId = newVal;
                          });
                        },
                        value: CityId,
                      ),
                    ),
                  ),
                ),
              ),
              //Address TextField
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
                child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      labelText: 'Address',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateAddress ? "Please enter Address" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
              //Button
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 32.0, bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _checkInternet.check().then((value) {
                      if (value != null && value) {
                        validateData();
                      } else {
                        toast().showToast(
                            'Please check your internet connection...');
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
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showGetPersonDetailsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showGetPersonDetailsSuccess(GetPersonDetailsModel personDetailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (personDetailsModel.status == 0) {
      firstNameController.text = personDetailsModel.students[0].firstname;
      lastNameController.text = personDetailsModel.students[0].lastname;
      addressController.text = personDetailsModel.students[0].address;
      setState(() {
        _imageUrl = personDetailsModel.students[0].imagePath;
        countryHint = personDetailsModel.students[0].country;
        sCountryId = personDetailsModel.students[0].countryId.toString();
        stateHint = personDetailsModel.students[0].state;
        sStateId = personDetailsModel.students[0].stateId.toString();
        cityHint = personDetailsModel.students[0].city;
        sCityId = personDetailsModel.students[0].cityId.toString();
        isFirstTime = true;
      });
      getCountry();
    } else {
      setState(() {
        bodyMsg = personDetailsModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showCountryError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showCountrySuccess(CountryModel countryModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (countryModel.status == 0) {
      countryList.addAll(countryModel.countries);
      // if(isFirstTime){
      //   getStateList(sCountryId);
      // }
    } else {
      setState(() {
        bodyMsg = countryModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showCityError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showCitySuccess(CityModel cityModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (cityModel.status == 0) {
      cityList.addAll(cityModel.cities);
      // setState(() {
      //   isFirstTime = false;
      // });
    } else {
      setState(() {
        bodyMsg = cityModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showStateError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showStateSuccess(StateModel stateModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (stateModel.status == 0) {
      stateList.addAll(stateModel.states);
      // if(isFirstTime){
      //   getCityList(sStateId);
      // }
    } else {
      setState(() {
        bodyMsg = stateModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showUpdatePersonDetailsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showUpdatePersonDetailsSuccess(
      UpdatePersonDetailsResponseModel personDetailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (personDetailsModel.status == 0) {
      toast().showToast('Details updated successfully.');
    } else {
      toast().showToast(personDetailsModel.message);
    }
  }
}
