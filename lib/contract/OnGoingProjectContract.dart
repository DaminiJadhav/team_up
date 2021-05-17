import 'package:teamup/module/OnGoingProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class OnGoingProjectContract{
  void showOnGoingProjectSuccess(OnGoingProjectModel success);
  void showOnGoingProjectError(FetchException exception);
}