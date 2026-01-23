  import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/data/sync_status_data_source.dart';

const autoSyncThresholdMinutes = 30; // (in minutes)

 FutureOr<bool> shouldAutoSync({String? lastSyncTimeIso, Ref? ref}) async {
  if (lastSyncTimeIso == null) {
    assert(ref != null, 'Ref must be provided if lastSyncTimeIso is null');
       lastSyncTimeIso = await ref!.read(syncStatusDataSourceProvider).getLastSyncTime();
    }
    if (lastSyncTimeIso.isEmpty || lastSyncTimeIso == "Never") {
      return true; // Always sync if never synced before
    }

    try {
      final lastSync = DateTime.parse(lastSyncTimeIso);
      final now = DateTime.now();
      final difference = now.difference(lastSync);

      // Auto-sync if difference is greater than threshold
      return difference.inMinutes >= autoSyncThresholdMinutes;
    } catch (e) {
      return true; // Sync on error to be safe
    }
  }