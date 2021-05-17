import 'package:teamup/contract/MyNetworkContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class MyNetworkPresenter {
  MyNetworkContract _view;
  Repos _repos;

  MyNetworkPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getMyNetwork(url) {
    _repos
        .getMyNetworkList(url)
        .then((value) => _view.showMyNetworkSuccess(value))
        .catchError((onError) =>
            _view.showMyNetworkError(new FetchException(onError.toString())));
  }
}
