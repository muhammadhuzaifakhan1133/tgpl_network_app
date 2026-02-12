import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/master_data/models/master_list_type.dart';

String idType = DatabaseHelper.idType;
String textType = DatabaseHelper.textType;
String intType = DatabaseHelper.intType;
String realType = DatabaseHelper.realType;

class CreateDbQueries {
  static String createApplicationTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.applicationTable} (
      -- Primary Key
      id $idType,

      -- Basic Application Info
      applicationId $intType,
      applicationReceiveDate $textType,
      applicantName $textType,
      contactPersonName $textType,
      contactNumber $textType,
      whatsAppNumber $textType,
      currentlyPresence $textType,

      -- Location Info
      cityId $intType,
      cityName $textType,
      district $textType,
      landmark $textType,
      siteStatusId $intType,
      siteStatusName $textType,

      -- Plot Details
      plotFront $realType,
      plotDepth $realType,
      siteAddress $textType,
      googleLocation $textType,

      -- Contact Details
      emailAddress $textType,

      -- Survey Dates
      siteSurveyDealerProfileDueDate $textType,
      siteSurveyDealerProfileDoneDate $textType,

      -- Reference & Location
      referedBy $textType,
      nearestDepo $textType,
      distanceFromDepo $realType,
      typeOfTradeArea $textType,

      -- Dealer Information
      isThisDealerSite $textType,
      whatOtherBusiness $textType,
      howInvolveDealerInPetrol $textType,
      isDealerSole $textType,
      isDealerReadyToCapitalInvestment $textType,
      whyDoesTaj $textType,
      managerCurrentSalary $realType,
      isAgreeToTGPLStandard $textType,

      -- Site Names
      proposedSiteName1 $textType,
      proposedSiteName2 $textType,
      proposedSiteName3 $textType,

      -- Sales Estimates
      estimateDailyDieselSale $realType,
      estimateDailySuperSale $realType,
      estimateLubricantSale $realType,
      estimatedDailyHOBCSale $realType,
      expectedLeaseRentPerManth $realType,

      -- Potential Features
      truckPortPotential $textType,
      salamMartPotential $textType,
      resturantPotential $textType,

      -- Conversion Details
      isThisConversionPump $textType,
      currentOMCName $textType,
      isThisDealerInvestedSite $textType,
      numberOfOperationYear $realType,
      isCurrentlyOperational $textType,
      currentLeaseExpried $textType,

      -- Tank & Dispenser Info
      dieselUGTSizeLiter $realType,
      superUGTSizeLiter $realType,
      numberOfDieselDispenser $intType,
      numberOfSuperDispenser $intType,

      -- Site Conditions
      currentlyCanopyCondition $textType,
      conditionOfDispensors $textType,
      conditionOfForecourt $textType,

      -- Recommendations & Status
      recommendation $textType,
      recommendationDetail $textType,
      negotiationStatus $textType,
      finalDecisionStatus $textType,

      -- Agreements & Documents
      moUSignOff $textType,
      leaseAgreement $textType,
      franchiseAgreement $textType,
      capex $textType,

      -- Entry Details
      entryCode $textType,
      source $textType,
      sourceName $textType,
      priority $textType,
      platForm $textType,
      npPersonName $textType,

      -- Fees & Documentation
      joiningFees $textType,
      topography $textType,
      dcnoc $textType,
      explosive $textType,
      amendmentExplosive $textType,
      appliedInexplosive $textType,

      -- AE (Approval/Engineering) Fields
      aeConstructionApproval $textType,
      aeSaftyCompletion $textType,
      aeKForm $textType,
      aeAmendment $textType,
      aeConstructionStart $textType,
      aeConstructionUpdate $textType,

      -- HOTO & Steps
      hoto $textType,
      lastStepDoneBefore $textType,

      -- Survey Recommendations (TM)
      ssRecommendationTMName $textType,
      sstmRecommendation $textType,
      sstmRemarks $textType,

      -- Survey Recommendations (RM)
      ssRecommendationRMName $textType,
      ssrmRecommendation $textType,
      ssrmRemarks $textType,

      -- Traffic Trade Recommendations (TM)
      ttRecommendationTMName $textType,
      tttmRecommendation $textType,
      tttmRemarks $textType,

      -- Traffic Trade Recommendations (RM)
      ttRecommendationRMName $textType,
      ttrmRecommendation $textType,
      ttrmRemarks $textType,

      -- Drawings & Construction
      drawingLayout $textType,
      issuanceOfDrawings $textType,
      changeStatusRemarks $textType,
      constructionStartDate $textType,
      constructionEndDate $textType,
      constructionStatusInPercent $intType,

      -- Process Completion Flags (0 = Not Done, 1 = Done)
      surveynDealerProfileDone $intType DEFAULT 0,
      trafficTradeDone $intType DEFAULT 0,
      feasibilityDone $intType DEFAULT 0,
      negotiationDone $intType DEFAULT 0,
      mouSignOFFDone $intType DEFAULT 0,
      joiningFeeDone $intType DEFAULT 0,
      franchiseAgreementDone $intType DEFAULT 0,
      feasibilityfinalizationDone $intType DEFAULT 0,
      explosiveLayoutDone $intType DEFAULT 0,
      drawingsDone $intType DEFAULT 0,
      topographyDone $intType DEFAULT 0,
      issuanceofDrawingsDone $intType DEFAULT 0,
      appliedInExplosiveDone $intType DEFAULT 0,
      dcnocDone $intType DEFAULT 0,
      capexDone $intType DEFAULT 0,
      leaseAgreementDone $intType DEFAULT 0,
      hotoDone $intType DEFAULT 0,
      inaugurationDone $intType DEFAULT 0,
      constructionDone $intType DEFAULT 0,

      -- Current Status
      statusId $intType,

      -- Due Dates
      trafficTradeDueDate $textType,
      trafficTradeDoneDate $textType,
      feasibilityDueDate $textType,
      feasibilityDoneDate $textType,
      negotiationDueDate $textType,
      negotiationDoneDate $textType,
      feasibilityfinalizationDueDate $textType,
      feasibilityfinalizationDoneDate $textType,
      mouSignOFFDueDate $textType,
      mouSignOFFDoneDate $textType,
      joiningFeeDueDate $textType,
      joiningFeeDoneDate $textType,
      franchiseAgreementDueDate $textType,
      franchiseAgreementDoneDate $textType,
      explosiveLayoutDueDate $textType,
      explosiveLayoutDoneDate $textType,
      issuanceofDrawingsDueDate $textType,
      issuanceofDrawingsDoneDate $textType,
      topographyDueDate $textType,
      topographyDoneDate $textType,
      drawingsDueDate $textType,
      drawingsDoneDate $textType,
      capaxDueDate $textType,
      capaxDoneDate $textType,
      appliedInExplosiveDueDate $textType,
      appliedInExplosiveDoneDate $textType,
      dcnocDueDate $textType,
      dcnocDoneDate $textType,
      leaseAgreementDueDate $textType,
      leaseAgreementDoneDate $textType,
      constructionDueDate $textType,
      constructionDoneDate $textType,
      hotoDueDate $textType,
      hotoDoneDate $textType,
      inaugurationDueDate $textType,
      inaugurationDoneDate $textType
    );
  ''';

  static String createIndexesOnApplicationTable =
      '''
    CREATE INDEX IF NOT EXISTS idx_applications_applicationId ON ${AppDatabase.applicationTable}(applicationId);
    CREATE INDEX IF NOT EXISTS idx_applications_statusId ON ${AppDatabase.applicationTable}(statusId);
    CREATE INDEX IF NOT EXISTS idx_applications_cityName ON ${AppDatabase.applicationTable}(cityName);
    CREATE INDEX IF NOT EXISTS idx_applications_priority ON ${AppDatabase.applicationTable}(priority);
    CREATE INDEX IF NOT EXISTS idx_applications_entryCode ON ${AppDatabase.applicationTable}(entryCode);
    CREATE INDEX IF NOT EXISTS idx_applications_siteStatusId ON ${AppDatabase.applicationTable}(siteStatusId);
    CREATE INDEX IF NOT EXISTS idx_applications_applicationReceiveDate ON ${AppDatabase.applicationTable}(applicationReceiveDate);
  ''';

  static String createCityTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.cityTable} (
      id $idType,
      cityId $intType UNIQUE,
      name $textType
    )
  ''';

  static String createTrafficTradeTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.trafficTradeTable} (
      id $idType,
      trafficTradeId $intType UNIQUE,
      applicationId $intType,
      proposedSiteName $textType,
      estimateDailyDieselSale $realType,
      estimateDailySuperSale $realType,
      estimateLubricantSale $realType,
      expectedLeaseRentPerManth $realType,
      nfrFacility $textType,
      nfrName $textType,
      nflFacilityAvailable $textType
    )
  ''';

  static String createMasterListsTable =
      '''
      CREATE TABLE ${AppDatabase.masterListsTable} (
        id $idType,
        ${MasterListTypeTable.databaseColName} $textType UNIQUE,
        listValues $textType
      )
    ''';

  static String syncMetadataTable =
      '''
      CREATE TABLE ${AppDatabase.syncMetadataTable} (
        id $idType,
        lastSyncTime $textType
      )
    ''';

  static String createSurveyFormsTable =
      '''
  CREATE TABLE ${AppDatabase.surveyFormsTable} (
    id $idType,
    applicationId $textType UNIQUE,
    entryCode $textType,
    dateConducted $textType,
    conductedBy $textType,
    googleLocation $textType,
    city $textType,
    district $textType,
    siteStatus $textType,
    npName $textType,
    source $textType,
    sourceName $textType,
    priority $textType,
    dealerName $textType,
    dealerContact $textType,
    referenceBy $textType,
    locationAddress $textType,
    landmark $textType,
    plotFront $textType,
    plotDepth $textType,
    plotArea $textType,
    nearestDepo $textType,
    distanceFromDepo $textType,
    typeOfTradeArea $textType,
    isThisDealer $textType,
    dealerPlatform $textType,
    dealerBusinesses $textType,
    dealerInvolvement $textType,
    isDealerReadyToInvest $textType,
    dealerOpinion $textType,
    monthlySalary $textType,
    isDealerAgreedToFollowTgplStandards $textType,
    selectedTM $textType,
    tmRecommendation $textType,
    tmRemarks $textType,
    selectedRM $textType,
    rmRecommendation $textType,
    rmRemarks $textType,
    isSynced $intType DEFAULT 0,
    errorMessage $textType,
    createdAt $textType,
    updatedAt $textType
  )
