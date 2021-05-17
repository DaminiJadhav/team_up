import 'package:teamup/module/UpdateEducationModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdateEducationContract{
  void showUpdateEducationSuccess(UpdateEducationResponseModel educationResponseModel);
  void showUdpateEducationError(FetchException exception);
}