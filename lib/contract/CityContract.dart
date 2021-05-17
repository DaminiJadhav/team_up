import 'package:teamup/module/CityModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class CityContract {
  void showCitySuccess(CityModel cityModel);

  void showCityError(FetchException exception);
}
