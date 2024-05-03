import '../../services/api_models/paging/paging.dart';

extension PagingExt on Paging? {
  bool get canNextPage => this == null
      ? false
      : ((this!.nextPage > this!.currentPage) &&
          (this!.totalPages > this!.currentPage));
}
