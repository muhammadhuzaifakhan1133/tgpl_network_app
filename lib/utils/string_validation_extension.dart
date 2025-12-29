extension StringValidation on String? {

  String? validate([String message = "This field is required"]) {
    if (this == null || this!.isEmpty) {
      return message;
    }
    return null;
  }

  String? validatePhoneNumber([String message = "Please enter a valid phone number"]) {
    String? error = validate();
    if (error != null) return error;
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(this!)) {
      return message;
    }
    return null;
  }

  String? validateNumber([String message = "Please enter a valid number"]) {
    String? error = validate();
    if (error != null) return error;
    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(this!)) {
      return message;
    }
    return null;
  }

  String? validateEmail([String message = "Please enter a valid email"]) {
    String? error = validate();
    if (error != null) return error;
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(this!)) {
      return message;
    }
    return null;
  }

  String? validateSameValue({
    required String value,
    required String message,
  }) {
    String? error = validate();
    if (error != null) return error;
    if (value != this) {
      return message;
    }
    return null;
  }
}