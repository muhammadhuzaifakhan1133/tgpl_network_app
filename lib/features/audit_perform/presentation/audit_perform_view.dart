import 'package:flutter/material.dart';
import 'package:tgpl_network/features/audit_perform/presentation/widgets/page_title.dart';

class AuditPerformView extends StatelessWidget {
  const AuditPerformView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AuditPerformPageTitle(),
        ],
      ),
    );
  }
}