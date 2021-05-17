import 'package:flutter/material.dart';
import 'package:teamup/contract/AllAccomplishmentContract.dart';
import 'package:teamup/module/AllAccomplishmentModel.dart';
import 'package:teamup/presenter/AllAccomplishmentPresenter.dart';
import 'package:teamup/screen/EditAccomplishment.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

class AllAccomplishment extends StatefulWidget {
  @override
  _AllAccomplishmentState createState() => _AllAccomplishmentState();
}

class _AllAccomplishmentState extends State<AllAccomplishment>
    implements AllAccomplishmentContract {
  AllAccomplishmentPresenter accomplishmentPresenter;
  bool isApiCallProcess = false;
  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  String bodyMsg = "";

  List<Certificate> accomplishmentList;

  _AllAccomplishmentState() {
    accomplishmentPresenter = new AllAccomplishmentPresenter(this);
  }

  getAllAccomplishment() {
    setState(() {
      isApiCallProcess = true;
    });
    String userId = Preference.getUserId().toString();
    accomplishmentPresenter
        .allAccomplishment('Certification/GetAllCertificates?StdId=$userId');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    accomplishmentList = List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getAllAccomplishment();
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
        title: Text('All Accomplishment'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: isInternetAvailable
              ? Column(
                  children: [
                    accomplishmentList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: accomplishmentList.length,
                            itemBuilder: (context, index) {
                              return GetAccomplishmentDetails(
                                  accomplishmentList[index].id.toString(),
                                  accomplishmentList[index].name,
                                  accomplishmentList[index].issuedAuthorityName,
                                  accomplishmentList[index].issuedDate);
                            })
                        : Container(
                            child: Center(
                              child: Text(
                                isApiCallProcess
                                    ? 'Loading'
                                    : 'Accomplishment not available.',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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

  Widget GetAccomplishmentDetails(String cId, String certificateName,
      String issuingAuthority, String date) {
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
                                builder: (context) => EditAccomplishment(cId)));
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
                      'Certificate Name: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(certificateName,
                            style: TextStyle(fontSize: 18.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false))
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Issuing Authority: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      issuingAuthority,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Issuing Date: ',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      date,
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
  void showAllAccomplishmentError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showAllAccomplishmentSuccess(
      AllAccomplishmentModel accomplishmentModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (accomplishmentModel.status == 0) {
      accomplishmentList.addAll(accomplishmentModel.certificate);
    } else {
      setState(() {
        bodyMsg = "Something went wrong, Please try again later.";
        isInternetAvailable = false;
      });
    }
  }
}
