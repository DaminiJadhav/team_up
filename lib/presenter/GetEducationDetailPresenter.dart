import 'package:teamup/contract/GetEducationDetailContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetEducationDetailPresenter {
  GetEducationDetailContract _view;
  Repos _repos;

  GetEducationDetailPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getedDetails(url) {
    _repos
        .getEducationDetail(url)
        .then((value) => _view.showGetEducationDetailSuccess(value))
        .catchError((onError) => _view.showGetEducationDetailError(
            new FetchException(onError.toString())));
  }
}
