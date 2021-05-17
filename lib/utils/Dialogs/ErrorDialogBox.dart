import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorDialog extends StatelessWidget {
  String Title;
  String Message;

  ErrorDialog(this.Title, this.Message);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 280.0,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            // Icon(
            //   Icons.error,
            //   size: 80.0,
            //   color: Colors.red,
            // ),
            Lottie.asset('assets/lottie/error.json', height: 80.0, width: 80.0),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Title,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Message,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                          // Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Login()));
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
