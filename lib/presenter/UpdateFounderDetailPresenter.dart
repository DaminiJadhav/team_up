import 'package:teamup/contract/UpdateFounderDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdateFounderDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdateFounderDetailPresenter {
  UpdateFounderDetailsContract _view;
  Repos _repos;

  UpdateFounderDetailPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateDetails(UpdateFounderDetailsRequestModel, url) {
    _repos
        .updateFounderDetails(UpdateFounderDetailsRequestModel, url)
        .then((value) => _view.showFounderUpdateSuccess(value))
        .catchError((onError) => _view
            .showFounderUpdateError(new FetchException(onError.toString())));
  }
}
