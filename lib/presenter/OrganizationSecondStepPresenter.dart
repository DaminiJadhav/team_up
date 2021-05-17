import 'package:teamup/contract/OrganizationSignUpSecondContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelSecond.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class organizationSecondStepPresenter {
  organizationSignUpSecondContract _view;
  Repos _repos;

  organizationSecondStepPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void secondStep(orgSignUpSecond, url) {
    _repos
        .orgSignUpSecondStep(orgSignUpSecond, url)
        .then((value) => _view.showSecondStepSuccess(value))
        .catchError((onError) {
      _view.showSecondStepError(new FetchException(onError.toString()));
    });
  }
}
