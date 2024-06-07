import 'package:pbl5/models/pair/pair.dart';

extension PairExt on Pair? {
  bool get isFullyMatched =>
      this?.userMatched == true && this?.companyMatched == true;

  bool get isShowAcceptBtn =>
      this?.userMatched == true && this?.companyMatched == null;

  bool get isShowMakePairAgainBtn =>
      this?.userMatched == true && this?.companyMatched == false;

  bool get isRequestToUser =>
      this?.userMatched == null && this?.companyMatched == true;

  bool get isCanceledByUser =>
      this?.userMatched == false && this?.companyMatched == true;
}
