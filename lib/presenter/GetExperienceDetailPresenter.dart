import 'package:teamup/contract/GetExperienceDetailContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetExperienceDetailPresenter {
  GetExperienceDetailContract _view;
  Repos _repos;

  GetExperienceDetailPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getExpDetails(url) {
    _repos
        .getExperienceDetail(url)
        .then((value) => _view.showGetExperienceDetailSuccess(value))
        .catchError((onError) => _view.showGetExperienceDetailError(
            new FetchException(onError.toString())));
  }
}
