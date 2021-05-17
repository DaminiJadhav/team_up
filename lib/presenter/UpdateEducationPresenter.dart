import 'package:teamup/contract/UpdateEducationContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdateEducationModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdateEducationPresenter {
  UpdateEducationContract _view;
  Repos _repos;

  UpdateEducationPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void educationUpdate(UpdateEducationModel, url) {
    _repos
        .updateEducation(UpdateEducationModel, url)
        .then((value) => _view.showUpdateEducationSuccess(value))
        .catchError((onError) => _view
            .showUdpateEducationError(new FetchException(onError.toString())));
  }
}
