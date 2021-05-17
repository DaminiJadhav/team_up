import 'package:flutter/material.dart';
import 'package:teamup/contract/AllExperienceContract.dart';
import 'package:teamup/module/AllExperienceModel.dart';
import 'package:teamup/presenter/AllExperiencePresenter.dart';
import 'package:teamup/screen/EditExperience.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

class AllExperience extends StatefulWidget {
  @override
  _AllExperienceState createState() => _AllExperienceState();
}

class _AllExperienceState extends State<AllExperience>
    implements AllExperienceContract {
  AllExperiencePresenter allExperiencePresenter;
  bool isApiCallProcess = false;
  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  String bodyMsg = "";

  List<Experience> experienceList;

  _AllExperienceState() {
    allExperiencePresenter = new AllExperiencePresenter(this);
  }

  getAllExperience() {
    setState(() {
      isApiCallProcess = true;
    });
    String userId = Preference.getUserId().toString();
    allExperiencePresenter
        .getExperience('Experience/GetAllExperience?StdId=$userId');
  }

  @override
  void initState() {
    super.initState();
    Preference.init();
    _checkInternet = new checkInternet();
    experienceList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getAllExperience();
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
        title: Text('All Experience'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              experienceList.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: experienceList.length,
                      itemBuilder: (context, index) {
                        return GetExperinceDetails(
                            experienceList[index].id.toString(),
                            experienceList[index].companyName,
                            experienceList[index].yourRole,
                            experienceList[index].description,
                            experienceList[index].address,
                            experienceList[index].startDate,
                            experienceList[index].endDate,
                            experienceList[index].isCurrent);
                      })
                  : Container(
                      child: Center(
                        child: Text(
                          isApiCallProcess
                              ? 'Loading'
                              : 'Experience not available.',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget GetExperinceDetails(
      String eId,
      String companyName,
      String role,
      String desc,
      String address,
      String startDate,
      String endDate,
      bool isCurrently) {
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
                                builder: (context) => EditExperience(eId)));
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
                      'Company: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      companyName,
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
                      'Role: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      role,
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
                      'Address: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      address,
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
                      'Description: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      desc,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 4,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'End Date: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      isCurrently ? 'Currently working here' : endDate,
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
  void showAllExperienceError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later";
      isInternetAvailable = false;
    });
  }

  @override
  void showAllExperienceSuccess(AllExperienceModel allExperienceModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (allExperienceModel.status == 0) {
      experienceList.addAll(allExperienceModel.experience);
    } else {
      setState(() {
        bodyMsg = allExperienceModel.message;
        isInternetAvailable = false;
      });
    }
  }
}
