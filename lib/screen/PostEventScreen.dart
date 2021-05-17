import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamup/contract/PostEventContract.dart';
import 'package:teamup/module/PostEventModel.dart';
import 'package:teamup/presenter/PostEventPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class PostEvents extends StatefulWidget {
  @override
  _PostEventsState createState() => _PostEventsState();
}

class _PostEventsState extends State<PostEvents> implements PostEventContract {
  PostEventPresenter postEventPresenter;
  PostEventRequestModel postEventRequestModel;

  checkInternet _checkInternet;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  final headingController = TextEditingController();
  final emailIdController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final contentController = TextEditingController();
  final publisherController = TextEditingController();

  bool validateHeading = false;
  bool validateEmailId = false;
  bool validateContact = false;
  bool validateAddress = false;
  bool validateContent = false;
  bool validatePublisher = false;

  bool isImageLoad = false;
  File _image;
  String base64Image;
  bool _hasPoster = false;
  bool _hasContent = false;


  DateTime eventDate = DateTime.now();
  bool isEventDateSelect = false;

  Future<void> _dateDialog() async {
    final DateTime picked = await showDatePicker(
        helpText: 'Select Event Date',
        context: context,
        initialDate: eventDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != eventDate)
      setState(() {
        eventDate = picked;
        isEventDateSelect = true;
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

  _PostEventsState() {
    postEventPresenter = new PostEventPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    Preference.init();
    postEventRequestModel = new PostEventRequestModel();
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

  validateData() {
    setState(() {
      headingController.text.isEmpty
          ? validateHeading = true
          : validateHeading = false;
      publisherController.text.isEmpty
          ? validatePublisher = true
          : validatePublisher = false;
      emailIdController.text.isEmpty
          ? validateEmailId = true
          : validateEmailId = false;
      contactNumberController.text.isEmpty
          ? validateContact = true
          : validateContact = false;
      addressController.text.isEmpty
          ? validateAddress = true
          : validateAddress = false;
    });
    if (!EmailValidator.validate(emailIdController.text.trim())) {
      setState(() {
        validateEmailId = true;
      });
      return false;
    }
    if (contactNumberController.text.length != 10) {
      setState(() {
        validateContact = true;
      });
      return false;
    }
    if (!isEventDateSelect) {
      toast().showToast('Please select Event Date..');
      return false;
    }
    validateImageAndContent();
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
    postEvent();
  }

  postEvent() {
    postEventRequestModel.eventName = headingController.text.trim();
    postEventRequestModel.publisher = publisherController.text.trim();
    postEventRequestModel.posterStatus = _hasPoster;
    postEventRequestModel.poster = base64Image;
    postEventRequestModel.contentStatus = _hasContent;
    postEventRequestModel.content = contentController.text.trim();
    postEventRequestModel.emailId = emailIdController.text.trim();
    postEventRequestModel.mobileNumber = contactNumberController.text.trim();
    postEventRequestModel.address = addressController.text.trim();
    postEventRequestModel.eventDate = eventDate.toString();
    postEventRequestModel.stdId =
        Preference.getIsStudent() ? Preference.getUserId().toString() : '';
    postEventRequestModel.orgId =
        Preference.getIsOrganization() ? Preference.getUserId().toString() : '';

    setState(() {
      isApiCallProcess = true;
    });
    postEventPresenter.postEvent(postEventRequestModel, 'Event/RegisterEvent');
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
          title: Text('Post Event'),
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
                              'Request Event',
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
                        'Fill up the following form to publish your events on our platform.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: TextField(
                                  controller: headingController,
                                  decoration: InputDecoration(
                                    hintText: 'Event Heading',
                                    labelText: 'Heading',
                                    hintStyle: TextStyle(color: Colors.black),
                                    errorText: validateHeading
                                        ? 'Please enter Heading'
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
                                  left: 16.0, right: 16.0, top: 16.0),
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
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Does this Event has poster ?',
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
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Does this Event has Content ?',
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
                                      hintText: 'Event Content',
                                      labelText: 'Content',
                                      hintStyle: TextStyle(color: Colors.black),
                                      errorText: validateContent
                                          ? 'Please enter Event Content'
                                          : null,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                    errorText: validateEmailId
                                        ? 'Please enter Email Id'
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
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: TextField(
                                  controller: contactNumberController,
                                  decoration: InputDecoration(
                                    hintText: 'Contact Number',
                                    labelText: 'Contact No.',
                                    hintStyle: TextStyle(color: Colors.black),
                                    errorText: validateContact
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
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: TextField(
                                  controller: addressController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: 'Event Address',
                                    labelText: 'Address',
                                    hintStyle: TextStyle(color: Colors.black),
                                    errorText: validateAddress
                                        ? 'Please enter Address'
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
                                  top: 16.0, left: 16.0, right: 16.0),
                              child: GestureDetector(
                                onTap: _dateDialog,
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: isEventDateSelect
                                            ? Text("${eventDate.toLocal()}"
                                                .split(' ')[0])
                                            : Text('Select Event Date'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 8.0,
                                  bottom: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _checkInternet.check().then((value) {
                                    if (value != null && value) {
                                      validateData();
                                    } else {
                                      toast().showToast(
                                          'Please check your Internet Connection..');
                                    }
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
                            ),
                          ],
                        ),
                      )
                      //postEventsForm(context),
                      ),
                ],
              ))
            : Container(
                child: Center(
                  child: Text(
                      "No Internet Connection Available..\n Please check your connection.."),
                ),
              ));
  }

  @override
  void showPostEventError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, please try again later..');
    DialogHelper.Error(context, 'Event Posted.', 'Something went wrong, while posting Event.');

  }

  @override
  void showPostEventSuccess(PostEventResponseModel responseModel) {
    PostEventResponseModel eventResponseModel;
    setState(() {
      isApiCallProcess = false;
      eventResponseModel = responseModel;
    });
    if (eventResponseModel.status == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget));
      toast().showToast('Event Posted Successfully..');
      DialogHelper.Success(context, 'Event Posted.', 'Event Posted Successfully..');
    } else {
      toast().showToast('Something went wrong, please try again later..');
      DialogHelper.Error(context, 'Event Posted.', 'Something went wrong, while posting Event.');

    }
  }
}
