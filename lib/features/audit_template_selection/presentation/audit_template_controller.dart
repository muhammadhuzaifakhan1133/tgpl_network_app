import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/audit_template_selection/model/audit_template.dart';

final auditTemplateControllerProvider =
    NotifierProvider<AuditTemplateController, List<AuditTemplate>>(
  () => AuditTemplateController(),
);

class AuditTemplateController extends Notifier<List<AuditTemplate>> {
  @override
  List<AuditTemplate> build() {
    return allTemplates;
  }

  void filterTemplates(String query) {
    if (query.isEmpty) {
      state = allTemplates;
    } else {
      state = allTemplates
          .where((template) =>
              template.label.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  List<AuditTemplate> get allTemplates =>  [
        AuditTemplate(
          icon: Icons.checklist_rounded,
          label: "Quick Checklist",
          description: "General compliance and readiness check",
        ),
        AuditTemplate(
          icon: Icons.business_rounded,
          label: "Site Visit Report - COCO",
          description: "Company-operated site performance inspection",
        ),
        AuditTemplate(
          icon: Icons.business_rounded,
          label: "Site Visit Report - Dealer",
          description: "Dealer-operated site operational view",
        ),
        AuditTemplate(
          icon: Icons.engineering_rounded,
          label: "Customer Experience Review",
          description: "Service quality and customer satisfaction",
        ),
        AuditTemplate(
          icon: Icons.assessment_rounded,
          label: "Market Visit Report",
          description: "Competitor analysis and market assessment",
        ),
        AuditTemplate(
          icon: Icons.store_rounded,
          label: "Salam Mart Checklist",
          description: "Convenience store standards compliance audit",
        ),
        AuditTemplate(
          icon: Icons.inventory_2_rounded,
          label: "Stock Recon Report",
          description: "Full Stock Reconcilation and variance",
        ),
        AuditTemplate(
          icon: Icons.health_and_safety_rounded,
          label: "HSSE Report",
          description: "Health, Safety, Security compliance inspection",
        ),
      ];
}