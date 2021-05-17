import 'package:flutter/material.dart';
import 'package:teamup/contract/LegelsContract.dart';
import 'package:teamup/module/LegelsModel.dart';
import 'package:teamup/presenter/LegalsPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';

class Legalas extends StatefulWidget {
  @override
  _LegalasState createState() => _LegalasState();
}

class _LegalasState extends State<Legalas> implements LegelsContract {
  LegalsPresenter legalsPresenter;

  bool isApiCallProcess = false;
  bool isInternetAvailable = false;
  checkInternet _checkInternet;
  bool isDataAvailableToload = false;
  String bodyMessage = "";
  List<Legal> legalsList;

  _LegalasState() {
    legalsPresenter = new LegalsPresenter(this);
  }

  getLegals() {
    setState(() {
      isApiCallProcess = true;
    });
    legalsPresenter.legals('Legals/GetAllLegals');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    legalsList = List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getLegals();
      } else {
        setState(() {
          bodyMessage = "Internet not available...";
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
          title: Text('Legals'),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Legals',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: isInternetAvailable ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: legalsList.length,
                    itemBuilder: (context, index) {
                      return MainDesign(
                          legalsList[index].description, '');
                    }) : Center(child: Text(bodyMessage),),
              )
              // MainDesign('This is Design', ''),
            ],
          )
        ));
  }

  Widget MainDesign(String Desc, String Heading) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
              child: Text(
            Desc,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18.0),
          )),
        ),
      ],
    );
  }

  @override
  void showLegalsError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMessage = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showLegelsSucess(LegelsModel legelsModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (legelsModel.status == 0) {
      legalsList.addAll(legelsModel.legal);
      setState(() {
        isDataAvailableToload = true;
      });
    } else {
      setState(() {
        bodyMessage = "Something went wrong, Please try again later.";
        isInternetAvailable = false;
      });
    }
  }
}
