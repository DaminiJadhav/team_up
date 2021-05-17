import 'package:teamup/contract/SLevelContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class SLevelPresenter{
  SLevelContract _view;
  Repos _repos;

  SLevelPresenter(this._view){
    _repos = new Injector().repos;
  }
  void getLevel(url){
    _repos
    .getLevelList(url)
        .then((value) => _view.showSLevelSuccess(value))
        .catchError((onError)=> _view.showSLevelError(new FetchException(onError.toString())));
  }
}