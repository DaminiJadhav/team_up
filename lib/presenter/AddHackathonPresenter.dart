import 'package:teamup/contract/AddHackathonContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddHackathonModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddHackathonPresenter {
  AddHackathonContract _view;
  Repos _repos;

  AddHackathonPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void addNewHackathon(AddHackathonRequestModel, url) {
    _repos
        .newAddHackathon(AddHackathonRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
