import 'package:teamup/contract/AddMemberContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddMemberModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddMemberPresenter {
  AddMemberContract _view;
  Repos _repos;

  AddMemberPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void addMemberToProject(AddMemberRequestModel, url) {
    _repos
        .addMember(AddMemberRequestModel, url)
        .then((value) => _view.showAddMemberSuccess(value))
        .catchError((onError) =>
            _view.showAddMemberError(new FetchException(onError.toString())));
  }
}
