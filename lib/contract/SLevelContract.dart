import 'package:teamup/module/SFieldTypeModel.dart';
import 'package:teamup/module/SProjectLevelModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class SLevelContract{
  void showSLevelSuccess(SProjectLevelModel sProjectLevelModel);
  void showSLevelError(FetchException exception);

}