import 'package:flutter/material.dart';
import 'package:teamup/contract/FeedbackContract.dart';
import 'package:teamup/contract/GetFeedbackContract.dart';
import 'package:teamup/module/FeedbackModel.dart';
import 'package:teamup/module/GetFeedbackModel.dart';
import 'package:teamup/presenter/FeedbackPresenter.dart';
import 'package:teamup/presenter/GetFeedbackPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class GiveFeedback extends StatefulWidget {
  @override
  _GiveFeedback createState() => _GiveFeedback();
}

class _GiveFeedback extends State<GiveFeedback>
    implements FeedbackContract, GetFeedbackContract {
  FeedbackPresenter feedbackPresenter;
  GetFeedbackPresenter getFeedbackPresenter;
  FeedbackRequestModel feedbackRequestModel;
  GetFeedbackRequestModel getFeedbackRequestModel;
  final descriptionController = TextEditingController();
  bool validateDescription = false;
  checkInternet _checkInternet;

  bool isVisible = true;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;

  _GiveFeedback() {
    feedbackPresenter = new FeedbackPresenter(this);
    getFeedbackPresenter = new GetFeedbackPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    feedbackRequestModel = new FeedbackRequestModel();
    getFeedbackRequestModel = new GetFeedbackRequestModel();
    Preference.init();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        checkFeedback();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  checkFeedback() {
    getFeedbackRequestModel.id = Preference.getUserId().toString();
    getFeedbackRequestModel.isStudent =
        Preference.getIsStudent() ? true : false;
    getFeedbackRequestModel.isOrganization =
        Preference.getIsOrganization() ? true : false;

    getFeedbackPresenter.GetFeedback(
        getFeedbackRequestModel, 'Feedback/PostFeedbacksCheck');
  }

  validateData() {
    setState(() {
      descriptionController.text.isEmpty
          ? validateDescription = true
          : validateDescription = false;
    });
    if (validateDescription == false) {
      _submitFeedback(descriptionController.text.trim());
    } else {
      setState(() {
        descriptionController.text.isEmpty
            ? validateDescription = true
            : validateDescription = false;
      });
    }
  }

  _submitFeedback(String feedback) {
    feedbackRequestModel.Id = Preference.getUserId().toString();
    feedbackRequestModel.isStudent = Preference.getIsStudent() ? true : false;
    feedbackRequestModel.isOrganization =
        Preference.getIsOrganization() ? true : false;
    feedbackRequestModel.feedback = feedback;
    setState(() {
      isApiCallProcess = true;
    });
    feedbackPresenter.postFeedback(
        feedbackRequestModel, 'Feedback/PostFeedback');
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
          title: Text('Feedback'),
        ),
        body: isInternetAvailable
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text('Please wait..'),
                    ),
                  )
                : Container(
                    child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 16.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Write to us',
                                    style: TextStyle(fontSize: 24.0),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 16.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/icons/feedback.png',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0,right: 16.0),
                        child: Text(
                          "We value every review. That's how we grow!.",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 60.0),
                        child: Text(
                          'Description',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, right: 16.0, top: 16.0, bottom: 16.0),
                        child: TextField(
                            enabled: isVisible,
                            controller: descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: 'Review',
                              labelText: 'Review',
                              hintStyle: TextStyle(color: Colors.black),
                              errorText: validateDescription
                                  ? 'Please enter Feedback'
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
                      Visibility(
                        visible: isVisible,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 150.0,
                              height: 50.0,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _checkInternet.check().then((value) {
                                    if (value != null && value) {
                                      validateData();
                                    } else {
                                      toast().showToast(
                                          'Please check your Internet Connection..');
                                    }
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(
                                    'Give a review on the store!',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, right: 16.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 100.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      // Redirect to play store and app store.
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    child: Center(
                                      child: Text(
                                        'Review',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Text(
                            'Thank You!',
                            style: TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ))
            : Container(
                child: Center(
                  child: Text('Please check Internet Connection..'),
                ),
              ));
  }

  @override
  void showPostError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong,Please try again later..');
  }

  @override
  void showPostSuccess(FeedbackResponseModel responseModel) {
    FeedbackResponseModel response;
    setState(() {
      isApiCallProcess = false;
      response = responseModel;
    });
    if (response.status == 0) {
      toast().showToast('Feedback Submitted Successfully..');
      setState(() {
        isVisible = false;
      });
    } else {
      toast().showToast('Something went wrong,Please try again later..');
    }
  }

  @override
  void showGetFeedbackError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong,Please try again later..');
  }

  @override
  void showGetFeedbackSuccess(GetFeedbackResponseModel success) {
    GetFeedbackResponseModel responseModel;
    setState(() {
      isApiCallProcess = false;
      responseModel = success;
    });
    if (responseModel.status == 1) {
      setState(() {
        isVisible = false;
        descriptionController.text = 'Feedback Already Given.. \n Thank you';
      });
      toast().showToast('Feedback is Already given..');
    } else {
      setState(() {
        isVisible = true;
      });
    }
  }
}
