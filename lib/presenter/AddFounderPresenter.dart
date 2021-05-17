import 'package:teamup/contract/AddFounderContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddFounderModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddFounderPresenter {
  AddFounderContract _view;
  Repos _repos;

  AddFounderPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void founderAdd(AddFounderRequestModel, url) {
    _repos
        .addFounder(AddFounderRequestModel, url)
        .then((value) => _view.showAddFounderSuccess(value))
        .catchError((onError) =>
            _view.showAddFounderError(new FetchException(onError.toString())));
  }
}
