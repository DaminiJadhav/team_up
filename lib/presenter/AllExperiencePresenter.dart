import 'package:teamup/contract/AllExperienceContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllExperiencePresenter {
  AllExperienceContract _view;
  Repos _repos;

  AllExperiencePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getExperience(url) {
    _repos
        .getAllExperience(url)
        .then((value) => _view.showAllExperienceSuccess(value))
        .catchError((onError) => _view
            .showAllExperienceError(new FetchException(onError.toString())));
  }
}
