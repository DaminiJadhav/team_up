import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/SubmitProjectContract.dart';
import 'package:teamup/module/SubmitProjectModel.dart';
import 'package:teamup/presenter/SubmitProjectPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class SubmitProject extends StatefulWidget {
  String pId;

  SubmitProject(this.pId);

  @override
  _SubmitProjectState createState() => _SubmitProjectState();
}

class _SubmitProjectState extends State<SubmitProject>
    implements SubmitProjectContract {
  var isAgree = false;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;

  SubmitProjectPresenter submitProjectPresenter;
  SubmitProjectRequestModel requestModel;

  _SubmitProjectState() {
    submitProjectPresenter = new SubmitProjectPresenter(this);
  }

  //Controller
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();

  //validation
  bool validateDescription = false;
  bool validateLink = false;

  validateData() {
    setState(() {
      descriptionController.text.isEmpty
          ? validateDescription = true
          : validateDescription = false;
      linkController.text.isEmpty ? validateLink = true : validateLink = false;
    });
    if (descriptionController.text.length < 20) {
      setState(() {
        validateDescription = true;
      });
      toast().showToast('Description should be Minimum 20 Characters.');
      return false;
    }
    if (!isAgree) {
      toast().showToast('Please Agree the condition');
      return false;
    }
    if (!validateDescription && !validateLink && isAgree) {
      submitProject();
    }
  }

  submitProject() {
    requestModel = new SubmitProjectRequestModel();
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.projectId = widget.pId;
    requestModel.isStd = Preference.getIsStudent() ? true : false;
    requestModel.submittedById = Preference.getUserId().toString();
    requestModel.submittedDescription =
        descriptionController.text.toString().trim();
    requestModel.submittedLink = linkController.text.toString().trim();

    submitProjectPresenter.projectSubmit(
        requestModel, 'ProjectDetails/PutSubmitProject');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
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
        title: Text('Submit Project'),
      ),
      body: isInternetAvailable
          ? Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: Flexible(
                        child: Padding(
                    padding:
                          const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                    child: Text(
                        'Amazing! Your team did it. Add a little description of what you did and submit the files on below link.',
                        style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                      )),
                  // Center(
                  //     child: Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 16.0, right: 8.0, bottom: 8.0),
                  //   child: Text(
                  //     '',
                  //     style: TextStyle(fontSize: 18.0),
                  //   ),
                  // )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                    child: TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        maxLength: 500,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'Your Approach: 20-100 words',
                          labelText: 'Description',
                          hintStyle: TextStyle(color: Colors.black,),
                          errorText: validateDescription
                              ? 'Please enter Description'
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
                    height: 10.0,
                  ),
                  Center(
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text(
                          'Here is the submission link. Copy and paste it in browser and submit the zip file of all the project file.',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  //     child: Text(
                  //       '',
                  //       style: TextStyle(fontSize: 16.0),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
                    child: TextField(
                        controller: linkController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'https://......',
                          labelText: 'Link',
                          hintStyle: TextStyle(color: Colors.black),
                          errorText: validateLink
                              ? 'Please paste the Link or Url'
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
                    height: 10.0,
                  ),
                  Center(
                    child: CheckboxListTile(
                      title: Flexible(
                        child: Text(
                            'The Project files were created and developed by us.'),
                      ),
                      value: isAgree,
                      onChanged: (newValue) {
                        setState(() {
                          isAgree = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Center(
                      child: FlatButton(
                        minWidth: MediaQuery.of(context).size.width,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.only(top:12.0,bottom: 12.0),
                          child: Text(
                            'Submit ',
                            style: TextStyle(color: Colors.white,fontSize: 18.0),
                          ),
                        ),
                        onPressed: () {
                          _checkInternet.check().then((value) {
                            if (value != null && value) {
                              validateData();
                            } else {
                              toast().showToast('No Internet connection.');
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogHelper.Error(context, 'Submit Project',
        'Something went wrong, While Submitting Project');
  }

  @override
  void showSuccess(SubmitProjectResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      DialogHelper.Success(context, 'Submit Project', responseModel.message);
    } else {
      DialogHelper.Error(context, 'Submit Project', responseModel.message);
    }
  }
}
