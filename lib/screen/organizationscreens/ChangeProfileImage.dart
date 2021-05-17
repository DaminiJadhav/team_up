import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamup/contract/OrganizationChangeLogoContract.dart';
import 'package:teamup/module/OrganizationChangeLogoModel.dart';
import 'package:teamup/presenter/OrganizationChangeLogoPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class ChangeProfileImage extends StatefulWidget {
  String imageUrl;

  ChangeProfileImage(this.imageUrl);

  @override
  _ChangeProfileImageState createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage>
    implements OrganizationChangeLogoContract {
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  OrganizationChangeLogoRequestModel requestModel;

  OrganizationChangeLogoPresenter changeLogoPresenter;

  _ChangeProfileImageState() {
    changeLogoPresenter = new OrganizationChangeLogoPresenter(this);
  }

  //Image Picker
  File _image;
  String base64Image;
  bool isProfileSelected = false;
  List<int> imageBytes;

  Future _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      isProfileSelected = true;
    });
    imageBytes = await _image.readAsBytesSync();
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
    imageBytes = await _image.readAsBytesSync();
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
      isApiCallProcess = true;
    });
    requestModel.id = Preference.getUserId().toString();
    requestModel.imagePath = base64Image;
    changeLogoPresenter.changeOrgLogo(requestModel, 'Organizations/PutImage');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new OrganizationChangeLogoRequestModel();
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
        title: Text('Change Profile Picture'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Icon(Icons.edit)),
          ),
        ],
      ),
      body: Container(
          child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: isProfileSelected
                  ? Image.file(_image)
                  : widget.imageUrl != null
                      ? Image.network(widget.imageUrl)
                      : Image.asset('assets/art/profile.png'),
            ),
          ),
          Visibility(
            visible: isProfileSelected,
            child: Positioned(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Platform.isIOS ? 70 : 60,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  child: GestureDetector(
                    onTap: () {
                      _checkInternet.check().then((value) {
                        if (value != null && value) {
                          validateData();
                        } else {
                          toast().showToast(
                              'Please check your internet connection.');
                        }
                      });
                    },
                    child: Text('Change',
                        style: Theme.of(context).textTheme.title),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
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
  void showSuccess(OrganizationChangeLogoResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast('Logo change successfully.');
      Preference.setUserImage(responseModel.ImagePath);
      Navigator.of(context).pop();
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
