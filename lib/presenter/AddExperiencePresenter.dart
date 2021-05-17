import 'package:teamup/contract/AddExperienceContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddExperienceModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddExperiencePresenter {
  AddExperienceContract _view;
  Repos _repos;

  AddExperiencePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void experienceAdd(AddExperienceRequestModel, url) {
    _repos
        .addExperience(AddExperienceRequestModel, url)
        .then((value) => _view.showAddExperienceSuccess(value))
        .catchError((onError) => _view
            .showAddExperienceError(new FetchException(onError.toString())));
  }
}
