import 'package:teamup/contract/CityContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class CityPresenter {
  CityContract _view;
  Repos _repos;

  CityPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getCity(url) {
    _repos
        .getCityList(url)
        .then((value) => _view.showCitySuccess(value))
        .catchError((onError) =>
            _view.showCityError(new FetchException(onError.toString())));
  }
}
