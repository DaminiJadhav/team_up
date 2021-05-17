import 'package:teamup/module/TypeOfProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class ProjectTypeContract{
  void showProjectTypeSuccess(TypeOfProjectModel typeOfProjectModel);
  void showProjectTypeError(FetchException exception);
}