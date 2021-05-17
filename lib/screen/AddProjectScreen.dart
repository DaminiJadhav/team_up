import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamup/contract/PeopleTypeContract.dart';
import 'package:teamup/contract/ProjectTypeContract.dart';
import 'package:teamup/contract/SAddProjectContract.dart';
import 'package:teamup/contract/SFieldContract.dart';
import 'package:teamup/contract/SLevelContract.dart';
import 'package:teamup/module/SAddProjectModel.dart';
import 'package:teamup/module/SFieldTypeModel.dart';
import 'package:teamup/module/SProjectLevelModel.dart';
import 'package:teamup/module/TypeOfPeopleModel.dart';
import 'package:teamup/module/TypeOfProjectModel.dart';
import 'package:teamup/presenter/PeopleTypePresenter.dart';
import 'package:teamup/presenter/ProjectTypePresenter.dart';
import 'package:teamup/presenter/SAddProjectPresenter.dart';
import 'package:teamup/presenter/SFieldPresenter.dart';
import 'package:teamup/presenter/SLevelPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject>
    implements
        ProjectTypeContract,
        PeopleTypeContract,
        SLevelContract,
        SFieldContract,
        SAddProjectContract {
  // Check Internet
  checkInternet _checkInternet;
  SAddProjectRequestModel requestModel;

  //Presenters
  ProjectTypePresenter projectTypePresenter;
  PeopleTypePresenter peopleTypePresenter;
  SFieldPresenter sFieldPresenter;
  SLevelPresenter sLevelPresenter;
  SAddProjectPresenter sAddProjectPresenter;

  //For Screen Direction
  int pageCount = 0;
  bool pageIndex;

  // Controllers
  final projectNameController = TextEditingController();
  final projectHeadingController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final projectTeamMemberController = TextEditingController();
  final projectTagController = TextEditingController();

  // Validation Variables
  bool isApiCallProcess = false;
  bool validateProjectName = false;
  bool validateProjectHeading = false;
  bool validateProjectDescription = false;
  bool validateProjectTeamMember = false;
  bool validateProjectTag = false;
  bool isDateSelect = false;
  bool isProjectTypeSelect = false;
  bool isPeopleTypeSelect = false;
  bool isLevelSelect = false;
  bool isFieldSelect = false;
  bool isInternetAvailable = false;

  String finalDeadLineDate = "";
  DateTime deadlineDate = DateTime.now();

  var selectedProjectType;
  var selectedPeopleType;
  var selectedField;
  var selectedLevel;

  List<ProjectType> projectTypeList;
  List<PeopleType> peopleTypeList;
  List<LevelsType> levelTypeList;
  List<Field> fieldList;

  String bodyMessage = 'No Internet Connection,\n Please try again later.';

  _AddProjectState() {
    projectTypePresenter = new ProjectTypePresenter(this);
    peopleTypePresenter = new PeopleTypePresenter(this);
    sFieldPresenter = SFieldPresenter(this);
    sLevelPresenter = new SLevelPresenter(this);
    sAddProjectPresenter = new SAddProjectPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    pageIndex = false;
    Preference.init();
    projectTypeList = List();
    peopleTypeList = List();
    levelTypeList = List();
    fieldList = List();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        loadProjectType();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
    requestModel = new SAddProjectRequestModel();
  }

  Future<void> _dateDialog() async {
    final DateTime picked = await showDatePicker(
        context: context,
        helpText: 'Select Deadline Date',
        initialDate: deadlineDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != deadlineDate)
      setState(() {
        deadlineDate = picked;
        isDateSelect = true;
        String sYear = deadlineDate.year.toString();
        String sMonth = deadlineDate.month.toString();
        String sDate = deadlineDate.day.toString();
        finalDeadLineDate = sDate + "-" + sMonth + "-" + sYear;
      });
  }

  loadProjectType() {
    projectTypePresenter.getPTList('ProjectTypes/GetAllProjectsTypes');
  }

  loadLevel() {
    setState(() {
      isApiCallProcess = true;
    });
    sLevelPresenter.getLevel('ProjectLevels/GetAllProjectLevels');
  }

  loadField() {
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isApiCallProcess = true;
        });
        sFieldPresenter.getField('ProjectFields/GetAllProjectsFields');
      } else {
        setState(() {
          isInternetAvailable = false;
          bodyMessage = 'Please check your internet connection.';
        });
      }
    });
  }

  loadPeople() {
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isApiCallProcess = true;
        });
        peopleTypePresenter.getPeopleList('TypeOfPeoples/GetAllTypeOfPeoples');
      } else {
        setState(() {
          isInternetAvailable = false;
          bodyMessage = 'Please check your internet connection.';
        });
      }
    });
  }

  validateFirstScreenData() {
    setState(() {
      projectNameController.text.isEmpty
          ? validateProjectName = true
          : validateProjectName = false;
      projectHeadingController.text.isEmpty
          ? validateProjectHeading = true
          : validateProjectHeading = false;
    });
    if (!isProjectTypeSelect) {
      toast().showToast('Please select Project Type.');
      return false;
    }
    if (!isLevelSelect) {
      toast().showToast('Please select Project Level.');
      return false;
    }
    if (!isFieldSelect) {
      toast().showToast('Please select Project Field.');
      return false;
    }
    setState(() {
      pageCount = 1;
    });
  }

  validateSecondScreenData() {
    setState(() {
      projectDescriptionController.text.isEmpty
          ? validateProjectDescription = true
          : validateProjectDescription = false;
      projectTagController.text.isEmpty
          ? validateProjectTag = true
          : validateProjectTag = false;
    });
    if (projectDescriptionController.text.length < 20 ||
        projectDescriptionController.text.length > 1000) {
      toast().showToast(
          'Please enter Project Description Minimum 20 or Maximum 1000 Characters');
      return false;
    }
    if (!isDateSelect) {
      toast().showToast('Please select Deadline Date.');
      return;
    }
    setState(() {
      projectTeamMemberController.text.isEmpty
          ? validateProjectTeamMember = true
          : validateProjectTeamMember = false;
    });
    if (!isPeopleTypeSelect) {
      toast().showToast('Please select People Type.');
      return;
    }
    submitProject();
  }

  submitProject() {
    String userId = Preference.getUserId().toString();
    requestModel.StdId = userId;
    requestModel.Projectname = projectNameController.text.trim();
    requestModel.Projectheading = projectHeadingController.text.trim();
    requestModel.Type = selectedProjectType.toString();
    requestModel.Levels = selectedLevel.toString();
    requestModel.Field = selectedField.toString();
    requestModel.Description = projectDescriptionController.text.trim();
    requestModel.ProjectTags = projectTagController.text.trim();
    requestModel.TeamMembers = projectTeamMemberController.text.trim();
    requestModel.EndDate = deadlineDate.toString();
    requestModel.TypeOfpeople = selectedPeopleType.toString();
    setState(() {
      isApiCallProcess = true;
    });
    sAddProjectPresenter.sPostProject(
        requestModel, 'ProjectDetails/PostProjectDetail');
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
          title: Text('Add Project'),
        ),
        body: isInternetAvailable
            ? ListView(
                children: [
                  if (pageCount == 1)
                    Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 28.0, left: 16.0),
                              child: Text(
                                'Projects help you grow and learn. \n Fill in the details',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 26.0, left: 16.0, right: 16.0),
                          child: TextField(
                            controller: projectDescriptionController,
                            maxLines: 4,
                            decoration: new InputDecoration(
                              hintText: 'Project Description: 20-100 Words',
                              errorText: validateProjectDescription
                                  ? 'Please enter Project Description'
                                  : null,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
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
                              top: 16.0, left: 16.0, right: 16.0),
                          child: TextField(
                            controller: projectTagController,
                            decoration: new InputDecoration(
                              hintText: 'Project Tags: Eg Coding,robotics',
                              errorText: validateProjectTag
                                  ? 'Please enter Project Tag'
                                  : null,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
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
                              top: 16.0, left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: _dateDialog,
                            child: Container(
                              width: double.infinity,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(isDateSelect
                                        ? "${deadlineDate.toLocal()}"
                                            .split(' ')[0]
                                        : 'Select Deadline Date'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: TextField(
                            controller: projectTeamMemberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: new InputDecoration(
                              hintText: 'Approximate Team Members',
                              errorText: validateProjectTeamMember
                                  ? 'Please enter Team Size'
                                  : null,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
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
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Center(
                                child: DropdownButton(
                                  items: peopleTypeList.map((index) {
                                    return DropdownMenuItem(
                                      child: Text(index.roleName),
                                      value: index.id,
                                    );
                                  }).toList(),
                                  hint: Text('Select Type Of People'),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isPeopleTypeSelect = true;
                                      selectedPeopleType = newVal;
                                    });
                                  },
                                  value: selectedPeopleType,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Text(
                        //     'Done !',
                        //     style: TextStyle(fontSize: 28.0),
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 28.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageCount = 0;
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _checkInternet.check().then((value) {
                                    if (value != null && value) {
                                      validateSecondScreenData();
                                    } else {
                                      setState(() {
                                        isInternetAvailable = false;
                                        bodyMessage = 'No Internet Connection.';
                                      });
                                      toast().showToast(
                                          'Please check Internet connection');
                                    }
                                  });
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Finish',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  else if (pageCount == 0)
                    Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 28.0, left: 16.0),
                              child: Text(
                                'Lets TECH-IT-OUT.Fill in the technical \n details and start right away',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 26.0, left: 16.0, right: 16.0),
                          child: TextField(
                            controller: projectNameController,
                            decoration: new InputDecoration(
                              hintText: 'Project Name',
                              errorText: validateProjectName
                                  ? 'Please enter Project Name'
                                  : null,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
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
                              top: 16.0, left: 16.0, right: 16.0),
                          child: TextField(
                            controller: projectHeadingController,
                            decoration: new InputDecoration(
                              hintText: 'Project Headline',
                              errorText: validateProjectHeading
                                  ? 'Please enter Project Heading'
                                  : null,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
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
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Center(
                                child: DropdownButton(
                                  items: projectTypeList.map((index) {
                                    return DropdownMenuItem(
                                      child: Text(index.typename),
                                      value: index.id,
                                    );
                                  }).toList(),
                                  hint: Text('Select Project Type'),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isProjectTypeSelect = true;
                                      selectedProjectType = newVal;
                                    });
                                  },
                                  value: selectedProjectType,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Center(
                                child: DropdownButton(
                                  items: levelTypeList.map((index) {
                                    return DropdownMenuItem(
                                      child: Text(index.lavelName),
                                      value: index.id,
                                    );
                                  }).toList(),
                                  hint: Text('Select Level'),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isLevelSelect = true;
                                      selectedLevel = newVal;
                                    });
                                  },
                                  value: selectedLevel,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Center(
                                child: DropdownButton(
                                  items: fieldList.map((index) {
                                    return DropdownMenuItem(
                                      child: Text(index.fieldName),
                                      value: index.id,
                                    );
                                  }).toList(),
                                  hint: Text('Select Field'),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  onChanged: (newVal) {
                                    setState(() {
                                      isFieldSelect = true;
                                      selectedField = newVal;
                                    });
                                  },
                                  value: selectedField,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  validateFirstScreenData();
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                ],
              )
            : Container(
                child: Center(
                  child: Text(bodyMessage),
                ),
              ));
  }

  @override
  void showProjectTypeError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isInternetAvailable = false;
      bodyMessage = 'Something went wrong,please try again later.';
    });
  }

  @override
  void showProjectTypeSuccess(TypeOfProjectModel typeOfProjectModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (typeOfProjectModel.status == 0) {
      projectTypeList.addAll(typeOfProjectModel.projectTypes);
      loadLevel();
    } else {
      setState(() {
        isInternetAvailable = false;
        bodyMessage = 'Something went wrong,please try again later.';
      });
    }
  }

  @override
  void showPeopleTypeError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isInternetAvailable = false;
      bodyMessage = 'Something went wrong,please try again later.';
    });
  }

  @override
  void showPeopleTypeSuccess(TypeOfPeopleModel typeOfPeopleModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (typeOfPeopleModel.status == 0) {
      peopleTypeList.addAll(typeOfPeopleModel.peopleTypes);
    } else {
      setState(() {
        isInternetAvailable = false;
        bodyMessage = 'Something went wrong,please try again later.';
      });
    }
  }

  @override
  void showSFieldError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isInternetAvailable = false;
      bodyMessage = 'Something went wrong,please try again later.';
    });
  }

  @override
  void showSFieldSuccess(SFieldTypeModel sFieldTypeModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (sFieldTypeModel.status == 0) {
      fieldList.addAll(sFieldTypeModel.fields);
      loadPeople();
    } else {
      setState(() {
        isInternetAvailable = false;
        bodyMessage = 'Something went wrong,please try again later.';
      });
    }
  }

  @override
  void showSLevelError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isInternetAvailable = false;
      bodyMessage = 'Something went wrong,please try again later.';
    });
  }

  @override
  void showSLevelSuccess(SProjectLevelModel sProjectLevelModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (sProjectLevelModel.status == 0) {
      levelTypeList.addAll(sProjectLevelModel.projectTypes);
      loadField();
    } else {
      setState(() {
        isInternetAvailable = false;
        bodyMessage = 'Something went wrong,please try again later.';
      });
    }
  }

  @override
  void showSAddProjectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogHelper.Error(
        context, 'Project', 'Something went wrong, Please try again later.');
    toast().showToast('Something went wrong,Please try again later.');
  }

  @override
  void showSAddProjectSuccess(SAddProjectResponseModel success) {
    setState(() {
      isApiCallProcess = false;
    });
    if (success.status == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
      DialogHelper.Success(context, 'Project', 'Project Added Successfully..');
    } else {
      DialogHelper.Error(
          context, 'Project', 'Something went wrong, while adding project.');
    }
  }
}

// DropdownButton
