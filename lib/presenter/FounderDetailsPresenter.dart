import 'package:teamup/contract/FounderDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class FounderDetailsPresenter {
  FounderDetailsContract _view;
  Repos _repos;

  FounderDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void founderDetails(url) {
    _repos
        .getFounderDetails(url)
        .then((value) => _view.showFounderSuccess(value))
        .catchError((onError) =>
            _view.showFounderError(new FetchException(onError.toString())));
  }
}
