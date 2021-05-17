import 'package:flutter/material.dart';
import 'package:teamup/contract/AllEducationContract.dart';
import 'package:teamup/module/AllEducationModel.dart';
import 'package:teamup/presenter/AllEducationPresenter.dart';
import 'package:teamup/screen/EditEducation.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

class AllEducation extends StatefulWidget {
  @override
  _AllEducationState createState() => _AllEducationState();
}

class _AllEducationState extends State<AllEducation>
    implements AllEducationContract {
  AllEducationPresenter allEducationPresenter;
  bool isApiCallProcess = false;
  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  String bodyMsg = "";

  List<PreEducation> allEducationList;

  _AllEducationState() {
    allEducationPresenter = new AllEducationPresenter(this);
  }

  getAllEducation() {
    setState(() {
      isApiCallProcess = true;
    });
    String userId = Preference.getUserId().toString();
    allEducationPresenter
        .getEducation('Education/GetAllEducation?StdId=$userId');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new checkInternet();
    allEducationList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getAllEducation();
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
        title: Text('All Education'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: isInternetAvailable
              ? Column(
                  children: [
                    allEducationList.isNotEmpty
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allEducationList.length,
                            itemBuilder: (context, index) {
                              return GetEducationDetails(
                                  allEducationList[index].id.toString(),
                                  allEducationList[index].courseName,
                                  allEducationList[index].intituteName,
                                  allEducationList[index].grade,
                                  allEducationList[index].startDate,
                                  allEducationList[index].endDate);
                            })
                        : Container(
                            child: Center(
                              child: Text(
                                isApiCallProcess
                                    ? 'Loading'
                                    : 'Education not available.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                          )
                  ],
                )
              : Container(
                  child: Center(
                    child: Text(bodyMsg),
                  ),
                ),
        ),
      ),
    );
  }

  Widget GetEducationDetails(String eId, String course, String collegeName,
      String grade, String startDate, String endDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 5.0,
          clipBehavior: Clip.antiAlias,
          shadowColor: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditEducation(eId)));
                          },
                          child: new Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(Icons.edit),
                            ),
                            label: Text('Edit'),
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Course: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      course,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'College: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      collegeName,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grade/Marks: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      grade,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Date: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      startDate,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'End Date: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      endDate,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void showEducationError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later..";
      isInternetAvailable = false;
    });
  }

  @override
  void showEducationSuccess(AllEducationModel allEducationModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (allEducationModel.status == 0) {
      allEducationList.addAll(allEducationModel.preEducation);
    } else {
      setState(() {
        bodyMsg = "Something went wrong, Please try again later..";
        isInternetAvailable = false;
      });
    }
  }
}
