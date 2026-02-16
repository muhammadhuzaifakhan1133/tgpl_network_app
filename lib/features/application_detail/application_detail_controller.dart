import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
import 'package:tgpl_network/features/application_detail/data/application_stage_model.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

final applicationDetailControllerProvider =
    NotifierProvider.autoDispose<
      ApplicationDetailController,
      ApplicationDetailState
    >(() => ApplicationDetailController());

final applicationDetailAsyncControllerProvider = AsyncNotifierProvider.family
    .autoDispose<
      ApplicationDetailAsyncController,
      ApplicationDetailValues,
      String
    >((applicationId) {
      return ApplicationDetailAsyncController(applicationId: applicationId);
    });

class ApplicationDetailState {
  final bool isApplicationDetailCardExpanded;
  final bool isSiteDetailCardExpanded;
  final bool isContactDealerTGPLCardExpanded;
  final bool isTrafficCountCardExpanded;
  final bool isVolumeAndFinancialEstimationCardExpanded;
  final bool isRecommendationCardExpanded;
  final bool isDealerProfileCardExpanded;
  final bool isFeasibilityCardExpanded;
  final bool areAllCardsExpanded; // Track overall state
  final String selectedStatus;

  ApplicationDetailState({
    this.isApplicationDetailCardExpanded = true,
    this.isSiteDetailCardExpanded = true,
    this.isContactDealerTGPLCardExpanded = true,
    this.isTrafficCountCardExpanded = true,
    this.isVolumeAndFinancialEstimationCardExpanded = true,
    this.isRecommendationCardExpanded = true,
    this.isDealerProfileCardExpanded = true,
    this.isFeasibilityCardExpanded = true,
    this.areAllCardsExpanded = true,
    this.selectedStatus = "All Tasks",
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
    bool? areAllCardsExpanded,
    String? selectedStatus,
  }) {
    return ApplicationDetailState(
      isApplicationDetailCardExpanded:
          isApplicationDetailCardExpanded ??
          this.isApplicationDetailCardExpanded,
      isSiteDetailCardExpanded:
          isSiteDetailCardExpanded ?? this.isSiteDetailCardExpanded,
      isContactDealerTGPLCardExpanded:
          isContactDealerTGPLCardExpanded ??
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
      areAllCardsExpanded: areAllCardsExpanded ?? this.areAllCardsExpanded,
      selectedStatus: selectedStatus ?? this.selectedStatus,
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
    _updateAllCardsExpandedState();
  }

  void toggleSiteDetailCardExpanded() {
    state = state.copyWith(
      isSiteDetailCardExpanded: !state.isSiteDetailCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleContactDealerTGPLCardExpanded() {
    state = state.copyWith(
      isContactDealerTGPLCardExpanded: !state.isContactDealerTGPLCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleTrafficCountCardExpanded() {
    state = state.copyWith(
      isTrafficCountCardExpanded: !state.isTrafficCountCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleVolumeAndFinancialEstimationCardExpanded() {
    state = state.copyWith(
      isVolumeAndFinancialEstimationCardExpanded:
          !state.isVolumeAndFinancialEstimationCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleRecommendationCardExpanded() {
    state = state.copyWith(
      isRecommendationCardExpanded: !state.isRecommendationCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleDealerProfileCardExpanded() {
    state = state.copyWith(
      isDealerProfileCardExpanded: !state.isDealerProfileCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  void toggleFeasibilityCardExpanded() {
    state = state.copyWith(
      isFeasibilityCardExpanded: !state.isFeasibilityCardExpanded,
    );
    _updateAllCardsExpandedState();
  }

  // New method to expand/collapse all cards
  void toggleAllCards() {
    final newState = !state.areAllCardsExpanded;
    state = state.copyWith(
      isApplicationDetailCardExpanded: newState,
      isSiteDetailCardExpanded: newState,
      isContactDealerTGPLCardExpanded: newState,
      isTrafficCountCardExpanded: newState,
      isVolumeAndFinancialEstimationCardExpanded: newState,
      isRecommendationCardExpanded: newState,
      isDealerProfileCardExpanded: newState,
      isFeasibilityCardExpanded: newState,
      areAllCardsExpanded: newState,
    );
  }

  // Helper method to update the overall expanded state
  void _updateAllCardsExpandedState() {
    final allExpanded =
        state.isApplicationDetailCardExpanded &&
        state.isSiteDetailCardExpanded &&
        state.isContactDealerTGPLCardExpanded &&
        state.isTrafficCountCardExpanded &&
        state.isVolumeAndFinancialEstimationCardExpanded &&
        state.isRecommendationCardExpanded &&
        state.isDealerProfileCardExpanded &&
        state.isFeasibilityCardExpanded;

    state = state.copyWith(areAllCardsExpanded: allExpanded);
  }

  void selectStatus(String status) {
    state = state.copyWith(selectedStatus: status);
  }
}

class ApplicationDetailValues {
  final ApplicationModel application;
  final ApplicationProgressSummary progressSummary;

  ApplicationDetailValues({
    required this.application,
    required this.progressSummary,
  });
}

class ApplicationDetailAsyncController
    extends AsyncNotifier<ApplicationDetailValues> {
  final String applicationId;
  ApplicationDetailAsyncController({required this.applicationId});

  @override
  Future<ApplicationDetailValues> build() async {
    final applicationDataSource = ref.read(applicationDetailDataSourceProvider);
    final application = await applicationDataSource.getApplicationDetail(
      applicationId,
    );
    final progressSummary = ApplicationProgressSummary.fromApplicationStatuses(
      ref.read(appStatusesProvider(application)),
    );
    return ApplicationDetailValues(
      application: application,
      progressSummary: progressSummary,
    );
  }

  // Add this method to sync application data
  Future<void> syncApplicationData() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final applicationDataSource = ref.read(
        applicationDetailDataSourceProvider,
      );
      final updatedApplication = await applicationDataSource
          .syncApplicationFromServer(applicationId);
      final progressSummary =
          ApplicationProgressSummary.fromApplicationStatuses(
            ref.read(appStatusesProvider(updatedApplication)),
          );
      return ApplicationDetailValues(
        application: updatedApplication,
        progressSummary: progressSummary,
      );
    });
  }
}
