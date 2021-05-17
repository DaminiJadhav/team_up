import 'package:teamup/contract/CreateTeamContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/CreateTeamModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class CreateTeamPresenter {
  CreateTeamContract _view;
  Repos _repos;

  CreateTeamPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void createNewTeam(CreateTeamRequestModel, url) {
    _repos
        .createTeam(CreateTeamRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
