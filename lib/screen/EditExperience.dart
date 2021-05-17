import 'package:flutter/material.dart';
import 'package:teamup/contract/GetExperienceDetailContract.dart';
import 'package:teamup/contract/UpdateExperienceContract.dart';
import 'package:teamup/module/GetExperienceDetailModel.dart';
import 'package:teamup/module/UpdateExperienceModel.dart';
import 'package:teamup/presenter/GetExperienceDetailPresenter.dart';
import 'package:teamup/presenter/UpdateExperiencePresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class EditExperience extends StatefulWidget {
  String eId;

  EditExperience(this.eId);

  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience>
    implements GetExperienceDetailContract, UpdateExperienceContract {
  GetExperienceDetailPresenter experienceDetailPresenter;
  UpdateExperiencePresenter updateExperiencePresenter;
  UpdateExperienceModel requestModel;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  String bodyMsg = "";

  _EditExperienceState() {
    experienceDetailPresenter = new GetExperienceDetailPresenter(this);
    updateExperiencePresenter = new UpdateExperiencePresenter(this);
  }

  String finalStartDate = "";
  String finalEndDate = "";
  DateTime currentDate = DateTime.now();
  int dateIndex = 1;

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

  getDetails() {
    setState(() {
      isApiCallProcess = true;
    });
    String eId = widget.eId;
    String userId = Preference.getUserId().toString();
    experienceDetailPresenter
        .getExpDetails('Experience/GetEachExperience?StdId=$userId&ExpId=$eId');
  }

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
    if (!checkBoxValue) {
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
      updateExperience();
    }
  }

  updateExperience() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.id = widget.eId;
    requestModel.startDate = finalStartDate;
    requestModel.endDate = finalEndDate;
    requestModel.isCurrent = checkBoxValue;
    requestModel.description = descriptionController.text.trim();
    requestModel.address = addressController.text.trim();
    requestModel.yourRole = roleController.text.trim();
    requestModel.companyName = companyNameController.text.trim();
    updateExperiencePresenter.experienceUpdate(
        requestModel, 'Experience/PutPre_Experience');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new UpdateExperienceModel();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getDetails();
      } else {
        setState(() {
          bodyMsg = "Please check your internet connection";
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
        title: Text('Update Experience'),
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
                        'Update Experience',
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
                          controller: companyNameController,
                          decoration: InputDecoration(
                            hintText: 'Company Name',
                            labelText: 'Company',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateCompany
                                ? "Please enter Company Name"
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
                          controller: roleController,
                          decoration: InputDecoration(
                            hintText: 'Role',
                            labelText: 'Role',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText:
                                validateRole ? "Please enter your Role" : null,
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
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
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
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 16.0, top: 16.0),
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
                    Visibility(
                      visible: !checkBoxValue,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
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
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
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
                              'Udpate',
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
            : Center(
                child: Text(bodyMsg),
              ),
      ),
    );
  }

  @override
  void showGetExperienceDetailError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showGetExperienceDetailSuccess(
      GetExperienceDetailModel experienceDetailModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (experienceDetailModel.status == 0) {
      companyNameController.text =
          experienceDetailModel.experience[0].companyName;
      roleController.text = experienceDetailModel.experience[0].yourRole;
      addressController.text = experienceDetailModel.experience[0].address;
      descriptionController.text =
          experienceDetailModel.experience[0].description;
      setState(() {
        isStartDateSelect = true;
        finalStartDate = experienceDetailModel.experience[0].startDate;
      });
      if (experienceDetailModel.experience[0].isCurrent) {
        setState(() {
          isEndDateSelect = true;
          finalEndDate = "Currently working here";
          checkBoxValue = true;
        });
      } else {
        setState(() {
          isEndDateSelect = true;
          finalEndDate = experienceDetailModel.experience[0].endDate;
          checkBoxValue = false;
        });
      }
    } else {
      setState(() {
        bodyMsg = experienceDetailModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showUpdateExperienceError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showUpdateExperienceSuccess(
      UpdateExperienceResponseModel updateExperienceResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (updateExperienceResponseModel.status == 0) {
      toast().showToast('Experience updated successfully.');
    } else {
      toast().showToast(updateExperienceResponseModel.message);
    }
  }
}
