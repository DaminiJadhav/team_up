import 'package:teamup/contract/CloseAccountContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/CloseAccountModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class CloseAccountPresenter {
  CloseAccountContract _view;
  Repos _repos;

  CloseAccountPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void closeAcc(CloseAccountRequestModel, url) {
    _repos
        .closeAccount(CloseAccountRequestModel, url)
        .then((value) => _view.showCloseAccountSuccess(value))
        .catchError((onError) => _view
            .showCloseAccountError(new FetchException(onError.toString())));
  }
}
