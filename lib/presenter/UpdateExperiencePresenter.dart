import 'package:teamup/contract/UpdateExperienceContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdateExperienceModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdateExperiencePresenter {
  UpdateExperienceContract _view;
  Repos _repos;

  UpdateExperiencePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void experienceUpdate(UpdateExperienceModel,url) {
    _repos
        .updateExperience(UpdateExperienceModel, url)
        .then((value) => _view.showUpdateExperienceSuccess(value))
        .catchError((onError) => _view
            .showUpdateExperienceError(new FetchException(onError.toString())));
  }
}
