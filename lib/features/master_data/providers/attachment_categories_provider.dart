import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/data/master_data_local_data_source.dart';
import 'package:tgpl_network/features/master_data/models/attachment_category_model.dart';
final attachmentCategoriesProvider = FutureProvider<List<AttachmentCategoryModel>>((ref) async {
  final masterDataLocalDataSource = ref.watch(masterDataLocalDataSourceProvider);
  return await masterDataLocalDataSource.getAttachmentCategories();
});