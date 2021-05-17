import 'package:flutter/material.dart';
import 'package:teamup/contract/GetEducationDetailContract.dart';
import 'package:teamup/contract/UpdateEducationContract.dart';
import 'package:teamup/module/GetEducationalDetailsModel.dart';
import 'package:teamup/module/UpdateEducationModel.dart';
import 'package:teamup/presenter/GetEducationDetailPresenter.dart';
import 'package:teamup/presenter/UpdateEducationPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class EditEducation extends StatefulWidget {
  String edId;

  EditEducation(this.edId);

  @override
  _EditEducationState createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation>
    implements GetEducationDetailContract, UpdateEducationContract {
  GetEducationDetailPresenter detailPresenter;
  UpdateEducationPresenter educationPresenter;
  UpdateEducationModel requestModel;

  bool isApiCallProcess = false;
  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  String bodyMsg = "";

  final courseController = TextEditingController();
  final collegeController = TextEditingController();
  final gradeController = TextEditingController();

  bool validateCourse = false;
  bool validateCollege = false;
  bool validateGrade = false;
  bool isStartDateSelect = false;
  bool isEndDateSelect = false;

  String finalStartDate = "";
  String finalEndDate = "";
  DateTime currentDate = DateTime.now();
  int dateIndex = 1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDate) {
      if (dateIndex == 1) {
        setState(() {
          currentDate = picked;
          isStartDateSelect = true;
          String sYear = currentDate.year.toString();
          String sMonth = currentDate.month.toString();
          String sDate = currentDate.day.toString();
          finalStartDate = sDate + "-" + sMonth + "-" + sYear;
        });
      } else {
        setState(() {
          currentDate = picked;
          isEndDateSelect = true;
          String sYear = currentDate.year.toString();
          String sMonth = currentDate.month.toString();
          String sDate = currentDate.day.toString();
          finalEndDate = sDate + "-" + sMonth + "-" + sYear;
        });
      }
    }
  }

  _EditEducationState() {
    detailPresenter = new GetEducationDetailPresenter(this);
    educationPresenter = new UpdateEducationPresenter(this);
  }

  getDetails() {
    setState(() {
      isApiCallProcess = true;
    });
    String eId = widget.edId;
    String userId = Preference.getUserId().toString();
    detailPresenter
        .getedDetails('Education/GetEachEducation?StdId=$userId&EduId=$eId');
  }

  validateData() {
    setState(() {
      courseController.text.isEmpty
          ? validateCourse = true
          : validateCourse = false;
      collegeController.text.isEmpty
          ? validateCollege = true
          : validateCollege = false;
      gradeController.text.isEmpty
          ? validateGrade = true
          : validateGrade = false;
    });
    if (!isStartDateSelect) {
      toast().showToast('Please select Start Date');
      return false;
    }
    if (!isEndDateSelect) {
      toast().showToast('Please select End Date');
      return false;
    }
    if (!validateCourse &&
        !validateCollege &&
        !validateGrade &&
        isStartDateSelect &&
        isEndDateSelect) {
      updateEducation();
    }
  }

  updateEducation() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.id = widget.edId;
    requestModel.endDate = finalEndDate;
    requestModel.startDate = finalStartDate;
    requestModel.grade = gradeController.text.trim();
    requestModel.intituteName = collegeController.text.trim();
    requestModel.courseName = courseController.text.trim();
    educationPresenter.educationUpdate(
        requestModel, 'Education/PutPre_Education');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new UpdateEducationModel();
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
        title: Text('Education'),
      ),
      body: Container(
        child: isInternetAvailable
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        'Update Education',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                          controller: courseController,
                          decoration: InputDecoration(
                            hintText: 'Qualification',
                            labelText: 'Qualification',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateCourse
                                ? "Please enter Qualification"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
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
                          controller: collegeController,
                          decoration: InputDecoration(
                            hintText: 'College Name',
                            labelText: 'College',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateCollege
                                ? "Please enter Collage Name"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
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
                          controller: gradeController,
                          decoration: InputDecoration(
                            hintText: 'Grade/Marks',
                            labelText: 'Grade/Marks',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateGrade
                                ? "Please enter Grade/Marks"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
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
                        onTap: () {
                          setState(() {
                            dateIndex = 1;
                          });
                          _selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  isStartDateSelect
                                      ? finalStartDate
                                      : 'Select Start Date',
                                ),
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
                        onTap: () {
                          setState(() {
                            dateIndex = 2;
                          });
                          _selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(isEndDateSelect
                                    ? finalEndDate
                                    : 'Select End Date'),
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
              )
            : Container(
                child: Center(
                  child: Text(bodyMsg),
                ),
              ),
      ),
    );
  }

  @override
  void showGetEducationDetailError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrogn, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showGetEducationDetailSuccess(
      GetEducationDetailModel educationDetailModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (educationDetailModel.status == 0) {
      courseController.text = educationDetailModel.preEducation[0].courseName;
      collegeController.text =
          educationDetailModel.preEducation[0].intituteName;
      gradeController.text = educationDetailModel.preEducation[0].grade;
      setState(() {
        isStartDateSelect = true;
        finalStartDate = educationDetailModel.preEducation[0].startDate;
      });
      if (educationDetailModel.preEducation[0].endDate != null) {
        setState(() {
          isEndDateSelect = true;
          finalEndDate = educationDetailModel.preEducation[0].endDate;
        });
      }
    } else {
      setState(() {
        bodyMsg = educationDetailModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showUdpateEducationError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showUpdateEducationSuccess(
      UpdateEducationResponseModel educationResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (educationResponseModel.status == 0) {
      toast().showToast('Education updated successfully.');
    } else {
      toast().showToast(educationResponseModel.message);
    }
  }
}
