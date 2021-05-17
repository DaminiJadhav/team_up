import 'package:teamup/contract/SignUpContract.dart';
import 'package:teamup/contract/StudentSignUpFirstContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/SignUpResponseModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class SignUpFirstStepPresenter {
  studentSignUpFirstContract _view;
  Repos _repos;

  SignUpFirstStepPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void stdFirstStep(SignUpFirstRequestModel, url) {
    _repos
    .stdSignUpFirstStep(SignUpFirstRequestModel, url)
        .then((value) => _view.showStudentSignUpSuccess(value))
        .catchError((onError) => _view.showStudentSignUpError(new FetchException(onError.toString())));
  }
}
