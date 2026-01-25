extension NullableFieldHelper on List<String>? {
  /// Returns null if [fieldName] is in the list, otherwise returns [value] or [currentValue].
  T? apply<T>(String fieldName, T? value, T? currentValue) {
    if (this?.contains(fieldName) == true) return null;
    return value ?? currentValue;
  }
}