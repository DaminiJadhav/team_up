import 'package:teamup/module/AddMemberModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddMemberContract {
  void showAddMemberSuccess(AddMemberResponseModel responseModel);

  void showAddMemberError(FetchException exception);
}
