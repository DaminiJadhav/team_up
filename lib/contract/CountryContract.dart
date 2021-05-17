import 'package:teamup/module/CountryModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class CountryContract{
  void showCountrySuccess(CountryModel countryModel);
  void showCountryError(FetchException exception);
}