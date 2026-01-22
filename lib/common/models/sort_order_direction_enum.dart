enum SortOrderDirection {
  ascending,
  descending,
}

extension SortOrderDirectionExtension on SortOrderDirection {
  String get key {
    switch (this) {
      case SortOrderDirection.ascending:
        return 'ASC';
      case SortOrderDirection.descending:
        return 'DESC';
    }
  }
}