import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';

final syncStatusProvider =
    NotifierProvider<SyncStatusController, SyncStatus>(() {
      return SyncStatusController();
    });


class SyncStatusController extends Notifier<SyncStatus> {

  @override
  SyncStatus build() {
    return SyncStatus.offline;
  }
}
