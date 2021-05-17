import 'package:flutter/material.dart';
import 'package:teamup/contract/AddEducationContract.dart';
import 'package:teamup/module/AddEducationModel.dart';
import 'package:teamup/presenter/AddEducationPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddNewEducation extends StatefulWidget {
  @override
  _AddNewEducationState createState() => _AddNewEducationState();
}

class _AddNewEducationState extends State<AddNewEducation>
    implements AddEducationContract {
  AddEducationPresenter addEducationPresenter;
  AddEducationRequestModel requestModel;
  bool isApiCallProcess = false;
  checkInternet _checkInternet;

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
  DateTime currentStartDate = DateTime.now();
  DateTime currentEndDate = DateTime.now();
  int dateIndex = 1;

  _AddNewEducationState() {
    addEducationPresenter = new AddEducationPresenter(this);
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
      addEducation();
    }
  }

  addEducation() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.stdId = Preference.getUserId().toString();
    requestModel.courseName = courseController.text.trim();
    requestModel.intituteName = collegeController.text.trim();
    requestModel.grade = gradeController.text.trim();
    requestModel.facultyId = "";
    requestModel.startDate = currentStartDate.toString();
    requestModel.endDate = currentEndDate.toString();
    addEducationPresenter.educationAdd(
        requestModel, 'Education/PostPre_Education');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentStartDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentStartDate) {
      if (dateIndex == 1) {
        setState(() {
          currentStartDate = picked;
          isStartDateSelect = true;
          String sYear = currentStartDate.year.toString();
          String sMonth = currentStartDate.month.toString();
          String sDate = currentStartDate.day.toString();
          finalStartDate = sDate + "-" + sMonth + "-" + sYear;
        });
      } else {
        setState(() {
          currentEndDate = picked;
          isEndDateSelect = true;
          String sYear = currentEndDate.year.toString();
          String sMonth = currentEndDate.month.toString();
          String sDate = currentEndDate.day.toString();
          finalEndDate = sDate + "-" + sMonth + "-" + sYear;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new checkInternet();
    requestModel = new AddEducationRequestModel();
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
        title: Text('Add Education'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Add Education',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
                      errorText:
                      validateCourse ? "Please enter Qualification" : null,
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
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: TextField(
                    controller: collegeController,
                    decoration: InputDecoration(
                      hintText: 'College Name',
                      labelText: 'College',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                      validateCollege ? "Please enter Collage Name" : null,
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
                padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: TextField(
                    controller: gradeController,
                    decoration: InputDecoration(
                      hintText: 'Grade/Marks',
                      labelText: 'Grade/Marks',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                      validateGrade ? "Please enter Grade/Marks" : null,
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
                padding:
                const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                padding:
                const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                        color: Theme
                            .of(context)
                            .primaryColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(
                      child: Text(
                        'Add',
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
  void showAddEducationError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showAddEducationSuccess(AddEducationResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      toast().showToast('Education added successfully...');
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
