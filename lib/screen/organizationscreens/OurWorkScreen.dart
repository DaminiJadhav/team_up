import 'package:flutter/material.dart';
import 'package:teamup/contract/UpdateOurWorkContract.dart';
import 'package:teamup/module/UpdateOurWorkModel.dart';
import 'package:teamup/presenter/UpdateOurWorkPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class OurWorkScreen extends StatefulWidget {
  String ourWork;

  OurWorkScreen(this.ourWork);

  @override
  _OurWorkScreenState createState() => _OurWorkScreenState();
}

class _OurWorkScreenState extends State<OurWorkScreen>
    implements UpdateOurWorkContract {
  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  UpdateOurWorkRequestModel requestModel;
  UpdateOurWorkPresenter ourWorkPresenter;

  _OurWorkScreenState() {
    ourWorkPresenter = new UpdateOurWorkPresenter(this);
  }

  //Controller
  final ourWorkController = TextEditingController();

  //validation
  bool validateOurWork = false;

  validateData() {
    setState(() {
      ourWorkController.text.isEmpty
          ? validateOurWork = true
          : validateOurWork = false;
    });
    if (!validateOurWork) {
      update();
    }
  }

  update() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.id = Preference.getUserId().toString();
    requestModel.ourWork = ourWorkController.text.trim();
    ourWorkPresenter.ourWork(requestModel, 'Organizations/PutWork');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new UpdateOurWorkRequestModel();
    ourWorkController.text = widget.ourWork;
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
        title: Text('Our Works'),
      ),
      body: Container(
        child: isInternetAvailable
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Our Works',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: TextField(
                          controller: ourWorkController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'Our Works',
                            labelText: 'Our Works',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateOurWork
                                ? 'Please enter Our Works'
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
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
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
                              'Update',
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
  void showOurWorkError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showOurWorkSuccess(UpdateOurWorkResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast(responseModel.message);
      Navigator.of(context).pop();
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
