import 'package:teamup/module/StateModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class StateContract {
  void showStateSuccess(StateModel stateModel);

  void showStateError(FetchException exception);
}
