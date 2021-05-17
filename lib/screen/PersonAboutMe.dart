import 'package:flutter/material.dart';
import 'package:teamup/contract/PersonAboutMeContract.dart';
import 'package:teamup/module/PersonAboutMeModel.dart';
import 'package:teamup/presenter/PersonAboutMePresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class PersonAboutMe extends StatefulWidget {
  String info;

  PersonAboutMe(this.info);

  @override
  _PersonAboutMeState createState() => _PersonAboutMeState();
}

class _PersonAboutMeState extends State<PersonAboutMe>
    implements PersonAboutMeContract {
  PersonAboutMePresenter aboutMePresenter;
  PersonAboutMeRequestModel personAboutMeRequestModel;
  bool isApiCallProcess = false;

  checkInternet _checkInternet;

  final aboutMeController = TextEditingController();
  bool validAboutMe = false;

  _PersonAboutMeState() {
    aboutMePresenter = new PersonAboutMePresenter(this);
  }

  validateData() {
    setState(() {
      aboutMeController.text.isEmpty
          ? validAboutMe = true
          : validAboutMe = false;
    });
    if (!validAboutMe) {
      updateData();
    } else {
      setState(() {
        aboutMeController.text.isEmpty
            ? validAboutMe = true
            : validAboutMe = false;
      });
    }
  }

  updateData() {
    setState(() {
      isApiCallProcess = true;
    });
    personAboutMeRequestModel.id = Preference.getUserId();
    personAboutMeRequestModel.isStudent = true;
    personAboutMeRequestModel.aboutMyself = aboutMeController.text.trim();
    personAboutMeRequestModel.isfaculty = "";
    personAboutMeRequestModel.isorg = "";
    aboutMePresenter.updateAbout(
        personAboutMeRequestModel, 'Students/PutAboutMe');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    aboutMeController.text = widget.info;
    personAboutMeRequestModel = new PersonAboutMeRequestModel();
    _checkInternet = new checkInternet();
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
        title: Text('About Me'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Update Your Self',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: TextField(
                    controller: aboutMeController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'About Your Self',
                      labelText: 'About',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validAboutMe ? 'Please enter About your self' : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
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
  void showAboutMeUpdateError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showAboutMeUpdateSuccess(
      PersonAboutMeResponseModel aboutMeResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (aboutMeResponseModel.status == 0) {
      toast().showToast('About your self updated successfully..');
    } else {
      toast().showToast(aboutMeResponseModel.message);
    }
  }
}
