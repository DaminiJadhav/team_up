import 'package:flutter/material.dart';
import 'package:teamup/contract/AllFoundersContract.dart';
import 'package:teamup/module/AllFoundersModel.dart';
import 'package:teamup/presenter/AllFoundersPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';

import 'EditFounderScreen.dart';

class FounderList extends StatefulWidget {
  @override
  _FounderListState createState() => _FounderListState();
}

class _FounderListState extends State<FounderList>
    implements AllFoundersContract {
  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  String errorMessage = "Something went wrong, Please try again later.";

  AllFoundersPresenter foundersPresenter;
  List<FoundersList> foundersList;

  _FounderListState() {
    foundersPresenter = new AllFoundersPresenter(this);
  }

  getFounders() {
    setState(() {
      isApiCallProcess = true;
    });
    String id = Preference.getUserId().toString();
    foundersPresenter.getFounders('FounderLists/GetFounderList?orgId=$id');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    foundersList = List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getFounders();
      } else {
        setState(() {
          errorMessage = "Please check your internet connection.";
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
          title: Text("Founder's"),
        ),
        body: Container(
          child: isInternetAvailable
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      foundersList.isEmpty
                          ? Center(
                              child: Text('Founders not available.'),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: foundersList.length,
                              itemBuilder: (context, index) {
                                return cardDesign(
                                    foundersList[index].id.toString(),
                                    foundersList[index].imagePath,
                                    foundersList[index].name,
                                    foundersList[index].email);
                              })
                    ],
                  ),
                )
              : Center(
                  child: Text(errorMessage),
                ),
        ));
  }

  Widget cardDesign(String id, String imageUrl, String name, String email) {
    return Card(
      elevation: 25.0,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).primaryColor,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditFounderScreen(id)));
        },
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            name[0],
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        title: Text(name),
        subtitle: Text(email),
      ),
    );
  }

  @override
  void showAllFoundersError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      errorMessage = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showAllFoundersSuccess(AllFoundersModel foundersModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (foundersModel.status == 0) {
      foundersList.addAll(foundersModel.founderList);
    } else {
      setState(() {
        errorMessage = foundersModel.message;
        isInternetAvailable = false;
      });
    }
  }
}
