import 'package:flutter/material.dart';
import 'package:teamup/contract/AddAccomplishmentContract.dart';
import 'package:teamup/module/AddAccomplishmentModel.dart';
import 'package:teamup/presenter/AddAccomplishmentPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddNewAccomplishment extends StatefulWidget {
  @override
  _AddNewAccomplishmentState createState() => _AddNewAccomplishmentState();
}

class _AddNewAccomplishmentState extends State<AddNewAccomplishment>
    implements AddAccomplishmentContract {
  AddAccomplishmentPresenter presenter;
  AddAccomplishmentRequestModel requestModel;

  checkInternet _checkInternet;
  final certificateNameController = TextEditingController();
  final issuingAuthorityController = TextEditingController();

  bool isApiCallProcess = false;

  bool validateCName = false;
  bool validateIssuingAuthority = false;
  bool isDateSelected = false;

  String finalIssuingDate = "";
  DateTime currentDate = DateTime.now();

  _AddNewAccomplishmentState() {
    presenter = new AddAccomplishmentPresenter(this);
  }

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
      addCertificate();
    }
  }

  addCertificate() {
    setState(() {
      isApiCallProcess = true;
    });
    requestModel.stdId = Preference.getUserId().toString();
    requestModel.facultyId = "";
    requestModel.name = certificateNameController.text.trim();
    requestModel.issuedAuthorityName = issuingAuthorityController.text.trim();
    requestModel.issuedDate = currentDate.toString();
    presenter.accomplishmentAdd(
        requestModel, 'Certification/PostPre_Certification');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new checkInternet();
    requestModel = new AddAccomplishmentRequestModel();
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
        title: Text('Add Accomplishment'),
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
                'Add Accomplishment',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
                    errorText:
                        validateCName ? "Please enter Certificate Name" : null,
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
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
      )),
    );
  }

  @override
  void showAccomplishmentError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later...');
  }

  @override
  void showAccomplishmentSuccess(
      AddAccomplishmentResponseModel accomplishmentResponseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (accomplishmentResponseModel.status == 0) {
      toast().showToast("Accomplishment added successfully...");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => super.widget));
    } else {
      toast().showToast(accomplishmentResponseModel.message);
    }
  }
}
