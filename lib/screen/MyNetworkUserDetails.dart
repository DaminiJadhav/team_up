import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/PersonProfileDetailsContract.dart';
import 'package:teamup/module/PersonProfileDetailsModel.dart';
import 'package:teamup/presenter/PersonProfileDetailsPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';

class MyNetworkUserStd extends StatefulWidget {
  String userId;

  MyNetworkUserStd(this.userId);

  @override
  _MyNetworkUserStdState createState() => _MyNetworkUserStdState();
}

class _MyNetworkUserStdState extends State<MyNetworkUserStd>
    implements PersonProfileDetailsContract {
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  checkInternet _checkInternet;

  PersonProfileDetailsPresenter personProfileDetailsPresenter;

  _MyNetworkUserStdState() {
    personProfileDetailsPresenter = new PersonProfileDetailsPresenter(this);
  }

  //
  // String Name = "";
  // String city = "";
  // String email = "";
  // String userName = "";
  //
  // String _imageUrl = null;
  // String aboutMe = "";
  int maxLineForAboutMe = 6;
  String aboutShowMoreText = "Show More";
  bool isAboutShowMoreClick = false;

  List<UserProfile> profileList;
  List<Project> projectList;
  List<Education> educationList;
  List<Experience> experienceList;
  List<Certificate> accomplishmentList;

  getOnBack(dynamic val) {
    setState(() {});
    getDetails();
  }

  getDetails() {
    String uId = widget.userId;
    profileList = new List();
    projectList = new List();
    educationList = new List();
    experienceList = new List();
    accomplishmentList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        personProfileDetailsPresenter
            .personProfileDetails('Students/GetUserProfileDetails?ID=$uId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    getDetails();
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
        title: Text('User Details'),
        actions: [
          GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.chat),
              ))
        ],
      ),
      body: isInternetAvailable
          ? profileList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      GetUserDetails(
                          context,
                          profileList[0].name,
                          profileList[0].username,
                          profileList[0].city,
                          profileList[0].email),
                      Padding(
                        padding: EdgeInsets.only(left: 60.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      GetAboutMe(profileList[0].aboutMe),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      GetProjectDetails(context),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      GetEducationDetails(context),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      GetExperinceDetails(context),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      GetAccomplishmentDetails(context),
                    ],
                  ),
                ))
              : Container(
                  child: Center(
                    child: Text(isApiCallProcess
                        ? 'Loading'
                        : 'Something went wrong, Please try again later.'),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget GetUserDetails(BuildContext context, String Name, String Username,
      String City, String Email) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Container(
                width: double.infinity,
                height: 140,
                child: Container(
                  alignment: Alignment(0.0, 1.9),
                  child: CircleAvatar(
                    backgroundImage: profileList[0].imagePath != null
                        ? NetworkImage(profileList[0].imagePath)
                        : AssetImage('assets/art/profile.png'),
                    radius: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              Name !=null ? Name : 'NA',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              Email !=null ? Email : 'NA',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 2.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  City !=null ? City : 'NA',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }

  Widget GetAboutMe(String aboutMe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'About Me',
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              aboutMe != null ? aboutMe : 'About Me not available.',
              style: TextStyle(fontSize: 18.0),
              maxLines: maxLineForAboutMe,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        Visibility(
          visible: aboutMe != null ? aboutMe.length > 200 ? true : false: false,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text(
                  aboutShowMoreText,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (!isAboutShowMoreClick) {
                    setState(() {
                      maxLineForAboutMe = 20;
                      aboutShowMoreText = "Show Less";
                      isAboutShowMoreClick = true;
                    });
                  } else {
                    setState(() {
                      maxLineForAboutMe = 6;
                      aboutShowMoreText = "Show More";
                      isAboutShowMoreClick = false;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget GetProjectDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Project Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        Card(
          //elevation: 5.0,
          clipBehavior: Clip.antiAlias,
          //shadowColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: projectList.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Project Name: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                projectList[0].projectname,
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
                                'Description: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                projectList[0].description,
                                style: TextStyle(fontSize: 18.0),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ))
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Project not available.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget GetEducationDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Education',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16.0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: GestureDetector(
              //         onTap: () {
              //           // Navigator.of(context).push(MaterialPageRoute(
              //           //     builder: (context) => AddNewEducation()));
              //         },
              //         child: new Chip(
              //           avatar: CircleAvatar(
              //             backgroundColor: Theme.of(context).primaryColor,
              //             child: Icon(Icons.add),
              //           ),
              //           label: Text('Add'),
              //         )),
              //   ),
              // ),
            ],
          ),
          Card(
            //elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: Container(
              child: educationList.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Course: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                educationList[0].courseName,
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
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                educationList[0].intituteName,
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
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                educationList[0].Grade,
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
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                educationList[0].startDate,
                                style: TextStyle(fontSize: 18.0),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Date: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                educationList[0].endDate,
                                style: TextStyle(fontSize: 18.0),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ))
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Education not available.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
            ),
          ),
          // Visibility(
          //   visible: educationList.isNotEmpty,
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: FlatButton(
          //         color: Theme.of(context).primaryColor,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(18.0),
          //             side: BorderSide(color: Theme.of(context).primaryColor)),
          //         child: Text(
          //           'Show more',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).push(MaterialPageRoute(
          //               builder: (context) => AllEducation()));
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget GetExperinceDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: experienceList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experience',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0),
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: GestureDetector(
                    //         onTap: () {
                    //           // Navigator.of(context).push(MaterialPageRoute(
                    //           //     builder: (context) => AddNewExperience()));
                    //         },
                    //         child: new Chip(
                    //           avatar: CircleAvatar(
                    //             backgroundColor: Theme.of(context).primaryColor,
                    //             child: Icon(Icons.add),
                    //           ),
                    //           label: Text('Add'),
                    //         )),
                    //   ),
                    // ),
                  ],
                ),
                Card(
                  //elevation: 5.0,
                  clipBehavior: Clip.antiAlias,
                 // shadowColor: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Company: ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Text(
                              experienceList[0].companyName,
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
                              experienceList[0].yourRole,
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
                              experienceList[0].Address,
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
                              experienceList[0].Description,
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
                              experienceList[0].startDate,
                              style: TextStyle(fontSize: 18.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, bottom: 16.0),
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
                              experienceList[0].endDate,
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
                // Visibility(
                //   visible: experienceList.length <= 1,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 8.0),
                //     child: Align(
                //       alignment: Alignment.topRight,
                //       child: FlatButton(
                //         color: Theme.of(context).primaryColor,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(
                //                 color: Theme.of(context).primaryColor)),
                //         child: Text(
                //           'Show more',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         onPressed: () {
                //           // Navigator.of(context).push(MaterialPageRoute(
                //           //     builder: (context) => AllExperience()));
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experience',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0),
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: GestureDetector(
                    //         onTap: () {
                    //           // Navigator.of(context).push(MaterialPageRoute(
                    //           //     builder: (context) => AddNewExperience()));
                    //         },
                    //         child: new Chip(
                    //           avatar: CircleAvatar(
                    //             backgroundColor: Theme.of(context).primaryColor,
                    //             child: Icon(Icons.add),
                    //           ),
                    //           label: Text('Add'),
                    //         )),
                    //   ),
                    // ),
                  ],
                ),
                Card(
                  //elevation: 5.0,
                  clipBehavior: Clip.antiAlias,
                 // shadowColor: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Experience not available.',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: experienceList.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        child: Text(
                          'Show more',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => AllExperience()));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget GetAccomplishmentDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Accomplishment',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16.0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: GestureDetector(
              //         onTap: () {
              //           // Navigator.of(context).push(MaterialPageRoute(
              //           //     builder: (context) => AddNewAccomplishment()));
              //         },
              //         child: new Chip(
              //           avatar: CircleAvatar(
              //             backgroundColor: Theme.of(context).primaryColor,
              //             child: Icon(Icons.add),
              //           ),
              //           label: Text('Add'),
              //         )),
              //   ),
              // ),
            ],
          ),
          Card(
            //elevation: 5.0,
            clipBehavior: Clip.antiAlias,
            //shadowColor: Theme.of(context).primaryColor,
            child: Container(
              child: accomplishmentList.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Certificate Name: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(accomplishmentList[0].name,
                                      style: TextStyle(fontSize: 18.0),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Issuing Authority: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                accomplishmentList[0].issuedAuthorityName,
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
                              const EdgeInsets.only(left: 8.0, bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Issuing Date: ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                accomplishmentList[0].issuedDate,
                                style: TextStyle(fontSize: 18.0),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ))
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Accomplishment not available.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
            ),
          ),
          // Visibility(
          //   visible: accomplishmentList.isNotEmpty,
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: FlatButton(
          //       color: Theme.of(context).primaryColor,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0),
          //           side: BorderSide(color: Theme.of(context).primaryColor)),
          //       child: Text(
          //         'Show more',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => AllAccomplishment()));
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  void showPersonProfileDetailsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showPersonProfileDetailsSuccess(
      PersonProfileDetailsModel profileDetailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (profileDetailsModel.status == 0) {
      profileList.addAll(profileDetailsModel.userProfile);
      projectList.addAll(profileDetailsModel.project);
      educationList.addAll(profileDetailsModel.education);
      experienceList.addAll(profileDetailsModel.experience);
      accomplishmentList.addAll(profileDetailsModel.certificate);
    } else {
      toast().showToast(profileDetailsModel.message);
    }
  }
}
