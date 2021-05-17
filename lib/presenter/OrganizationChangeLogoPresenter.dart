import 'package:teamup/contract/OrganizationChangeLogoContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/OrganizationChangeLogoModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class OrganizationChangeLogoPresenter {
  OrganizationChangeLogoContract _view;
  Repos _repos;

  OrganizationChangeLogoPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void changeOrgLogo(OrganizationChangeLogoRequestModel, url) {
    _repos
        .orgChangeLogo(OrganizationChangeLogoRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
