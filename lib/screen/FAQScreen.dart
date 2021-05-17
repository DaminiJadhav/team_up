import 'package:flutter/material.dart';
import 'package:teamup/contract/FAQContract.dart';
import 'package:teamup/module/FAQModel.dart';
import 'package:teamup/presenter/FAQPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> implements FAQContract {
  checkInternet _checkInternet;
  FAQPresenter faqPresenter;

  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  String bodyMsg = "";

  List<Faq> faqList;

  _FAQState() {
    faqPresenter = new FAQPresenter(this);
  }

  getList() {
    setState(() {
      isApiCallProcess = true;
    });
    faqPresenter.getFAQ('FAQs/GetAllFAQ');
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
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    faqList = List();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
        });
        getList();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  @override
  Widget _MainUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ's"),
      ),
      body: isInternetAvailable
          ? Container(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        isDataAvailableToLoad
                            ? faqList.isNotEmpty
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: faqList.length,
                                    itemBuilder: (context, index) {
                                      return view(faqList[index].faq1,
                                          faqList[index].answers);
                                    })
                                : Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("FAQ's not available"),
                                    ),
                                  )
                            : Container(
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                      child: Text('Loading...')),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: Center(
                child: Text(bodyMsg),
              ),
            ),
    );
  }

  Widget view(String question, String answer) {
    return Container(
      child: ExpansionTile(
        title: Text(question,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              answer,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void showFAQError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      bodyMsg = "Something went wrong, Please try again later.";
      isInternetAvailable = false;
    });
  }

  @override
  void showFAQSuccess(FaqModel faqModel) {
    setState(() {
      isApiCallProcess = false;
    });
    if (faqModel.status == 0) {
      faqList.addAll(faqModel.faq);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        bodyMsg = faqModel.message;
        isInternetAvailable = false;
      });
    }
  }
}
