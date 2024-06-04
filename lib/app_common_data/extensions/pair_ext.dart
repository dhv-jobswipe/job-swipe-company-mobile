import 'package:pbl5/models/pair/pair.dart';

extension PairExt on Pair? {
  bool get isFullyMatched =>
      this?.userMatched == true && this?.companyMatched == true;
}
