import 'package:teamup/module/MyNetworkModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class MyNetworkContract {
  void showMyNetworkSuccess(MyNetworkModel myNetworkModel);

  void showMyNetworkError(FetchException exception);
}
