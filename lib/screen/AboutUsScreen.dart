import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool darkModeOn = false;
  String SubTitle= 'Welcome to Inew Technologies. \n Welcome to Possible.';
  String DescriptionText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  double subTitleFontSize = 18.0;
  double titleFontSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    var whichMode=mode.brightness;
    if(whichMode == Brightness.dark){
      setState(() {
        darkModeOn = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/aboutus.png',height: 130.0,width: 130.0,),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text('About Us',style: TextStyle(
                        fontSize: 26.0,
                        color: darkModeOn ? Colors.white : Colors.black,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                    child: Text(SubTitle,style: TextStyle(
                      fontSize: 20.0
                    ),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('About this App:',style: TextStyle(
                      fontSize: titleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Expanded(
                    child: Text(DescriptionText,style: TextStyle(
                      fontSize: subTitleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,

                    ),textAlign: TextAlign.justify,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Inew Technologies:',style: TextStyle(
                    fontSize: titleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Expanded(
                    child: Text(DescriptionText,style: TextStyle(
                      fontSize: subTitleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                    ),textAlign: TextAlign.justify,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Our Team:',style: TextStyle(
                    fontSize: titleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold

                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Expanded(
                    child: Text(DescriptionText,style: TextStyle(
                      fontSize: subTitleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,

                    ),textAlign: TextAlign.justify,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Contact Us:',style: TextStyle(
                    fontSize: titleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:16.0,right: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Expanded(
                    child: Text(DescriptionText,textAlign: TextAlign.justify,style: TextStyle(
                      fontSize: subTitleFontSize,
                      color: darkModeOn ? Colors.white : Colors.black,
                    ),),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
