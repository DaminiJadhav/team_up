import 'package:teamup/contract/StudentSignUpThirdContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class StdSignUpThirdStepPresenter {
  studentSignUpThirdContract _view;
  Repos _repos;

  StdSignUpThirdStepPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void stdThirdStep(SignUpRequestThird, url) {
    _repos
        .stdSignUpThirdStep(SignUpRequestThird, url)
        .then((value) => _view.showStudentSignUpThirdSuccess(value))
        .catchError((onError) => _view.showStudentSignUpThirdError(
            new FetchException(onError.toString())));
  }
}
