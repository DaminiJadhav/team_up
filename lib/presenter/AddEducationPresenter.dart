import 'package:teamup/contract/AddEducationContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddEducationModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddEducationPresenter {
  AddEducationContract _view;
  Repos _repos;

  AddEducationPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void educationAdd(AddEducationRequestModel, url) {
    _repos
        .addEducation(AddEducationRequestModel, url)
        .then((value) => _view.showAddEducationSuccess(value))
        .catchError((onError) => _view
            .showAddEducationError(new FetchException(onError.toString())));
  }
}
