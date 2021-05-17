

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void snackBar(BuildContext context,String message){
    Scaffold.of(context).showSnackBar(SnackBar(
     content: Text(message),
     action: SnackBarAction(
       label: 'Dismiss',
       onPressed: (){

       },
     ),
   ));
}
