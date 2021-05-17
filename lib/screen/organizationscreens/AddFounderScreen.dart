import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamup/contract/AddFounderContract.dart';
import 'package:teamup/module/AddFounderModel.dart';
import 'package:teamup/presenter/AddFounderPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddFounderScreen extends StatefulWidget {
  @override
  _AddFounderScreenState createState() => _AddFounderScreenState();
}

class _AddFounderScreenState extends State<AddFounderScreen>
    implements AddFounderContract {
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  AddFounderRequestModel requestModel;

  //Presenter
  AddFounderPresenter addFounderPresenter;

  _AddFounderScreenState() {
    addFounderPresenter = new AddFounderPresenter(this);
  }

  //Controller
  final fNameController = TextEditingController();
  final fEmailController = TextEditingController();

  //validation
  bool validateName = false;
  bool validateEmail = false;
  bool isProfileSelected = false;

  //Image Picker

  String _imageUrl;
  File _image;
  String base64Image;

  Future _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      isProfileSelected = true;
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
      isProfileSelected = true;
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

  validateData() {
    setState(() {
      fNameController.text.isEmpty ? validateName = true : validateName = false;
      fEmailController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
    });
    if (!validateName && !validateEmail) {
      addFounder();
    }
  }

  addFounder() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.orgId = Preference.getUserId().toString();
    requestModel.name = fNameController.text.trim();
    requestModel.email = fEmailController.text.trim();
    requestModel.imagePath = base64Image;

    addFounderPresenter.founderAdd(
        requestModel, 'FounderLists/PostFounderList');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new AddFounderRequestModel();
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
        title: Text('Add Founder'),
      ),
      body: Container(
        child: isInternetAvailable
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),

                    //Profile Image Part
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
                              backgroundImage: isProfileSelected
                                  ? FileImage(_image)
                                  : _imageUrl != null
                                      ? NetworkImage(_imageUrl)
                                      : AssetImage('assets/art/profile.png'),
                              radius: 70.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Name
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 40.0),
                      child: TextField(
                          controller: fNameController,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            labelText: 'Name',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateName ? "Please enter Full Name" : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),

                    //Email
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 32.0),
                      child: TextField(
                          controller: fEmailController,
                          decoration: InputDecoration(
                            hintText: 'Email Id',
                            labelText: 'Email Id',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateEmail ? "Please enter Email Id" : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),
                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 40.0, bottom: 16.0),
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
                          margin: EdgeInsets.symmetric(horizontal: 40.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,

                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Text('Please check your internet connection.'),
              ),
      ),
    );
  }

  @override
  void showAddFounderError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showAddFounderSuccess(AddFounderResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast(responseModel.message);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
