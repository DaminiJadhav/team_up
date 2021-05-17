import 'package:teamup/module/FAQModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class FAQContract {
  void showFAQSuccess(FaqModel faqModel);

  void showFAQError(FetchException exception);
}
