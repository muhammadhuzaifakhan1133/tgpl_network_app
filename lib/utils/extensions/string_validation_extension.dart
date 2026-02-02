extension StringValidation on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String orDefault(String defaultValue) =>
      (this?.isNotEmpty ?? false) ? this! : defaultValue;

  String? validate([String message = "This field is required"]) {
    if (isNullOrEmpty) {
      return message;
    }
    return null;
  }

  String? validatePhoneNumber([
    String message = "Please enter a valid phone number",
  ]) {
    String? error = validate();
    if (error != null) return error;
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(this!)) {
      return message;
    }
    return null;
  }

  String? validateNumber([
    String message = "Please enter a valid number",
    bool allowDecimal = true,
  ]) {
    String? error = validate();
    if (error != null) return error;
    final numberRegex = allowDecimal
        ? RegExp(r'^\d+(\.\d+)?$')
        : RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(this!)) {
      return message;
    }
    return null;
  }

  String? validateSameValue({required String value, required String message}) {
    String? error = validate();
    if (error != null) return error;
    if (value != this) {
      return message;
    }
    return null;
  }
}
