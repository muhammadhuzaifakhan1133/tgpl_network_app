import 'package:flutter/material.dart';
import 'package:tgpl_network/common/models/sync_enum.dart';

class SyncStatusCard extends StatelessWidget {
  final SyncStatus status;
  final String lastSyncTime;
  final VoidCallback? onResync;

  const SyncStatusCard({
    super.key,
    required this.status,
    required this.lastSyncTime,
    this.onResync,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SyncStatus.offline:
        return _buildOfflineCard();
      case SyncStatus.syncing:
        return _buildSyncingCard();
      case SyncStatus.synchronized:
        return _buildSynchronizedCard();
    }
  }

  Widget _buildOfflineCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C42), Color(0xFFFF9D5C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.wifi_off, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Offline Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'No internet connection',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Last sync: $lastSyncTime',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          if (onResync != null)
            IconButton(
              onPressed: onResync,
              icon: const Icon(Icons.refresh, size: 24),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSyncingCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Syncing data...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last sync: $lastSyncTime',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSynchronizedCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Synchronized',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last sync: $lastSyncTime',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          if (onResync != null)
            IconButton(
              onPressed: onResync,
              icon: const Icon(Icons.refresh, size: 24),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
              ),
            ),
        ],
      ),
    );
  }
}

// Example usage
class SyncStatusDemo extends StatefulWidget {
  const SyncStatusDemo({Key? key}) : super(key: key);

  @override
  State<SyncStatusDemo> createState() => _SyncStatusDemoState();
}

class _SyncStatusDemoState extends State<SyncStatusDemo> {
  SyncStatus currentStatus = SyncStatus.offline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Sync Status Cards'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SyncStatusCard(
                status: currentStatus,
                lastSyncTime: currentStatus == SyncStatus.syncing
                    ? '5 minutes ago'
                    : currentStatus == SyncStatus.offline
                    ? '2 hours ago'
                    : 'Just now',
                onResync: () {
                  debugPrint('Resync triggered');
                },
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentStatus = SyncStatus.offline),
                  child: const Text('Offline'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentStatus = SyncStatus.syncing),
                  child: const Text('Syncing'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => currentStatus = SyncStatus.synchronized),
                  child: const Text('Synchronized'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
