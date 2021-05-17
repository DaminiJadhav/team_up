import 'package:teamup/module/GenerateCertificateModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GenerateCertificateContract{
  void showGenerateSuccess(GenerateCertificateResponseModel responseModel);
  void showGenerateError(FetchException exception);
}