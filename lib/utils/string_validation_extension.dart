extension StringValidation on String {

  bool isValidPhoneNumber() {
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(this);
  }
}