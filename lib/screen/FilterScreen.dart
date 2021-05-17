import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}
class _FilterDialogState extends State<FilterDialog> {
  bool studentFilter = false;
  bool sameCollegeOrInstitute = false;
  bool sameCity = false;

  bool facultyFilter = false;

  bool organizationFilter = false;

  bool organizationSameCity = false;
  bool hackathon = false;
  bool govtOrganization = false;
  bool startUps = false;
  bool industry = false;
  bool incubators = false;
  bool ngos = false;
  bool collageSchoolUniversities = false;
  bool communities = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
          actions: [
            new FlatButton(
                onPressed: () {
                  //TODO: Handle save
                },
                child: new Text('SAVE',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white))),
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Student Filters:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSwitch(
                      value: studentFilter,
                      onChanged: (value) {
                        setState(() {
                          studentFilter = value;
                          organizationFilter = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: studentFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Same College/Institute',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: sameCollegeOrInstitute,
                        onChanged: (value) {
                          setState(() {
                            sameCollegeOrInstitute = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: studentFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Same City',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: sameCity,
                        onChanged: (value) {
                          setState(() {
                            sameCity = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.black,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Faculty Filters:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSwitch(
                      value: facultyFilter,
                      onChanged: (value) {
                        setState(() {
                          facultyFilter = value;
                          organizationFilter = false;
                          studentFilter = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: facultyFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Same College/Institute',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: sameCollegeOrInstitute,
                        onChanged: (value) {
                          setState(() {
                            sameCollegeOrInstitute = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: facultyFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Same City',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: sameCity,
                        onChanged: (value) {
                          setState(() {
                            sameCity = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.black,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Organization Filters:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSwitch(
                      value: organizationFilter,
                      onChanged: (value) {
                        setState(() {
                          studentFilter = false;
                          organizationFilter = value;
                          facultyFilter = false;
                        });
                      },
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Same City',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: organizationSameCity,
                        onChanged: (value) {
                          setState(() {
                            organizationSameCity = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hackathons & Competitions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: hackathon,
                        onChanged: (value) {
                          setState(() {
                            hackathon = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Govt Organizations',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: govtOrganization,
                        onChanged: (value) {
                          setState(() {
                            govtOrganization = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Startups',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: startUps,
                        onChanged: (value) {
                          setState(() {
                            startUps = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Industry',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: industry,
                        onChanged: (value) {
                          setState(() {
                            industry = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Incubators',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: incubators,
                        onChanged: (value) {
                          setState(() {
                            incubators = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "NGO's",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: ngos,
                        onChanged: (value) {
                          setState(() {
                            ngos = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Colleges/Schools/Universities',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CupertinoSwitch(
                        value: collageSchoolUniversities,
                        onChanged: (value) {
                          setState(() {
                            collageSchoolUniversities = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: organizationFilter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Communities',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSwitch(
                        value: communities,
                        onChanged: (value) {
                          setState(() {
                            communities = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
