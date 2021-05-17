import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/AllEventListContract.dart';
import 'package:teamup/module/AllEventListModel.dart';
import 'package:teamup/presenter/AllEventListPresenter.dart';
import 'package:teamup/screen/EventDetailsScreen.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/SharedPreference.dart';
import 'package:teamup/utils/Toast.dart';

class events extends StatefulWidget {
  @override
  _eventsState createState() => _eventsState();
}

class _eventsState extends State<events> implements AllEventListContract {
  AllEventListPresenter allEventListPresenter;
  EventNdAdsModel allEventListModel;
  List<EventAddDetail> allEventList;

  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  String messageToShow = '';

  final searchController = TextEditingController();
  bool isSearchClick = false;

  _eventsState() {
    allEventListPresenter = new AllEventListPresenter(this);
  }

  _getAllEvents() {
    allEventList = List();
    allEventListPresenter
        .getAllEventList('Advertisements/GetApprovedEventAddList');
  }

  @override
  void initState() {
    super.initState();
    _checkInternet = new checkInternet();
    _checkInternet.check().then((value) {
      if (value != null && value) {
        setState(() {
          isInternetAvailable = true;
          isApiCallProcess = true;
        });
        _getAllEvents();
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
        body: isInternetAvailable
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text(messageToShow),
                    ),
                  )
                : isDataAvailableToLoad
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Events',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 16.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'assets/icons/events.png',
                                      height: 30.0,
                                      width: 30.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: AnimSearchBar(
                              rtl: false,
                              width: MediaQuery.of(context).size.width,
                              textController: searchController,
                              helpText: "Search Events",
                              suffixIcon:
                                  isSearchClick ? Icons.clear : Icons.search,
                              onSuffixTap: () {
                                setState(() {
                                  isSearchClick = !isSearchClick;
                                  searchController.clear();
                                });
                              },
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:4.0),
                            child: Center(
                              child: Text(
                                'Upcoming Events',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              allEventList.isEmpty
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: Text(
                                            "Currently Event's not available..",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: allEventListModel
                                          .eventAddDetails.length,
                                      itemBuilder: (context, index) {
                                        return allEventList[index].isEvent ==
                                                true
                                            ? EventCardDesing(
                                                allEventListModel
                                                    .eventAddDetails[index].id,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .name,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .publisherName,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .description,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .contentStatus,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .poster,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .posterStatus)
                                            : AdsCardDesing(
                                                allEventListModel
                                                    .eventAddDetails[index].id,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .name,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .publisherName,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .description,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .contentStatus,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .poster,
                                                allEventListModel
                                                    .eventAddDetails[index]
                                                    .posterStatus,
                                                allEventList[index].mobileNo,
                                                allEventList[index].email);
                                      })
                            ],
                          )
                        ],
                      )
                    : Container(
                        child: Center(
                          child: Text(messageToShow),
                        ),
                      )
            : Container(
                child: Center(
                  child:
                      Lottie.asset('assets/lottie/nointernetconnection.json'),
                ),
              ));
  }

  @override
  void showError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isDataAvailableToLoad = false;
      messageToShow = 'Something went wrong, please try again later..';
    });
    toast().showToast('Something went wrong, please try again later..');
  }

  @override
  void showSuccess(EventNdAdsModel success) {
    setState(() {
      isApiCallProcess = false;
      allEventListModel = success;
    });
    if (allEventListModel.status == 0) {
      allEventList.addAll(success.eventAddDetails);
      setState(() {
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        isDataAvailableToLoad = false;
        messageToShow = 'Something went wrong, please try again later..';
      });
      toast().showToast(allEventListModel.message);
    }
  }

  Widget EventCardDesing(int id, String eventName, String publisherName,
      String content, bool contentStatus, String poster, bool posterStatus) {
    return GestureDetector(
      onTap: () {
        eventsDetailsScreen(context, id);
      },
      child: Container(
        child: Card(
          // elevation: 10.0,
          clipBehavior: Clip.antiAlias,
          // shadowColor: Theme.of(context).primaryColor,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.event,
                  size: 20.0,
                ),
                title: Text(
                  eventName,
                  style: TextStyle(
                    //color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  publisherName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: contentStatus,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, right: 16.0, left: 16.0, bottom: 4.0),
                  child: Text(
                    content,
                    style: TextStyle(
                        //color: Colors.black.withOpacity(0.6)
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Visibility(
                visible: posterStatus,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    height: 150.0,
                    imageUrl: poster,
                    placeholder: (context, url) => Lottie.asset(
                        'assets/lottie/loading2.json',
                        width: 80,
                        height: 80),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // Image.network(
                  //   poster,
                  //   height: 150.0,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget AdsCardDesing(
      int id,
      String eventName,
      String publisherName,
      String content,
      bool contentStatus,
      String poster,
      bool posterStatus,
      String mobile,
      String email) {
    return Container(
      child: Card(
        elevation: 10.0,
         clipBehavior: Clip.antiAlias,
        // shadowColor: Theme.of(context).primaryColor,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.ac_unit,
                size: 20.0,
              ),
              title: Text(
                eventName,
                style: TextStyle(
                  //color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                publisherName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Visibility(
              visible: contentStatus,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, right: 16.0, left: 16.0, bottom: 4.0),
                child: Text(
                  content,
                  style: TextStyle(
                      //color: Colors.black.withOpacity(0.6)
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Visibility(
              visible: posterStatus,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  height: 150.0,
                  imageUrl: poster,
                  placeholder: (context, url) => Lottie.asset(
                      'assets/lottie/loading2.json',
                      width: 80,
                      height: 80),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.network(
                //   poster,
                //   height: 150.0,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Mobile No : '), Flexible(child: Text(mobile))],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Email : '), Flexible(child: Text(email))],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void eventsDetailsScreen(BuildContext context, int id) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EventsDetails(id),
    ));
  }
}
