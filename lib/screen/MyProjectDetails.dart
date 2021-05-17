import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teamup/contract/ApproveProjectContract.dart';
import 'package:teamup/contract/GenerateCertificateContract.dart';
import 'package:teamup/contract/MyProjectDetailsContract.dart';
import 'package:teamup/contract/RejectProjectContract.dart';
import 'package:teamup/module/ApproveProjectModel.dart';
import 'package:teamup/module/GenerateCertificateModel.dart';
import 'package:teamup/module/MyProjectDetailsModel.dart';
import 'package:teamup/module/RejectProjectModel.dart';
import 'package:teamup/presenter/ApproveProjectPresenter.dart';
import 'package:teamup/presenter/GenerateCertificatePresenter.dart';
import 'package:teamup/presenter/MyProjectDetailsPresenter.dart';
import 'package:teamup/presenter/RejectProjectPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/Dialogs/DialogHelper.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProjectDetails extends StatefulWidget {
  String pId;

  MyProjectDetails(this.pId);

  @override
  _MyProjectDetailsState createState() => _MyProjectDetailsState();
}

class _MyProjectDetailsState extends State<MyProjectDetails>
    implements
        MyProjectDetailsContract,
        ApproveProjectContract,
        RejectProjectContract,
        GenerateCertificateContract {
  int descriptionLine = 4;
  String buttonText = "Show More";
  bool isShowMoreClick = false;

  checkInternet _checkInternet;
  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  bool isDataAvailable = false;

  MyProjectDetailsPresenter detailsPresenter;
  ApproveProjectPresenter approveProjectPresenter;
  RejectProjectPresenter rejectProjectPresenter;
  GenerateCertificatePresenter certificatePresenter;

  ApproveProjectRequestModel approveRequest;
  RejectProjectRequestModel rejectRequest;
  GenerateCertificateRequestModel certificateRequestModel;

  List<MyProjectDetailsList> projectDetailsList;
  List<ProjectTeamList> memberList;

  _MyProjectDetailsState() {
    detailsPresenter = new MyProjectDetailsPresenter(this);
    approveProjectPresenter = new ApproveProjectPresenter(this);
    rejectProjectPresenter = new RejectProjectPresenter(this);
    certificatePresenter = GenerateCertificatePresenter(this);
  }

  downloadInitialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  downloadCertificate(String url) async {
    Directory tempDir = await getTemporaryDirectory();
    String iosPath = tempDir.path;
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: Platform.isIOS
          ? iosPath
          : await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_DOWNLOADS),
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  launchURL(final String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  checkPermission(String pdfUrl) async {
    // String pdfUrl =
    //     "https://teamup.sdaemon.com/Certificates/TeamUp_02_Feb_202103_26_32.pdf";
    final status = await Permission.storage.status;
    if (status.isGranted) {
      Platform.isIOS ? launchURL(pdfUrl) : downloadCertificate(pdfUrl);
    } else {
      if (await Permission.storage.request().isGranted) {
        Platform.isIOS ? launchURL(pdfUrl) : downloadCertificate(pdfUrl);
      } else {
        toast().showToast(
            'We need Permission to Download Certificate. Please allow to download');
      }
    }
  }

  getOnBack(dynamic value) {
    setState(() {});
    getDetails();
  }

  generateCertificate() {
    certificateRequestModel = GenerateCertificateRequestModel();
    certificateRequestModel.userId = Preference.getUserId();
    certificateRequestModel.projectId = widget.pId;
    certificateRequestModel.isStd = Preference.getIsStudent() ? true : false;
    setState(() {
      isApiCallProcess = true;
    });
    certificatePresenter.generateCertificate(
        certificateRequestModel, 'PdfCertificate/GenerateCertificate');
  }

  getDetails() {
    projectDetailsList = new List();
    memberList = new List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        String pId = widget.pId;
        detailsPresenter
            .getDetails('Organizations/GetMyProjectDetails?ProjectId=$pId');
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  void validateRejec() {
    rejectRequest = new RejectProjectRequestModel();
    rejectRequest.userId = Preference.getUserId().toString();
    rejectRequest.isAdmin = false;
    rejectRequest.projectId = widget.pId;
    rejectRequest.rejectReason = "";
    setState(() {
      isApiCallProcess = true;
    });
    rejectProjectPresenter.projectReject(
        rejectRequest, 'ProjectDetails/RejectProject');
  }

  validateApprove() {
    approveRequest = new ApproveProjectRequestModel();
    approveRequest.isAdmin = false;
    approveRequest.projectId = widget.pId;
    approveRequest.userId = Preference.getUserId().toString();
    setState(() {
      isApiCallProcess = true;
    });
    approveProjectPresenter.projectApprove(
        approveRequest, 'ProjectDetails/ApproveProject');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    getDetails();
    downloadInitialize();
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
        title: Text('Project Details'),
      ),
      body: isInternetAvailable
          ? projectDetailsList.isNotEmpty
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        projectDetailsList[0].projectName,
                                        style: TextStyle(fontSize: 24.0),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 16.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'assets/icons/chat.png',
                                      height: 30.0,
                                      width: 30.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        ProjectAsMemberMainDesign(context),
                        SizedBox(
                          height: 10.0,
                        ),
                        Visibility(
                            visible: projectDetailsList[0].isApproved,
                            child: generateButton()),
                        Visibility(
                            visible: projectDetailsList[0].isApproved
                                ? false
                                : projectDetailsList[0].isReview
                                    ? projectDetailsList[0].isCreatedByOrg
                                        ? projectDetailsList[0].createdById ==
                                                Preference.getUserId()
                                            ? true
                                            : false
                                        : false
                                    : false,
                            child: approveReject()),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(isDataAvailable
                        ? 'Something went wrong, Please try again later'
                        : ''),
                  ),
                )
          : Container(
              child: Center(
                child: Lottie.asset('assets/lottie/nointernetconnection.json'),
              ),
            ),
    );
  }

  Widget ProjectAsMemberMainDesign(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          projectDetailsList[0].type,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Type',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Text(
                          "4",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Team Member',
                            style: TextStyle(fontSize: 10.0),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          projectDetailsList[0].level,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Level',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          projectDetailsList[0].field,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Field',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          projectDetailsList[0].level,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Start Date',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          projectDetailsList[0].deadline,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Deadline',
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: projectDetailsList[0].description.length > 200
                            ? true
                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(buttonText),
                              onPressed: () {
                                setState(() {
                                  isShowMoreClick = !isShowMoreClick;
                                });
                                if (isShowMoreClick) {
                                  setState(() {
                                    descriptionLine = 50;
                                    buttonText = "Show Less";
                                  });
                                } else {
                                  setState(() {
                                    descriptionLine = 4;
                                    buttonText = "Show More";
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              projectDetailsList[0].description,
              textAlign: TextAlign.justify,
              maxLines: descriptionLine,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Description: ',
          //         style: TextStyle(fontSize: 18.0),
          //       ),
          //       Expanded(
          //         child: Text(
          //           projectDetailsList[0].description,
          //           textAlign: TextAlign.justify,
          //           maxLines: descriptionLine,
          //           overflow: TextOverflow.ellipsis,
          //           style: TextStyle(fontSize: 18.0),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Visibility(
          //   visible:
          //       projectDetailsList[0].description.length > 200 ? true : false,
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: FlatButton(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(18.0),
          //             side: BorderSide(color: Theme.of(context).primaryColor)),
          //         child: Text(buttonText),
          //         onPressed: () {
          //           setState(() {
          //             isShowMoreClick = !isShowMoreClick;
          //           });
          //           if (isShowMoreClick) {
          //             setState(() {
          //               descriptionLine = 50;
          //               buttonText = "Show Less";
          //             });
          //           } else {
          //             setState(() {
          //               descriptionLine = 4;
          //               buttonText = "Show More";
          //             });
          //           }
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Group Details',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              memberList.isNotEmpty
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: memberList.length,
                      itemBuilder: (context, index) {
                        return UserDesign(
                          context,
                          memberList[index].id.toString(),
                          memberList[index].name,
                          memberList[index].email,
                          memberList[index].userName,
                          memberList[index].imagePath,
                        );
                      })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            'Team Not Available',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget UserDesign(BuildContext context, String id, String name, String email,
      String userName, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      // if (isStudent) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => MyNetworkUserStd(id)));
                      // } else {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => MyNetworkOrgUser(id)));
                      // }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Container(
                            child: Container(
                              alignment: Alignment(0.0, 1.9),
                              child: CircleAvatar(
                                backgroundImage: imagePath != null
                                    ? NetworkImage(imagePath)
                                    : AssetImage('assets/art/profile.png'),
                                radius: 30.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userName != null ? userName : 'NA'),
                              Text(name != null ? name : 'NA'),
                              Text(email != null ? email : 'NA'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget generateButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: GestureDetector(
        onTap: generateCertificate,
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              'Generate Certificate',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget approveReject() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _checkInternet.check().then((value) {
                if (value != null && value) {
                  validateRejec();
                } else {
                  toast().showToast('Please check your internet connection...');
                }
              });
            },
            child: Container(
              height: 40.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Reject',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _checkInternet.check().then((value) {
                if (value != null && value) {
                  validateApprove();
                } else {
                  toast().showToast('Please check your internet connection...');
                }
              });
            },
            child: Container(
              height: 40.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Approve',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    print(exception.toString());
    toast().showToast('Something went wrong, Please try again later');
  }

  @override
  void showSuccess(MyProjectDetailsModel detailsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (detailsModel.status == 0) {
      setState(() {
        isDataAvailable = true;
      });
      projectDetailsList.add(detailsModel.myProjectDetails);
      memberList.addAll(detailsModel.myProjectDetails.projectTeamLists);
    } else {
      toast().showToast(detailsModel.message);
    }
  }

  @override
  void showApproveError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    //toast().showToast('Something went wrong, Please try again later.');
    DialogHelper.Error(context, 'Approve Project',
        'Something went wrong, Please try again later.');
  }

  @override
  void showApproveSuccess(ApproveProjectResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      getDetails();
      DialogHelper.Success(context, 'Approve Project', responseModel.message);
    } else {
      DialogHelper.Error(context, 'Approve Project', responseModel.message);
    }
  }

  @override
  void showRejectError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    DialogHelper.Error(context, 'Reject Project',
        'Something went wrong, Please try again later.');
  }

  @override
  void showRejectSuccess(RejectProjectResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      getDetails();
      DialogHelper.Success(context, 'Reject Project', responseModel.message);
    } else {
      DialogHelper.Error(context, 'Reject Project', responseModel.message);
    }
  }

  @override
  void showGenerateError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
    });
    toast().showToast("Something went wrong, Please try again later");
  }

  @override
  void showGenerateSuccess(GenerateCertificateResponseModel responseModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (responseModel.status == 0) {
      checkPermission(responseModel.certificatePath);
    } else {
      toast().showToast(responseModel.message);
    }
  }
}
