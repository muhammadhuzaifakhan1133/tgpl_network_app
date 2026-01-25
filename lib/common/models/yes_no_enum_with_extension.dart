enum YesNo { yes, no }

extension YesNoX on YesNo {
  String get label {
    switch (this) {
      case YesNo.yes:
        return 'Yes';
      case YesNo.no:
        return 'No';
    }
  }

  int get value {
    switch (this) {
      case YesNo.yes:
        return 1;
      case YesNo.no:
        return 0;
    }
  }
}
