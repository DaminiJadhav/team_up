import 'package:teamup/contract/UpdateOurWorkContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdateOurWorkModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdateOurWorkPresenter {
  UpdateOurWorkContract _view;
  Repos _repos;

  UpdateOurWorkPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void ourWork(UpdateOurWorkRequestModel, url) {
    _repos
        .updateOurWork(UpdateOurWorkRequestModel, url)
        .then((value) => _view.showOurWorkSuccess(value))
        .catchError(
            (onError) => _view.showOurWorkError(new FetchException(onError)));
  }
}
