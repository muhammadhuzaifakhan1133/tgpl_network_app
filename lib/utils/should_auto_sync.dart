import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/last_sync_time_provider.dart';

const autoSyncThresholdMinutes = 30; // (in minutes)

 FutureOr<bool> shouldAutoSync(Ref ref) async {
  
    String lastSyncTimeIso = await ref.read(getLastSyncTimeProvider.future);
    
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