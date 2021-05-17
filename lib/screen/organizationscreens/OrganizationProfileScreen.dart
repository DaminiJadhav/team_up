import 'package:flutter/material.dart';
import 'package:teamup/contract/OrganizationProfileContract.dart';
import 'package:teamup/module/OrganizationProfileModel.dart';
import 'package:teamup/presenter/OrganizationProfilePresenter.dart';
import 'package:teamup/screen/organizationscreens/ChangeProfileImage.dart';
import 'package:teamup/screen/organizationscreens/EditOrganizationInfo.dart';
import 'package:teamup/screen/organizationscreens/FounderListScreen.dart';
import 'package:teamup/screen/organizationscreens/AddFounderScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

import '../MyProjectsScreen.dart';
import 'OurWorkScreen.dart';

class OrganizationProfile extends StatefulWidget {
  @override
  _OrganizationProfileState createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile>
    implements OrganizationProfileContract {
  OrganizationProfilePresenter profilePresenter;

  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;

  int maxLines = 4;
  String showMore = "Show More";
  bool isShowMore = false;

  String errorMessage = "";

  List<UserProfile> organizationInfoList;
  List<Project> projectList;
  List<Founder> founderList;

  _OrganizationProfileState() {
    profilePresenter = new OrganizationProfilePresenter(this);
  }

  getOnBack(dynamic value) {
    setState(() {
      isDataAvailableToLoad = false;
    });

    getProfile();
  }

  getProfile() {
    organizationInfoList =  List();
    projectList =  List();
    founderList =  List();
    setState(() {
      isApiCallProcess = true;
    });
    String id = Preference.getUserId().toString();
    profilePresenter.OrganizationProfile(
        'Organizations/GetOrgProfileDetails?ID=$id');
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
        getProfile();
      } else {
        setState(() {
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
        title: Text('Profile'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: isInternetAvailable
              ? isDataAvailableToLoad
                  ? Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          GetUserDetails(
                              organizationInfoList[0].orgName,
                              organizationInfoList[0].email,
                              organizationInfoList[0].imagePath),
                          Divider(
                            color: Colors.black,
                          ),
                          GetCompanyDetails(),
                          Divider(
                            color: Colors.black,
                          ),
                          GetProblemStatment(),
                          Divider(
                            color: Colors.black,
                          ),
                          GetFounderDetails(),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50.0,
                          ),
                          Center(
                            child: Text(errorMessage),
                          ),
                        ],
                      ),
                    )
              : Container(
                  child: Center(
                    child: Text('Please check your internet connection.'),
                  ),
                ),
        ),
      ),
    );
  }

  Widget GetUserDetails(String Name, String Email, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => ChangeProfileImage(imageUrl)))
                    .then(getOnBack);
              },
              child: Container(
                child: Container(
                  width: double.infinity,
                  height: 140,
                  child: Container(
                    alignment: Alignment(0.0, 1.9),
                    child: CircleAvatar(
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : AssetImage('assets/art/profile.png'),
                      radius: 70.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              Name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              Email,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget GetCompanyDetails() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Organization Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ],
            ),
          ),
          Card(
            // elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Type : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(organizationInfoList[0].name != null
                              ? organizationInfoList[0].name
                              : 'NA')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Website : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(organizationInfoList[0].website != null
                              ? organizationInfoList[0].website
                              : 'NA')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: Text(
                            organizationInfoList[0].address != null
                                ? organizationInfoList[0].address
                                : 'NA',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'City : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(organizationInfoList[0].city != null
                              ? organizationInfoList[0].city
                              : 'NA')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'State : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(organizationInfoList[0].state != null
                              ? organizationInfoList[0].state
                              : 'NA')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Country : ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(organizationInfoList[0].country != null
                              ? organizationInfoList[0].country
                              : 'NA')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget GetProblemStatment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Problem Statement',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ],
          ),
          Card(
            // elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: projectList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        projectList[0].projectname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                        maxLines: 3,
                      ),
                      subtitle: Text(
                        projectList[0].description,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text(
                      'Problem Statements not available.',
                      style: TextStyle(fontSize: 16.0),
                    )),
                  ),
          ),
          Visibility(
            visible: projectList.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    child: Text('Show more',style: TextStyle(
                      color: Colors.white
                    ),),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyProjects()));
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Works',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => OurWorkScreen(
                                    organizationInfoList[0].ourWork)))
                            .then(getOnBack);
                      },
                      child: new Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.edit,size: 20.0,),
                        ),
                        label: Text('Edit'),
                      )),
                ),
              ),
            ],
          ),
          Card(
            // elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    organizationInfoList[0].ourWork != null
                        ? organizationInfoList[0].ourWork
                        : 'Our Work Details not available.',
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  )),
                ],
              ),
            ),
          ),
          Visibility(
            visible: organizationInfoList[0].ourWork != null
                ? organizationInfoList[0].ourWork.length > 300 ? true : false
                : false,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    child: Text(showMore,style: TextStyle(
                      color: Colors.white
                    ),),
                    onPressed: () {
                      setState(() {
                        isShowMore = !isShowMore;
                      });
                      if (isShowMore) {
                        setState(() {
                          showMore = "Show Less";
                          maxLines = 30;
                        });
                      } else {
                        setState(() {
                          showMore = "Show More";
                          maxLines = 4;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget GetFounderDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Founders',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AddFounderScreen()))
                            .then(getOnBack);
                      },
                      child: new Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.add,size: 20.0,),
                        ),
                        label: Text('Add'),
                      )),
                ),
              ),
            ],
          ),
          Card(
            elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: founderList.isNotEmpty
                  ? ListTile(
                      leading: Container(
                        child: CircleAvatar(
                          backgroundImage: founderList[0].imagePath != null ||
                                  founderList[0].imagePath != ""
                              ? NetworkImage(founderList[0].imagePath)
                              : AssetImage('assets/art/profile.png'),
                          radius: 30.0,
                        ),
                      ),
                      title: Text(founderList[0].name != null
                          ? founderList[0].name
                          : 'NA'),
                      subtitle: Text(founderList[0].email != null
                          ? founderList[0].email
                          : 'NA'),
                    )
                  : Container(
                      child: Center(
                        child: Text("Founder's not available."),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Row(
              children: [
                Spacer(
                  flex: 8,
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text('Show more',style: TextStyle(
                    color: Colors.white
                  ),),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FounderList()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showOrganizationError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      errorMessage = "Something went wrong, Please try again later";
      isDataAvailableToLoad = false;
    });
  }

  @override
  void showOrganizationSuccess(OrganizationProfileModel profileModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (profileModel.status == 0) {
      organizationInfoList.addAll(profileModel.userProfile);
      projectList.addAll(profileModel.project);
      founderList.addAll(profileModel.founders);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        errorMessage = profileModel.message;
        isDataAvailableToLoad = false;
      });
    }
  }
}
