import 'package:teamup/contract/CountryContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class CountryPresenter {
  CountryContract _view;
  Repos _repos;

  CountryPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getCountry(url) {
    _repos
        .getCountryList(url)
        .then((value) => _view.showCountrySuccess(value))
        .catchError((onError) =>
            _view.showCountryError(new FetchException(onError.toString())));
  }
}
