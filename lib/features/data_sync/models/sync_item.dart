import 'package:flutter/material.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';

class SyncItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final SyncItemStatus status;

  const SyncItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  SyncItem copyWith({
    IconData? icon,
    Color? iconColor,
    String? title,
    String? subtitle,
    SyncItemStatus? status,
  }) {
    return SyncItem(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      status: status ?? this.status,
    );
  }
}
