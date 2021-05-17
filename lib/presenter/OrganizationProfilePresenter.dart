import 'package:teamup/contract/OrganizationProfileContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class OrganizationProfilePresenter {
  OrganizationProfileContract _view;
  Repos _repos;

  OrganizationProfilePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void OrganizationProfile(url) {
    _repos
        .getOrganizationProfile(url)
        .then((value) => _view.showOrganizationSuccess(value))
        .catchError((onError) => _view
            .showOrganizationError(new FetchException(onError.toString())));
  }
}
