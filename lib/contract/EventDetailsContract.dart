import 'package:teamup/module/EventDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class EventDetailsContract {
  void showDetailSuccess(EventDetailsModel success);

  void showDetailError(FetchException exception);
}
