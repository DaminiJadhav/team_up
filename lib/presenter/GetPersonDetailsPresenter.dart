import 'package:teamup/contract/GetPersonDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetPersonDetailsPresenter {
  GetPersonDetailsContract _view;
  Repos _repos;

  GetPersonDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void personDetails(url) {
    _repos
        .getPersonDetails(url)
        .then((value) => _view.showGetPersonDetailsSuccess(value))
        .catchError((onError) => _view
            .showGetPersonDetailsError(new FetchException(onError.toString())));
  }
}
