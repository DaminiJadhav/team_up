
import 'package:teamup/contract/LoginContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/LoginRequestModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class LoginPresenter{
  LoginContract _view;
  Repos _repos;
  LoginPresenter(this._view){
    _repos = new Injector().repos;
  }

  void loginAPI(LoginRequestModel ,url){
    _repos
    .login(LoginRequestModel, url)
        .then((value) => _view.showLoginSuccess(value))
        .catchError((onError)=>_view.showLoginError(new FetchException(onError.toString())));
  }
}