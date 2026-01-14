import 'package:flutter/material.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';

class SyncItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final SyncItemStatus status;

  SyncItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.status,
  });
}