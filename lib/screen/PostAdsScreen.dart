import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamup/contract/PostAdContract.dart';
import 'package:teamup/module/PostAdModel.dart';
import 'package:teamup/presenter/PostAdPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class PostAds extends StatefulWidget {
  @override
  _PostAdsState createState() => _PostAdsState();
}

class _PostAdsState extends State<PostAds> implements PostAdContract {
  PostAdPresenter postAdPresenter;
  PostAdRequestModel postAdRequestModel;

  checkInternet _checkInternet;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  bool isImageLoad = false;
  File _image;
  bool _hasPoster = false;
  bool _hasContent = false;

  String base64Image;

  final headingController = TextEditingController();
  final publisherController = TextEditingController();
  final emailIdController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final contentController = TextEditingController();

  bool validateHeading = false;
  bool validateEmail = false;
  bool validateMobile = false;
  bool validateContent = false;
  bool validatePublisher = false;
  int index = 1;

  _PostAdsState() {
    postAdPresenter = new PostAdPresenter(this);
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isStartDateSelected = false;
  bool isEndDateSelected = false;

  Future<void> dateDialog() async {
    final DateTime picked = await showDatePicker(
        helpText: 'Select Event Date',
        context: context,
        initialDate: startDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
        isStartDateSelected = true;
      });
  }

  Future<void> endDateDialog() async {
    final DateTime picked = await showDatePicker(
        helpText: 'Select End Date',
        context: context,
        initialDate: endDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
        isEndDateSelected = true;
      });
  }

  Future _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      isImageLoad = true;
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
      isImageLoad = true;
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
                      title: new Text('Gallery'),
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
      headingController.text.isEmpty
          ? validateHeading = true
          : validateHeading = false;
      publisherController.text.isEmpty
          ? validatePublisher = true
          : validatePublisher = false;
      emailIdController.text.isEmpty
          ? validateEmail = true
          : validateEmail = false;
      mobileNumberController.text.isEmpty
          ? validateMobile = true
          : validateMobile = false;
    });

    bool isEmailValid = EmailValidator.validate(emailIdController.text.trim());
    if (isEmailValid) {
      if (mobileNumberController.text.length != 10) {
        setState(() {
          validateMobile = true;
        });
      } else {
        validateImageAndContent();
      }
    } else {
      setState(() {
        validateEmail = true;
      });
    }
  }

  validateImageAndContent() {
    if (_hasPoster == true) {
      if (!isImageLoad) {
        toast().showToast('Please Select Poster.');
        return false;
      }
    }
    if (_hasContent == true) {
      setState(() {
        validateContent = false;
      });
      if (contentController.text.isEmpty) {
        setState(() {
          validateContent = true;
        });
        return false;
      }
    }
    if (!isStartDateSelected) {
      toast().showToast('Please select Start Date.');
      return false;
    }
    if (!isEndDateSelected) {
      toast().showToast('Please select End Date.');
      return false;
    }
    postAdsData();
  }

  postAdsData() {
    postAdRequestModel.heading = headingController.text.trim();
    postAdRequestModel.publisherName = publisherController.text.trim();
    postAdRequestModel.posterStatus = _hasPoster;
    postAdRequestModel.poster = base64Image;
    postAdRequestModel.contentStatus = _hasContent;
    postAdRequestModel.content = contentController.text.trim();
    postAdRequestModel.email = emailIdController.text.trim();
    postAdRequestModel.contact = mobileNumberController.text.trim();
    postAdRequestModel.stdId =
        Preference.getIsStudent() ? Preference.getUserId().toString() : '';
    postAdRequestModel.orgId =
        Preference.getIsOrganization() ? Preference.getUserId().toString() : '';
    postAdRequestModel.startDate = startDate.toString();
    postAdRequestModel.endDate = endDate.toString();

    setState(() {
      isApiCallProcess = true;
    });
    postAdPresenter.postAd(postAdRequestModel, 'Advertisements/RegisterAdd');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    postAdRequestModel = new PostAdRequestModel();
    Preference.init();
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
          title: Text("Post Ad's"),
        ),
        body: isInternetAvailable
            ? Container(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Request Ads',
                                style: TextStyle(fontSize: 24.0),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/icons/postadsandevent.png',
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0,left: 16.0,right: 16.0),
                        child: Text(
                          'Fill up the following form to publish your ad on our platform.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Text(
                    //     'your ad on our platform.',
                    //     style: TextStyle(fontSize: 18.0),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: headingController,
                          decoration: InputDecoration(
                            hintText: 'Ad Heading',
                            labelText: 'Heading',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateHeading ? 'Please enter Heading' : null,
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
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: TextField(
                          controller: publisherController,
                          decoration: InputDecoration(
                            hintText: 'Publisher Name',
                            labelText: 'Publisher',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validatePublisher
                                ? 'Please enter Publisher Name'
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
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Does this Ad has poster ?',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  'No',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                CupertinoSwitch(
                                  value: _hasPoster,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasPoster = value;
                                    });
                                    FocusScope.of(context).requestFocus(FocusNode());
                                  },
                                ),
                                Text(
                                  'Yes',
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Visibility(
                        visible: _hasPoster,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _showPicker(context);
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: isImageLoad
                                          ? FileImage(_image)
                                          : AssetImage(
                                              'assets/icons/select_image.png'),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Does this Ad has Content ?',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  'No',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                CupertinoSwitch(
                                  value: _hasContent,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasContent = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Yes',
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _hasContent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: TextField(
                            controller: contentController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: 'Ad Content',
                              labelText: 'Content',
                              hintStyle: TextStyle(color: Colors.black),
                              errorText: validateContent
                                  ? 'Please enter Content'
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: emailIdController,
                          decoration: InputDecoration(
                            hintText: 'Email Id',
                            labelText: 'Email Id',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateEmail ? 'Please enter Email Id' : null,
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
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      child: TextField(
                          controller: mobileNumberController,
                          decoration: InputDecoration(
                            hintText: 'Contact Number',
                            labelText: 'Contact No.',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateMobile
                                ? 'Please enter Mobile Number'
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 16.0, right: 16.0),
                      child: GestureDetector(
                        onTap: dateDialog,
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: isStartDateSelected
                                    ? Text(
                                        "${startDate.toLocal()}".split(' ')[0])
                                    : Text('Select Start Date'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: GestureDetector(
                        onTap: endDateDialog,
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: isEndDateSelected
                                    ? Text("${endDate.toLocal()}".split(' ')[0])
                                    : Text('Select End Date'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _checkInternet.check().then((value) {
                            if (value != null && value) {
                              validateData();
                            } else {
                              toast().showToast(
                                  'Please Check your Internet Connection..');
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
                              'Submit',
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
              )
            : Container(
                child: Center(
                  child: Text(
                      "No Internet Connection Available..\n Please check your connection.."),
                ),
              ));
  }

  @override
  void showPostAdError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, please try again later..');
    DialogHelper.Error(
        context, 'Ad Posted.', 'Something went wrong, while posting ad.');
  }

  @override
  void showPostAdSuccess(PostAdResponseModel adResponseModel) {
    PostAdResponseModel responseModel;
    setState(() {
      isApiCallProcess = false;
      responseModel = adResponseModel;
    });
    if (responseModel.status == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
      toast().showToast('Ad Posted Successfully..');
      DialogHelper.Success(context, 'Ad Posted.', 'Ad Posted Successfully..');
    } else {
      DialogHelper.Error(
          context, 'Ad Posted.', 'Something went wrong, while posting ad.');
      toast().showToast('Something went wrong, please try again later..');
    }
  }
}
