import 'package:teamup/contract/AllMemberListContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllMemberListPresenter {
  AllMemberListContract _view;
  Repos _repos;

  AllMemberListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllMember(url) {
    _repos
        .getMemberList(url)
        .then((value) => _view.showAllMemberSuccess(value))
        .catchError((onError) =>
            _view.showAllMemberError(new FetchException(onError.toString())));
  }
}
