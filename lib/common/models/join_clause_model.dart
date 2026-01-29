class JoinClause {
  final JoinType type;
  final String tableName;
  final String tableAlias;
  final String onCondition;

  const JoinClause({
    required this.type,
    required this.tableName,
    required this.tableAlias,
    required this.onCondition,
  });
}

/// Join types
enum JoinType {
  innerJoin('INNER JOIN'),
  leftJoin('LEFT JOIN'),
  rightJoin('RIGHT JOIN'),
  fullJoin('FULL OUTER JOIN');

  final String sql;
  const JoinType(this.sql);

  @override
  String toString() => sql;
}