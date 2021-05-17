import 'package:teamup/contract/PersonAboutMeContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/PersonAboutMeModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class PersonAboutMePresenter {
  PersonAboutMeContract _view;
  Repos _repos;

  PersonAboutMePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateAbout(PersonAboutMeRequestModel, url) {
    _repos
        .updateAboutMe(PersonAboutMeRequestModel, url)
        .then((value) => _view.showAboutMeUpdateSuccess(value))
        .catchError((onError) => _view
            .showAboutMeUpdateError(new FetchException(onError.toString())));
  }
}
