import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';

// final cityNamesProvider = FutureProvider<List<String>>((ref) async {
//   final localDataSource = ref.watch(masterDataLocalDataSourceProvider);
//   final cities = await localDataSource.getCities();
//   return cities.map((city) => city.name).toList();
// });

final cityNamesProvider = Provider<List<String>>((ref) {
  return ["Karachi", "Lahore", "Islamabad"];
});