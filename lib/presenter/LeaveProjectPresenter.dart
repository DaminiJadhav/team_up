import 'package:teamup/contract/LeaveProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/LeaveProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class LeaveProjectPresenter {
  LeaveProjectContract _view;
  Repos _repos;

  LeaveProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void projectLeave(LeaveProjectRequestModel, url) {
    _repos
        .leaveProject(LeaveProjectRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
