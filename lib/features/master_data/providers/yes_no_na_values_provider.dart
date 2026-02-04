import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';

final yesNoNaValuesProvider = FutureProvider<List<String>>((ref) async {
  final masterDataLocalDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return await masterDataLocalDataSource.getYNNList();
  
});

final yesNoValuesProvider = FutureProvider<List<String>>((ref) async {
  final masterDataLocalDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return await masterDataLocalDataSource.getYNList();
});