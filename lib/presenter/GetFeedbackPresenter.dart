import 'package:teamup/contract/GetFeedbackContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/GetFeedbackModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetFeedbackPresenter {
  GetFeedbackContract _view;
  Repos _repos;

  GetFeedbackPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void GetFeedback(GetFeedbackRequestModel,url) {
    _repos
        .getFeedback(GetFeedbackRequestModel,url)
        .then((value) => _view.showGetFeedbackSuccess(value))
        .catchError((onError) =>
            _view.showGetFeedbackError(new FetchException(onError.toString())));
  }
}
