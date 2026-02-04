import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/user_model.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';

final userProvider = FutureProvider<UserModel?>((ref) {
  final masterDataLocalDataSource = ref.read(masterDataLocalDataSourceProvider);
  return masterDataLocalDataSource.getUserInfo();
});