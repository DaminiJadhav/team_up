import 'package:flutter/material.dart';

class SecondPerson extends StatefulWidget {
  @override
  _SecondPersonState createState() => _SecondPersonState();
}

class _SecondPersonState extends State<SecondPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Profile'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top:16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.supervised_user_circle),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              Text('User Name'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Username : ',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              Text('username'),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Email : ',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                              Text('abc@gmail.com'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'City,State : ',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child: Text(
                                      'Pune, India',
                                      maxLines: 2,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/icons/chat.png',height: 40.0,width: 40.0,),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            GetCompanyDetails(context),
            Divider(
              color: Colors.black,
            ),
            GetProblemStatment(context),
            Divider(
              color: Colors.black,
            ),
            GetFounderDetails(context),
          ],
        )
      ),
    );
  }
}

Widget GetCompanyDetails(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
              Text('Software')
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
                onPressed: () {

                },
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
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