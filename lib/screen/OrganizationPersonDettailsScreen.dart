import 'package:flutter/material.dart';
class OrganizationPersonDetails extends StatefulWidget {
  @override
  _OrganizationPersonDetailsState createState() => _OrganizationPersonDetailsState();
}

class _OrganizationPersonDetailsState extends State<OrganizationPersonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization User'),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  GetUserImage(context),
                  GetUserDetails(),
                  Spacer(
                    flex: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        // print('Is Clicked..');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: new Icon(Icons.message),
                      )),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              GetCompanyDetails(),
              Divider(
                color: Colors.black,
              ),
              GetProblemStatment(context),
              Divider(
                color: Colors.black,
              ),
              GetFounderDetails(context),
            ],
          ),
        ),
      )
    );
  }
}
Widget GetUserImage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: CircleAvatar(
        radius: 50,
        child: Icon(Icons.supervised_user_circle),
      ),
    ),
  );
}

Widget GetUserDetails() {
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Text(
              'Name :',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(' Sdaemon Info'),
          ],
        ),
        Row(
          children: [
            Text(
              'Name :',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(' Sdaemon Info'),
          ],
        ),
        Row(
          children: [
            Text(
              'Name :',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(' Sdaemon Info'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Text(
                'Name :',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(' Sdaemon Info'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget GetCompanyDetails() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Spacer(
              flex: 10,
            ),
            GestureDetector(
                onTap: () {
                  // print('Is Clicked..');
                },
                child: new Icon(Icons.edit))
          ],
        ),
        Row(
          children: [
            Text(
              'Company Information :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(' Sdaemon Infotech'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                'Website : ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(' www.sdaemon.com')
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
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(
                    '505 Victory Land Mark, near D mart Baner,Pune,Maharashtra.',
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
                'Type : ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('Your Type')
            ],
          ),
        ),
      ],
    ),
  );
}

Widget GetProblemStatment(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Spacer(
              flex: 8,
            ),
            GestureDetector(onTap: () {}, child: new Icon(Icons.edit)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Problem \nStatement :  ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            Expanded(
                child: Text(
                  ' It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like',
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statement 1 :',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(
                    ' It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statement 2 :',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Spacer(
                flex: 8,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Show more'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Row(
          children: [
            Spacer(
              flex: 10,
            ),
            GestureDetector(onTap: () {}, child: new Icon(Icons.edit))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Work : ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Spacer(
                flex: 8,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Show more'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget GetFounderDetails(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Spacer(
              flex: 8,
            ),
            new Icon(Icons.edit)
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Founder List : ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            // Expanded(child: Text(' It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose injected humour and the like', maxLines: 10,
            //   overflow: TextOverflow.ellipsis,
            //   softWrap: false,)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name : ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Sdaemon Infotech',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email : ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'sdaemoninfo@sdaemon.com',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  )),
            ],
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                child: Text('Show more'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}