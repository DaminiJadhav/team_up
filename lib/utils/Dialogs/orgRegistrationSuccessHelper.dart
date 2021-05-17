
import 'package:teamup/utils/Dialogs/OrgRegistrationSuccessDailog.dart';
import 'package:flutter/material.dart';
import 'package:teamup/utils/Dialogs/StdRegistrationSuccessDailog.dart';

class orgRegSuccessDailogHelper{
  static Ok(context)=> showDialog(context : context,builder:(context) => orgRegistrationSuccess());
  static StdOk(context)=> showDialog(context : context,builder:(context) => stdRegistrationSuccessDailog());

}