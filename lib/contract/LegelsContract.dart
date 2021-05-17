import 'package:teamup/module/LegelsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class LegelsContract {
  void showLegelsSucess(LegelsModel legelsModel);

  void showLegalsError(FetchException exception);
}
