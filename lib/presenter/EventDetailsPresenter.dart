import 'package:teamup/contract/EventDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class EventDetailsPresenter {
  EventDetailsContract _view;
  Repos _repos;

  EventDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getEventDetail(url) {
    _repos
        .getEventDetails(url)
        .then((value) => _view.showDetailSuccess(value))
        .catchError((onError) =>
            _view.showDetailError(new FetchException(onError.toString())));
  }
}
