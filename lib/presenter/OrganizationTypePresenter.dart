

import 'package:teamup/contract/OrganizationTypeContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class OrganizationTypePresenter{

  OrganizationType _view;
  Repos _repos;
  OrganizationTypePresenter(this._view){
    _repos = new Injector().repos;
  }
  void organizationType(url){
    _repos
        .organizationType(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError){
      _view.showError(new FetchException(onError.toString()));
    });
  }
}