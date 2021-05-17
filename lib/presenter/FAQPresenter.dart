import 'package:teamup/contract/FAQContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class FAQPresenter {
  FAQContract _view;
  Repos _repos;

  FAQPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getFAQ(url) {
    _repos
        .getFAQList(url)
        .then((value) => _view.showFAQSuccess(value))
        .catchError((onError) =>
            _view.showFAQError(new FetchException(onError.toString())));
  }
}