''';

  static String createTrafficTradeFormsTable =
      '''
  CREATE TABLE ${AppDatabase.trafficTradeFormsTable} (
    id $idType,
    applicationId $textType UNIQUE,
    nearbyTrafficSites $textType,
    trafficCountTruck $textType,
    trafficCountCar $textType,
    trafficCountBike $textType,
    dailyDieselSales $textType,
    dailySuperSales $textType,
    dailyHOBCSales $textType,
    dailyLubricantSales $textType,
    rentExpectation $textType,
    truckPortPotential $textType,
    salamMartPotential $textType,
    restaurantPotential $textType,
    selectedTM $textType,
    selectedRM $textType,
    selectedTMRecommendation $textType,
    selectedRMRecommendation $textType,
    tmRemarks $textType,
    rmRemarks $textType,
    isSynced $intType DEFAULT 0,
    errorMessage $textType,
    createdAt $textType,
    updatedAt $textType
  )
''';

  static String createUserInfoTable =
      '''
    CREATE TABLE ${AppDatabase.userInfoTable} (
      userId $intType PRIMARY KEY,
      userName $textType,
      fullName $textType,
      companyId $intType,
      companyDisplayName $textType,
      companyLogo $textType,
      positionId $intType,
      positionName $textType,
      email $textType,
      contact $textType,
      treePath $textType,
      isSuperAdmin $intType,
      message $textType,
      success $intType,
      hasSurveyFormAccess $intType,
      hasTrafficTradeFormAccess $intType
    )
  ''';

  static String createSiteStatusTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.siteStatusTable} (
      id $idType,
      siteStatusId $intType UNIQUE,
      name $textType
    )
  ''';

  static String createTmTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.tmTable} (
      id $idType,
      tmId $intType,
      name $textType
    )
  ''';

  static String createRmTable =
      '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.rmTable} (
      id $idType,
      rmId $intType,
      name $textType
    )
  ''';
}
