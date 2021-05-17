import 'package:teamup/module/SFieldTypeModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class SFieldContract{
  void showSFieldSuccess(SFieldTypeModel sFieldTypeModel);
  void showSFieldError(FetchException exception);
}