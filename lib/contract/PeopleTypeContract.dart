import 'package:teamup/module/TypeOfPeopleModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class PeopleTypeContract{
  void showPeopleTypeSuccess(TypeOfPeopleModel typeOfPeopleModel);
  void showPeopleTypeError(FetchException exception);
}