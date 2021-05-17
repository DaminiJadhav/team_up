import 'package:teamup/contract/OrganizationSignUpFirstContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelFirst.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class organizationFirstStepPresenter {
  organizationSignUpFirstContract _view;
  Repos _repos;

  organizationFirstStepPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void firstStep(orgSignUpFirst, url) {
    _repos
        .orgSignUpFirstStep(orgSignUpFirst, url)
        .then((value) => _view.showFirstStepSuccess(value))
        .catchError((onError) {
      _view.showFirstStepError(new FetchException(onError.toString()));
    });
  }
}
