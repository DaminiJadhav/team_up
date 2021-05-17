import 'package:flutter/material.dart';
import 'package:teamup/contract/AddExperienceContract.dart';
import 'package:teamup/module/AddExperienceModel.dart';
import 'package:teamup/presenter/AddExperiencePresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddNewExperience extends StatefulWidget {
  @override
  _AddNewExperienceState createState() => _AddNewExperienceState();
}

class _AddNewExperienceState extends State<AddNewExperience>
    implements AddExperienceContract {
  AddExperiencePresenter addExperiencePresenter;
  checkInternet _checkInternet;
  AddExperienceRequestModel requestModel;
  bool isApiCallProcess = false;

  _AddNewExperienceState() {
    addExperiencePresenter = new AddExperiencePresenter(this);
  }

  final companyNameController = TextEditingController();
  final roleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  bool validateCompany = false;
  bool validateRole = false;
  bool validateAddress = false;
  bool validateDescription = false;
  bool isStartDateSelect = false;
  bool isEndDateSelect = false;
  bool checkBoxValue = false;

  validateData() {
    setState(() {
      companyNameController.text.isEmpty
          ? validateCompany = true
          : validateCompany = false;
      roleController.text.isEmpty ? validateRole = true : validateRole = false;
      descriptionController.text.isEmpty
          ? validateDescription = true
          : validateDescription = false;
      addressController.text.isEmpty
          ? validateAddress = true
          : validateAddress = false;
    });
    if (!isStartDateSelect) {
      toast().showToast('Please select Start Date');
      return false;
    }
   if(!checkBoxValue){
     if (!isEndDateSelect) {
       toast().showToast('Please select End Date');
       return false;
     }
   }
    if (!validateCompany &&
        !validateRole &&
        !validateDescription &&
        !validateAddress &&
        isStartDateSelect) {
      addExperience();
    }
  }

  addExperience() {
    if (checkBoxValue) {
      setState(() {
        finalEndDate = "";
      });
    }
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.stdId = Preference.getUserId().toString();
    requestModel.facultyId = "";
    requestModel.companyName = companyNameController.text.trim();
    requestModel.yourRole = roleController.text.trim();
    requestModel.description = descriptionController.text.trim();
    requestModel.address = addressController.text.trim();
    requestModel.startDate = currentStartDate.toString();
    requestModel.endDate = currentEndDate.toString();
    requestModel.isCurrent = checkBoxValue;

    addExperiencePresenter.experienceAdd(
        requestModel, 'Experience/PostPre_Experience');
  }

  String finalStartDate = "";
  String finalEndDate = "";
  DateTime currentStartDate = DateTime.now();
  DateTime currentEndDate = DateTime.now();


  int dateIndex = 1;

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
    _checkInternet = new checkInternet();
    requestModel = new AddExperienceRequestModel();
    Preference.init();
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
        title: Text('Add Experience'),
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
                  'Add Experience',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                    controller: companyNameController,
                    decoration: InputDecoration(
                      hintText: 'Company Name',
                      labelText: 'Company',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateCompany ? "Please enter Company Name" : null,
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
                    controller: roleController,
                    decoration: InputDecoration(
                      hintText: 'Role',
                      labelText: 'Role',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: validateRole ? "Please enter your Role" : null,
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
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText: validateDescription
                          ? "Please enter Description"
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
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Company Address',
                      labelText: 'Address',
                      hintStyle: TextStyle(color: Colors.black),
                      errorText:
                          validateAddress ? "Please enter Address" : null,
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
                    const EdgeInsets.only(left: 24.0, right: 16.0, top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Currently Working Here ? ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                        value: checkBoxValue,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });
                        }),
                  ],
                ),
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
              Visibility(
                visible: !checkBoxValue,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (!checkBoxValue) {
                        setState(() {
                          dateIndex = 2;
                        });
                        _selectDate(context);
                      }
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
              ),
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
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
  void showAddExperienceError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showAddExperienceSuccess(
      AddExperienceResponseModel experienceResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (experienceResponseModel.status == 0) {
      toast().showToast('Experience added successfully...');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
    } else {
      toast().showToast(experienceResponseModel.message);
    }
  }
}
