import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamup/Widgets/Events.dart';
import 'package:teamup/screen/EventDetailsScreen.dart';
import 'package:teamup/screen/FilterScreen.dart';
import 'package:teamup/screen/ProjectDetailsScreen.dart';

Widget search(BuildContext context) {
  return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // _expansionPanel();
                _showFilterAlert(context);
              },
              child: new Icon(Icons.filter_list),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: TextField(
            decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              // print('search is click..');
            },
            icon: Icon(Icons.search),
          ),
          hintText: "Search",
          // labelText: "Email",
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        )),
      ),
      Divider(
        color: Colors.black,
      ),
      MainContaintDesignProject(context),
      MainCardDesingEvents(context, 0),
    ],
  );
}

_showFilterAlert(BuildContext context) {
  Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new FilterDialog();
      },
      fullscreenDialog: true));
}

Widget MainContaintDesignProject(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProjectScreen("1", false)));
    },
    child: Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Team Up Project',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Level: ',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Beginner',
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Type: ',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Software',
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Deadline: ',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '10 Oct 20',
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Field: ',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Software',
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Description: ',style: TextStyle(
            //           fontSize: 18.0
            //       ),),
            //       Expanded(
            //         child: Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
            //           textAlign: TextAlign.justify,
            //           maxLines: 4,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //               fontSize: 18.0
            //           ),),
            //       ),
            //     ],
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: FlatButton(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18.0),
            //         side: BorderSide(color: Theme.of(context).primaryColor)),
            //     child: Text('Show more'),
            //     onPressed: () {},
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

Widget MainCardDesingEvents(BuildContext context, int id) {
  return Container(
    child: Card(
      elevation: 25.0,
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.lightBlueAccent,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.event,
              size: 20.0,
            ),
            title: Text(
              'Event Name',
              style: TextStyle(
                // color: Colors.black54,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Even Place is here location.'),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, right: 16.0, left: 16.0, bottom: 4.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(
                  //color: Colors.black.withOpacity(0.6)
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/splashscreen/icon.png',
              height: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue)),
                  child: Text('Show more'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventsDetails(id))),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
