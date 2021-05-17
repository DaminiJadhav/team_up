import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/AddHackathonContract.dart';
import 'package:teamup/module/AddHackathonModel.dart';
import 'package:teamup/presenter/AddHackathonPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddHackathon extends StatefulWidget {
  @override
  _AddHackathonState createState() => _AddHackathonState();
}

class _AddHackathonState extends State<AddHackathon>
    implements AddHackathonContract {
  AddHackathonPresenter hackathonPresenter;
  AddHackathonRequestModel addHackathonRequestModel;

  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;

  //Controller
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final problemStatementController = TextEditingController();
  final winningPriceController = TextEditingController();
  final websiteController = TextEditingController();
  final contactNoController = TextEditingController();

  //validation
  bool validateName = false;
  bool validateDescription = false;
  bool validateProblemStatement = false;
  bool validateWinningPrice = false;
  bool validateContact = false;
  bool validateWebsite = false;

  DateTime StartDate = DateTime.now();
  DateTime EndDate = DateTime.now();
  bool isStartDateSelect = false;
  bool isEndDateSelect = false;

  Future<void> _dateDialog(int dateIndex) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: StartDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != StartDate && picked != EndDate)
      setState(() {
        if (dateIndex == 1) {
          StartDate = picked;
          isStartDateSelect = true;
        } else {
          EndDate = picked;
          isEndDateSelect = true;
        }
      });
  }

  validate() {
    setState(() {
      nameController.text.isEmpty ? validateName = true : validateName = false;
      descriptionController.text.isEmpty
          ? validateDescription = true
          : validateDescription = false;
      problemStatementController.text.isEmpty
          ? validateProblemStatement = true
          : validateProblemStatement = false;
      winningPriceController.text.isEmpty
          ? validateWinningPrice = true
          : validateWinningPrice = false;
      // websiteController.text.isEmpty
      //     ? validateWebsite = true
      //     : validateWebsite = false;
      contactNoController.text.isEmpty
          ? validateContact = true
          : validateContact = false;
    });
    if (!isStartDateSelect) {
      toast().showToast('Please select Start Date');
      return false;
    }
    if (!isEndDateSelect) {
      toast().showToast('Please select End Date');
      return false;
    }
    if (contactNoController.text.length != 10) {
      toast().showToast('Please enter valid Contact no');
      return false;
    }
    if (!validateName &&
        !validateDescription &&
        !validateProblemStatement &&
        !validateWinningPrice &&
        !validateContact &&
        isStartDateSelect &&
        isEndDateSelect) {
      submitHackathon();
    }
  }

  _AddHackathonState() {
    hackathonPresenter = new AddHackathonPresenter(this);
  }

  submitHackathon() {
    setState(() {
      isApiCallProcess = true;
    });
    addHackathonRequestModel.orgId = Preference.getUserId();
    addHackathonRequestModel.hackathonName = nameController.text.trim();
    addHackathonRequestModel.description = descriptionController.text.trim();
    addHackathonRequestModel.endDate = EndDate;
    addHackathonRequestModel.startDate = StartDate;
    addHackathonRequestModel.noOfProblemStatement =
        problemStatementController.text.trim();
    addHackathonRequestModel.winningPrice = winningPriceController.text.trim();
    addHackathonRequestModel.website = websiteController.text.trim();
    addHackathonRequestModel.contactNo = contactNoController.text.trim();

    hackathonPresenter.addNewHackathon(
        addHackathonRequestModel, 'Hackathon/CreateHackathon');
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
    addHackathonRequestModel = new AddHackathonRequestModel();
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
          title: Text('Add Hackathon'),
        ),
        body: isInternetAvailable
            ? ListView(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text('Request to Host \na Hackathon',
                            style: TextStyle(
                              fontSize: 24.0,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                        child: Image.asset('assets/icons/hackathon.png',height: 30.0,
                          width: 30.0,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, bottom: 4.0),
                      child: Text(
                        'Host a hackathon on this platform. List problem statement and get all the submission at one place.',
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: nameController,
                      decoration: new InputDecoration(
                        hintText: 'Hackathon Name',
                        labelText: 'Hackathon Name',
                        errorText:
                            validateName ? 'Please enter Hackathon Name' : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: new InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Description',
                        labelText: 'Description',
                        errorText: validateDescription
                            ? 'Please enter Description'
                            : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: problemStatementController,
                      decoration: new InputDecoration(
                        hintText: 'Number of Problem Statement',
                        labelText: 'Problem Statement Count',
                        errorText: validateProblemStatement
                            ? 'Please enter No of Problem Statement'
                            : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: GestureDetector(
                      onTap: () {
                        _dateDialog(1);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(isStartDateSelect
                                  ? "${StartDate.toLocal()}".split(' ')[0]
                                  : 'Select Start Date'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: GestureDetector(
                      onTap: () {
                        _dateDialog(2);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(isEndDateSelect
                                  ? "${EndDate.toLocal()}".split(' ')[0]
                                  : 'Select End Date'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: winningPriceController,
                      decoration: new InputDecoration(
                        hintText: 'Winning Prize',
                        labelText: 'Winning Prize',
                        errorText: validateWinningPrice
                            ? 'Please enter Winning Price'
                            : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: websiteController,
                      decoration: new InputDecoration(
                        hintText: 'Website',
                        labelText: 'Website',
                        errorText:
                            validateWebsite ? 'Please enter website' : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 24.0, right: 24.0),
                    child: TextField(
                      controller: contactNoController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: 'Contact Number',
                        labelText: 'Contact Number',
                        errorText: validateContact
                            ? 'Please enter contact number'
                            : null,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 32.0),
                    child: GestureDetector(
                      onTap: () {
                        _checkInternet.check().then((value) {
                          if (value != null && value) {
                            validate();
                          } else {
                            setState(() {
                              isInternetAvailable = false;
                            });
                          }
                        });
                      },
                      child: Container(
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )
            : Container(
                child: Center(
                  child:
                      Lottie.asset('assets/lottie/nointernetconnection.json'),
                ),
              ));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(AddHackathonResponseModel successModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (successModel.status == 0) {
      toast().showToast(successModel.message);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => super.widget));
      // DialogHelper.Success(context, 'Hackathon', successModel.message);
    } else {
      DialogHelper.Success(context, 'Hackathon', successModel.message);
    }
  }
}
