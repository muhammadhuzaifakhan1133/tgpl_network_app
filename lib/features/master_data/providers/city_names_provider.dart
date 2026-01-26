import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
// import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';

// final cityNamesProvider = FutureProvider<List<String>>((ref) async {
//   final localDataSource = ref.watch(masterDataLocalDataSourceProvider);
//   final cities = await localDataSource.getCities();
//   return cities.map((city) => city.name).toList();
// });

final cityNamesProvider = FutureProvider<List<CityModel>>((ref) async {
  final masterDataLocalDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return await masterDataLocalDataSource.getCities();
});