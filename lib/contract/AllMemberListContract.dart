import 'package:teamup/module/AllEventListModel.dart';
import 'package:teamup/module/AllMemberListModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllMemberListContract {
  void showAllMemberSuccess(AllMemberListModel allMemberListModel);

  void showAllMemberError(FetchException exception);
}
