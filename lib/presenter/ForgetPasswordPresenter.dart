import 'package:teamup/contract/ForgetPasswordContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/ForgetPasswordModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class ForgetPasswordPresenter {
  ForgetPasswordContract _view;
  Repos _repos;

  ForgetPasswordPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void passwordForget(ForgetPasswordRequestModel, url) {
    _repos
        .forgetPassword(ForgetPasswordRequestModel, url)
        .then((value) => _view.showForgetPasswordSuccess(value))
        .catchError((onError) => _view
            .showForgetPasswordError(new FetchException(onError.toString())));
  }
}
