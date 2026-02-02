import 'package:flutter_riverpod/legacy.dart';

final autoValidateFormModeProvider = StateProvider.autoDispose<bool>((ref) => false);