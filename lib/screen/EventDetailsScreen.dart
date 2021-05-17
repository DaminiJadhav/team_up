import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamup/contract/EventDetailsContract.dart';
import 'package:teamup/module/EventDetailsModel.dart';
import 'package:teamup/presenter/EventDetailsPresenter.dart';
import 'package:teamup/utils/CheckInternet.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/utils/ProgressHUD.dart';
import 'package:teamup/utils/Toast.dart';

class EventsDetails extends StatefulWidget {
  int eventId;

  EventsDetails(this.eventId);

  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails>
    implements EventDetailsContract {

  String eventName;
  bool posterStatus;
  bool contentStatus;
  String address;
  String emailId;
  String mobileNumber;

  String content;
  String posterUrl;
  String publisherName;
  String eventDate;

  EventDetailsPresenter eventDetailsPresenter;

  checkInternet _checkInternet;
  bool isInternetAvailable = false;
  bool isApiCallProcess = false;
  bool isDataAvailableToLoad = false;
  String messageToShow = 'Loading Data...';

  _EventsDetailsState() {
    eventDetailsPresenter = new EventDetailsPresenter(this);
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
        getEventDetailsData();
      } else {
        setState(() {
          isInternetAvailable = false;
        });
      }
    });
  }

  getEventDetailsData() {
    int eventId = widget.eventId;
    eventDetailsPresenter
        .getEventDetail('Event/GetVerifiedEventDetails?Id=$eventId');
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
          title: Text('Event Details'),
        ),
        body: isInternetAvailable
            ? isApiCallProcess
                ? Container(
                    child: Center(
                      child: Text(messageToShow),
                    ),
                  )
                : isDataAvailableToLoad
                    ? SingleChildScrollView(
                      child: Container(
                        child: Column(
                            children: [
                              MainContantDesign(context),
                            ],
                          ),
                      ),
                    )
                    : Container(
                        child: Center(
                          child: Text(messageToShow),
                        ),
                      )
            : Container(
                child: Center(
                  child: Lottie.asset('assets/lottie/nointernetconnection.json')
                ),
              ));
  }

  @override
  void showDetailError(FetchException exception) {
    setState(() {
      isApiCallProcess = false;
      isDataAvailableToLoad = true;
      messageToShow = 'Something went wrong, Please try again later..';
    });
  }

  @override
  void showDetailSuccess(EventDetailsModel success) {
    EventDetailsModel detailsModel;
    setState(() {
      isApiCallProcess = false;
      detailsModel = success;
    });
    if (detailsModel.status == 0) {
      setState(() {
        eventName = detailsModel.event[0].eventName;
        publisherName = detailsModel.event[0].publisherName;
        address = detailsModel.event[0].address;
        emailId = detailsModel.event[0].email;
        mobileNumber = detailsModel.event[0].contactNo;
        posterStatus = detailsModel.event[0].posterStatus;
        contentStatus = detailsModel.event[0].contentStatus;
        posterUrl = detailsModel.event[0].poster;
        content = detailsModel.event[0].description;
        eventDate = detailsModel.event[0].date;
        isDataAvailableToLoad = true;
      });
    } else {
      setState(() {
        isDataAvailableToLoad = true;
        messageToShow = 'Something went wrong, Please try again later..';
      });
      toast().showToast(detailsModel.message);
    }
  }

  Widget MainContantDesign(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              eventName != null ?eventName : 'NA',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: posterStatus,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                posterUrl,
                height: 150.0,
              ),
            ),
          ),
          Visibility(
            visible: contentStatus,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, right: 16.0, left: 16.0, bottom: 4.0),
              child: Expanded(
                child: Text(
                  content,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Venue : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    address,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    eventDate,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:60.0,right:60.0),
            child: Divider(thickness: 4),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Publisher Name : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    publisherName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact No: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    mobileNumber,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 8.0, right: 8.0, bottom: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Id: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    emailId,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
