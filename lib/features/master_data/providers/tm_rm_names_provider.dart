import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/tm_rm_model.dart';

final tmNamesProvider = FutureProvider<List<TmRmModel>>((ref) {
  return [
    TmRmModel(id: "1", name: "TM Name 1"),
    TmRmModel(id: "2", name: "TM Name 2"),
    TmRmModel(id: "3", name: "TM Name 3"),
  ];
  final localDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return localDataSource.getTmData();
});

final rmNamesProvider = FutureProvider<List<TmRmModel>>((ref) {
  return [
    TmRmModel(id: "1", name: "RM Name 1"),
    TmRmModel(id: "2", name: "RM Name 2"),
    TmRmModel(id: "3", name: "RM Name 3"),
  ];
  final localDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return localDataSource.getRmData();
});
