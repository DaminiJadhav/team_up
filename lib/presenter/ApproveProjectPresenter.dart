import 'package:teamup/contract/ApproveProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/ApproveProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class ApproveProjectPresenter {
  ApproveProjectContract _view;
  Repos _repos;

  ApproveProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void projectApprove(ApproveProjectRequestModel, url) {
    _repos
        .approveProject(ApproveProjectRequestModel, url)
        .then((value) => _view.showApproveSuccess(value))
        .catchError((onError) =>
            _view.showApproveError(new FetchException(onError.toString())));
  }
}
