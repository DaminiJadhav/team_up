import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teamup/module/SliderModule.dart';
import 'package:teamup/screen/LoginScreen.dart';
import 'package:teamup/screen/SelectLoginScreen.dart';
import 'package:teamup/utils/SharedPreference.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<SlidersModel> sliderModels = new List<SlidersModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    sliderModels = getSlidersModel();
    Preference.init();
  }

  Widget PageIndexIndicater(bool isCurrentIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentIndex ? 10.0 : 6.0,
      width: isCurrentIndex ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentIndex
              ? Theme.of(context).primaryColor
              : Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blue,
        body: PageView.builder(
            controller: pageController,
            itemCount: sliderModels.length,
            onPageChanged: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return SliderTiles(
                imageName: sliderModels[index].imagePath,
                title: sliderModels[index].title,
                subTitle: sliderModels[index].subTitle,
              );
            }),
        bottomSheet: currentIndex != sliderModels.length - 1
            ? Container(
                height: Platform.isIOS ? 90.0 : 80.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pageController.animateToPage(sliderModels.length - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text('Skip'),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < sliderModels.length; i++)
                          currentIndex == i
                              ? PageIndexIndicater(true)
                              : PageIndexIndicater(false)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.animateToPage(currentIndex + 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              )
            : Container(
                height: Platform.isIOS ? 70 : 60,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: GestureDetector(
                  onTap: () {
                    Preference.setBoolen(true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SelectLogin()));
                    // print('Click..');
                  },
                  child: Text('Get Started',
                      style: Theme.of(context).textTheme.title),
                ),
              ),
      ),
    );
  }
}

class SliderTiles extends StatelessWidget {
  String imageName, title, subTitle;

  SliderTiles({this.imageName, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.asset(
              imageName,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Text(
            subTitle,
            style: TextStyle(color: Colors.blue[800], fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
