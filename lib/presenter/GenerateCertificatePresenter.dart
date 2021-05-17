import 'package:teamup/contract/GenerateCertificateContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/GenerateCertificateModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GenerateCertificatePresenter {
  GenerateCertificateContract _view;
  Repos _repos;

  GenerateCertificatePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void generateCertificate(GenerateCertificateRequestModel, url) {
    _repos
        .certificateGenerate(GenerateCertificateRequestModel, url)
        .then((value) => _view.showGenerateSuccess(value))
        .catchError((onError) =>
            _view.showGenerateError(new FetchException(onError.toString())));
  }
}
