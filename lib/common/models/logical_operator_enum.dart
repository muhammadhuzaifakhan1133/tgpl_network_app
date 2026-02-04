enum LogicalOperator { and, or }

extension LogicalOperatorEnumExtension on LogicalOperator {
  String get value {
    switch (this) {
      case LogicalOperator.and:
        return 'AND';
      case LogicalOperator.or:
        return 'OR';
    }
  }
}
