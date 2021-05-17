import 'package:teamup/contract/GetAccomplishmentDetailContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetAccomplishmentDetailPresenter {
  GetAccomplishmentDetailContract _view;
  Repos _repos;

  GetAccomplishmentDetailPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetailsAccomplishment(url) {
    _repos
        .getAccomplishementDetail(url)
        .then((value) => _view.showGetAccomplishmentDetailSuccess(value))
        .catchError((onError) => _view.showGetAccomplishmentDetailError(
            new FetchException(onError.toString())));
  }
}
