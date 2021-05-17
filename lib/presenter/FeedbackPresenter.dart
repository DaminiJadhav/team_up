import 'package:teamup/contract/FeedbackContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/FeedbackModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class FeedbackPresenter {
  FeedbackContract _view;
  Repos _repos;

  FeedbackPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void postFeedback(FeedbackRequestModel, url) {
    _repos
        .submitFeedback(FeedbackRequestModel, url)
        .then((value) => _view.showPostSuccess(value))
        .catchError((onError) =>
            _view.showPostError(new FetchException(onError.toString())));
  }
}
