import '/shared_customization/data/basic_types.dart';
import '../../services/api_models/api_page_response/api_page_response.dart';
import '../../services/api_models/paging/paging.dart';
import '/shared_customization/extensions/list_ext.dart';

extension ApiPageResponseExt<T> on ApiPageResponse<T>? {
  ///
  /// Check null or empty
  ///
  bool get isEmptyOrNull => this == null || this!.data.isEmptyOrNull;
  bool get isNotEmptyOrNull => this != null && this!.data.isNotEmptyOrNull;
  bool get isOnlyEmpty => this != null && this!.data.isOnlyEmpty;

  ///
  /// Get element
  ///
  T? firstOrElseNull(bool Function(T element) condition) {
    for (T element in this?.data ?? []) {
      if (condition(element)) return element;
    }
    return null;
  }

  T? lastOrElseNull(bool Function(T element) condition) {
    for (T element in (this?.data ?? []).reversed) {
      if (condition(element)) return element;
    }
    return null;
  }

  T? elementAtIndexOrElseNull(int index) {
    if (this.isEmptyOrNull || (index < 0 || this!.data!.length <= index)) {
      return null;
    }
    return this!.data![index];
  }

  ApiPageResponse<T> reverseWithCondition({bool reverse = true}) {
    return ApiPageResponse<T>(
      data: reverse ? (this?.data ?? []).reversed.toList() : (this?.data ?? []),
      error: this?.error,
      message: this?.message,
      paging: this?.paging,
      status: this?.status,
    );
  }

  ///
  /// Insert one or list
  ///
  ApiPageResponse<T> insertPage(ApiPageResponse<T> newList,
      {IdentifyCallBack<T>? identify, bool isReverse = false}) {
    if (newList.paging?.currentPage == 1) return newList;
    return ApiPageResponse<T>(
      status: this?.status,
      error: this?.error,
      message: this?.message,
      data: <T>[
        if (identify != null)
          ...<String, T>{
            for (T element in isReverse
                ? [...(newList.data ?? []), ...(this?.data ?? [])]
                : [...(this?.data ?? []), ...(newList.data ?? [])])
              identify(element): element
          }.values.toList()
        else
          ...isReverse
              ? [...(newList.data ?? []), ...(this?.data ?? [])]
              : [...(this?.data ?? []), ...(newList.data ?? [])]
      ],
      paging: newList.paging,
    );
  }

  ApiPageResponse<T> insertFirst(T data,
          {bool Function(T element)? removeIfDuplicate}) =>
      ApiPageResponse<T>(
        status: this?.status,
        error: this?.error,
        message: this?.message,
        data: <T>[
          data,
          ...(this?.data ?? [])
              .where((element) => !(removeIfDuplicate?.call(element) ?? false))
              .toList()
        ],
        paging: (this?.paging ??
                const Paging(currentPage: 1, totalCount: 0, totalPages: 1))
            .copyWith(totalCount: (this?.paging?.totalCount ?? 0) + 1),
      );

  ApiPageResponse<T> insertLast(T data,
          {bool Function(T element)? removeIfDuplicate}) =>
      ApiPageResponse<T>(
        status: this?.status,
        error: this?.error,
        message: this?.message,
        data: <T>[
          ...(this?.data ?? [])
              .where((element) => !(removeIfDuplicate?.call(element) ?? false))
              .toList(),
          data
        ],
        paging: (this?.paging ??
                const Paging(currentPage: 1, totalCount: 0, totalPages: 1))
            .copyWith(totalCount: (this?.paging?.totalCount ?? 0) + 1),
      );

  ///
  /// Delete a element
  ///
  ApiPageResponse<T> delete(bool Function(T element) condition) =>
      ApiPageResponse<T>(
          status: this?.status,
          message: this?.message,
          paging: this?.paging,
          error: this?.error,
          data: <T>[...(this?.data ?? [])]
              .where((element) => !condition(element))
              .toList());

  ///
  /// Update a element
  ///
  ApiPageResponse<T> update(
          T Function(T element) onUpdate, bool Function(T element) condition) =>
      ApiPageResponse<T>(
          status: this?.status,
          message: this?.message,
          paging: this?.paging,
          error: this?.error,
          data: <T>[...(this?.data ?? [])]
              .map(
                  (element) => condition(element) ? onUpdate(element) : element)
              .toList());
}
