enum YesNo {
  yes,
  no,
}

extension YesNoX on YesNo {
  String get label {
    switch (this) {
      case YesNo.yes:
        return 'Yes';
      case YesNo.no:
        return 'No';
    }
  }
}