import 'package:teamup/webService/APICall/APIService.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class Injector{
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Repos get repos{
    return new APICall();
  }

}