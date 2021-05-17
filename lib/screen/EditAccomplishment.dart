import 'package:flutter/material.dart';
import 'package:teamup/contract/GetAccomplishmentDetailContract.dart';
import 'package:teamup/contract/UpdateAccomplishmentContract.dart';
import 'package:teamup/module/GetAccomplishmentDetailModel.dart';
import 'package:teamup/module/UpdateAccomplishmentModel.dart';
import 'package:teamup/presenter/GetAccomplishmentDetailPresenter.dart';
import 'package:teamup/presenter/UpdateAccomplishmentPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class EditAccomplishment extends StatefulWidget {
  String aId;

  EditAccomplishment(this.aId);

  @override
  _EditAccomplishmentState createState() => _EditAccomplishmentState();
}

class _EditAccomplishmentState extends State<EditAccomplishment>
    implements GetAccomplishmentDetailContract, UpdateAccomplishmentContract {
  GetAccomplishmentDetailPresenter detailPresenter;
  UpdateAccomplishmentPresenter accomplishmentPresenter;
  UpdateAccomplishmentModel requestModel;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  String bodyMsg = "";

  final certificateNameController = TextEditingController();
  final issuingAuthorityController = TextEditingController();

  bool validateCName = false;
  bool validateIssuingAuthority = false;
  bool isDateSelected = false;

  String finalIssuingDate = "";
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        isDateSelected = true;
        String sYear = currentDate.year.toString();
        String sMonth = currentDate.month.toString();
        String sDate = currentDate.day.toString();
        finalIssuingDate = sDate + "-" + sMonth + "-" + sYear;
      });
    }
  }

  _EditAccomplishmentState() {
    detailPresenter = new GetAccomplishmentDetailPresenter(this);
    accomplishmentPresenter = new UpdateAccomplishmentPresenter(this);
  }

  getDetails() {
    setState(() {
      isApiCallProcess = true;
    });
    String aId = widget.aId;
    String userId = Preference.getUserId().toString();
    detailPresenter.getDetailsAccomplishment(
        'Certification/GetEachCertificates?StdId=$userId&CertificateId=$aId');
  }

  validateData() {
    setState(() {
      certificateNameController.text.isEmpty
          ? validateCName = true
          : validateCName = false;
      issuingAuthorityController.text.isEmpty
          ? validateIssuingAuthority = true
          : validateIssuingAuthority = false;
    });
    if (!isDateSelected) {
      toast().showToast('Please select Issuing Date');
      return false;
    }
    if (!validateCName && !validateIssuingAuthority && isDateSelected) {
      updateDetail();
    }
  }

  updateDetail() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.id = widget.aId;
    requestModel.issuedDate = finalIssuingDate;
    requestModel.issuedAuthorityName = issuingAuthorityController.text.trim();
    requestModel.name = certificateNameController.text.trim();
    accomplishmentPresenter.accomplishmentUpdate(
        requestModel, 'Certification/PutPre_Certification');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    requestModel = new UpdateAccomplishmentModel();
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
        title: Text('Update Accomplishment'),
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
                        'Update Accomplishment',
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
                          controller: certificateNameController,
                          decoration: InputDecoration(
                            hintText: 'Certificate Name',
                            labelText: 'Certificate',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateCName
                                ? "Please enter Certificate Name"
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
                          controller: issuingAuthorityController,
                          decoration: InputDecoration(
                            hintText: 'Issuing By Name',
                            labelText: 'Issuing By',
                            hintStyle: TextStyle(color: Colors.black),
                            errorText: validateIssuingAuthority
                                ? "Please enter Issuing By Name"
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
                                  isDateSelected
                                      ? finalIssuingDate
                                      : 'Select Issuing Date',
                                ),
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
  void showGetAccomplishmentDetailError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showGetAccomplishmentDetailSuccess(
      GetAccomplishmentDetailModel accomplishmentDetailModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (accomplishmentDetailModel.status == 0) {
      certificateNameController.text =
          accomplishmentDetailModel.certificate[0].name;
      issuingAuthorityController.text =
          accomplishmentDetailModel.certificate[0].issuedAuthorityName;
      setState(() {
        isDateSelected = true;
        finalIssuingDate = accomplishmentDetailModel.certificate[0].issuedDate;
      });
    } else {
      setState(() {
        bodyMsg = accomplishmentDetailModel.message;
        isInternetAvailable = false;
      });
    }
  }

  @override
  void showUpdateAccomplishmentError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later.');
  }

  @override
  void showUpdateAccomplishmentSuccess(
      UpdateAccomplishmentResponseModel updateAccomplishmentResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (updateAccomplishmentResponseModel.status == 0) {
      toast().showToast('Accomplishment updated successfully.');
    } else {
      toast().showToast(updateAccomplishmentResponseModel.message);
    }
  }
}
