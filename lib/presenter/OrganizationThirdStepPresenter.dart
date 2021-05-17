import 'package:teamup/contract/OrganizationSignUpThirdContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelThird.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class organizationThirdStepPresenter {
  organizationSignUpThirdContract _view;
  Repos _repos;

  organizationThirdStepPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void thirdStep(orgSignUpThird, url) {
    _repos
        .orgSignUpThirdStep(orgSignUpThird, url)
        .then((value) => _view.showThirdStepSuccess(value))
        .catchError((onError) {
      _view.showThirdStepError(new FetchException(onError.toString()));
    });
  }
}
