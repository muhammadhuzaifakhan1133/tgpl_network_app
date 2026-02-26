import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_page.dart';

final currentAuditPerformPageIndexProvider = StateProvider<int>((ref) => 0);

final auditPerformPageControllerProvider =
    NotifierProvider<AuditPerformPageController, List<AuditPerformPageState>>(
  () => AuditPerformPageController(),
);

class AuditPerformPageState {
  final AuditPage page;
  final double score;

  AuditPerformPageState({
    required this.page,
    this.score = 0,
  });

  AuditPerformPageState copyWith({
    AuditPage? page,
    double? score,
  }) {
    return AuditPerformPageState(
      page: page ?? this.page,
      score: score ?? this.score,
    );
  }
}

class AuditPerformPageController extends Notifier<List<AuditPerformPageState>> {
  
  @override
  List<AuditPerformPageState> build() {
    return [];
  }

  void addScore(int pageId, double score) {
    state = [
      for (final pageState in state)
        if (pageState.page.pageId == pageId)
          pageState.copyWith(score: score)
        else
          pageState,
    ];
  }

  void removeScore(int pageId) {
    state = [
      for (final pageState in state)
        if (pageState.page.pageId == pageId)
          pageState.copyWith(score: 0)
        else
          pageState,
    ];
  }

  void nextPage() {
    final currentIndex = ref.read(currentAuditPerformPageIndexProvider);
    if (currentIndex < state.length - 1) {
      ref.read(currentAuditPerformPageIndexProvider.notifier).state++;
    }
  }

  void previousPage() {
    final currentIndex = ref.read(currentAuditPerformPageIndexProvider);
    if (currentIndex > 0) {
      ref.read(currentAuditPerformPageIndexProvider.notifier).state--;
    }
  }

  void setPage(int pageIndex) {
    if (pageIndex >= 0 && pageIndex < state.length) {
      ref.read(currentAuditPerformPageIndexProvider.notifier).state = pageIndex;
    }
  }
}