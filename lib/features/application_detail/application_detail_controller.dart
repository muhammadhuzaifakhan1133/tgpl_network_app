import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationDetailControllerProvider =
    NotifierProvider.autoDispose<ApplicationDetailController, ApplicationDetailState>(
        () => ApplicationDetailController());

class ApplicationDetailState {
  final bool isApplicationDetailCardExpanded;
  final bool isSiteDetailCardExpanded;
  final bool isContactDealerTGPLCardExpanded;
  final bool isTrafficCountCardExpanded;
  final bool isVolumeAndFinancialEstimationCardExpanded;
  final bool isRecommendationCardExpanded;
  final bool isDealerProfileCardExpanded;
  final bool isFeasibilityCardExpanded;

  ApplicationDetailState({
    this.isApplicationDetailCardExpanded = true,
    this.isSiteDetailCardExpanded = true,
    this.isContactDealerTGPLCardExpanded = true,
    this.isTrafficCountCardExpanded = true,
    this.isVolumeAndFinancialEstimationCardExpanded = true,
    this.isRecommendationCardExpanded = true,
    this.isDealerProfileCardExpanded = true,
    this.isFeasibilityCardExpanded = true,
  });

  ApplicationDetailState copyWith({
    bool? isApplicationDetailCardExpanded,
    bool? isSiteDetailCardExpanded,
    bool? isContactDealerTGPLCardExpanded,
    bool? isTrafficCountCardExpanded,
    bool? isVolumeAndFinancialEstimationCardExpanded,
    bool? isRecommendationCardExpanded,
    bool? isDealerProfileCardExpanded,
    bool? isFeasibilityCardExpanded,
  }) {
    return ApplicationDetailState(
      isApplicationDetailCardExpanded:
          isApplicationDetailCardExpanded ?? this.isApplicationDetailCardExpanded,
      isSiteDetailCardExpanded:
          isSiteDetailCardExpanded ?? this.isSiteDetailCardExpanded,
      isContactDealerTGPLCardExpanded: isContactDealerTGPLCardExpanded ??
          this.isContactDealerTGPLCardExpanded,
      isTrafficCountCardExpanded:
          isTrafficCountCardExpanded ?? this.isTrafficCountCardExpanded,
      isVolumeAndFinancialEstimationCardExpanded:
          isVolumeAndFinancialEstimationCardExpanded ??
              this.isVolumeAndFinancialEstimationCardExpanded,
      isRecommendationCardExpanded:
          isRecommendationCardExpanded ?? this.isRecommendationCardExpanded,
      isDealerProfileCardExpanded:
          isDealerProfileCardExpanded ?? this.isDealerProfileCardExpanded,
      isFeasibilityCardExpanded:
          isFeasibilityCardExpanded ?? this.isFeasibilityCardExpanded,
    );
  }
}

class ApplicationDetailController extends Notifier<ApplicationDetailState> {
  @override
  ApplicationDetailState build() {
    return ApplicationDetailState();
  }

  void toggleApplicationDetailCardExpanded() {
    state = state.copyWith(
      isApplicationDetailCardExpanded: !state.isApplicationDetailCardExpanded,
    );
  }

  void toggleSiteDetailCardExpanded() {
    state = state.copyWith(
      isSiteDetailCardExpanded: !state.isSiteDetailCardExpanded,
    );
  }

  void toggleContactDealerTGPLCardExpanded() {
    state = state.copyWith(
      isContactDealerTGPLCardExpanded:
          !state.isContactDealerTGPLCardExpanded,
    );
  }

  void toggleTrafficCountCardExpanded() {
    state = state.copyWith(
      isTrafficCountCardExpanded: !state.isTrafficCountCardExpanded,
    );
  }

  void toggleVolumeAndFinancialEstimationCardExpanded() {
    state = state.copyWith(
      isVolumeAndFinancialEstimationCardExpanded:
          !state.isVolumeAndFinancialEstimationCardExpanded,
    );
  }

  void toggleRecommendationCardExpanded() {
    state = state.copyWith(
      isRecommendationCardExpanded: !state.isRecommendationCardExpanded,
    );
  }

  void toggleDealerProfileCardExpanded() {
    state = state.copyWith(
      isDealerProfileCardExpanded: !state.isDealerProfileCardExpanded,
    );
  }

  void toggleFeasibilityCardExpanded() {
    state = state.copyWith(
      isFeasibilityCardExpanded: !state.isFeasibilityCardExpanded,
    );
  }
}