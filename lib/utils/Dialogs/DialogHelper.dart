import 'package:flutter/material.dart';

import 'ErrorDialogBox.dart';
import 'SuccessDialogBox.dart';

class DialogHelper{
  static Success(context,title,message) => showDialog(context : context,builder :(context)=>SuccessDialog(title,message));
  static Error(context,title,message) => showDialog(context : context,builder :(context)=>ErrorDialog(title,message));

}