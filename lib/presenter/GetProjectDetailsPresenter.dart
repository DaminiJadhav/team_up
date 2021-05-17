import 'package:teamup/contract/GetProjectDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetProjectDetailsPresenter {
  GetProjectDetailsContract _view;
  Repos _repos;

  GetProjectDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getProjectDtl(url) {
    _repos
        .getProjectDetails(url)
        .then((value) => _view.showProjectDetailsSuccess(value))
        .catchError((onError) => _view
            .showProjectDetailsError(new FetchException(onError.toString())));
  }
}
