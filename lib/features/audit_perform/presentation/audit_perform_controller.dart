import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/audit_perform/data/sample_data.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_page.dart';

final currentAuditPerformPageIndexProvider =
    NotifierProvider<CurrentAuditPerformPageIndexNotifier, int>(
      () => CurrentAuditPerformPageIndexNotifier(),
    );

class CurrentAuditPerformPageIndexNotifier extends Notifier<int> {
  @override
  int build() {
    return 0; // Start with the first page
  }

  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      state++;
    }
  }

  void previousPage() {
    if (state > 0) {
      state--;
    }
  }

  void goToPage(int pageIndex, int totalPages) {
    if (pageIndex >= 0 && pageIndex < totalPages) {
      state = pageIndex;
    }
  }
}

final auditPerformControllerProvider =
    AsyncNotifierProvider<AuditPerformController, AuditPerformState>(
      () => AuditPerformController(),
    );

class AuditPerformState {
  final List<AuditPage> pages;

  AuditPerformState({required this.pages});

  AuditPerformState copyWith({List<AuditPage>? pages}) {
    return AuditPerformState(pages: pages ?? this.pages);
  }
}

class AuditPerformController extends AsyncNotifier<AuditPerformState> {
  @override
  FutureOr<AuditPerformState> build() async {
    return AuditPerformState(pages: await getAuditPages());
  }

  Future<List<AuditPage>> getAuditPages() async {
    await Future.delayed(Duration(seconds: 1));
    return auditPages;
  }
}
