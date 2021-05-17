import 'package:teamup/contract/RejectProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/RejectProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class RejectProjectPresenter {
  RejectProjectContract _view;
  Repos _repos;

  RejectProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void projectReject(RejectProjectRequestModel, url) {
    _repos
        .rejectProject(RejectProjectRequestModel, url)
        .then((value) => _view.showRejectSuccess(value))
        .catchError((onError) =>
            _view.showRejectError(new FetchException(onError.toString())));
  }
}
