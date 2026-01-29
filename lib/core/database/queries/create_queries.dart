import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/master_data/models/master_list_type.dart';

String idType = DatabaseHelper.idType;
String textType = DatabaseHelper.textType;
String intType = DatabaseHelper.intType;
String realType = DatabaseHelper.realType;

class CreateDbQueries {
  static String createApplicationTable = '''
      CREATE TABLE IF NOT EXISTS ${AppDatabase.applicationTable} (
        id $idType,
        applicationId $intType UNIQUE,
        dateConducted $textType,
        preparedBy $textType,
        googleLocation $textType,
        cityId $intType,
        cityName $textType,
        district $textType,
        dealerName $textType,
        dealerContact $textType,
        referedBy $textType,
        locationAddress $textType,
        landmark $textType,
        plotArea $textType,
        plotFront $realType,
        plotDepth $realType,
        nearestDepo $textType,
        distanceFromDetp $realType,
        typeOfTradeArea $textType,
        isThisDealerSite $textType,
        whatOtherBusiness $textType,
        howInvolveDealerInPetrol $textType,
        isDealerSole $textType,
        isDealerReadyToCapitalInvestment $textType,
        proposedSiteName1 $textType,
        whyDoesTaj $textType,
        managerCurrentSalary $realType,
        isAgreeToTGPLStandard $textType,
        addDate $textType,
        editDate $textType,
        addBy $textType,
        editBy $textType,
        entryCode $textType,
        source $textType,
        sourceName $textType,
        priority $textType,
        platform $textType,
        statusId $intType,
        siteNumber $intType,
        estimateDailyDieselSale $intType,
        estimateDailySuperSale $intType,
        estimateLubricantSale $intType,
        expectedLeaseRentPerManth $intType,
        nflFacilityAvailable $textType,
        nflFacilityName $textType,
        truckCount $intType,
        carCount $intType,
        bikeCount $intType,
        busCount $intType,
        npPersonName $textType,
        joiningFees $textType,
        topography $textType,
        dcNoc $textType,
        explosive $textType,
        amendmentExplosive $textType,
        appliedInExplosive $textType,
        aeConstructionApproval $textType,
        aeSafetyCompletion $textType,
        aeKForm $textType,
        aeAmendment $textType,
        aeConstructionStart $textType,
        aeConstructionUpdate $textType,
        hoto $textType,
        lastStep $textType,
        ssRecommendationTmName $textType,
        ssTmRecommendation $textType,
        ssTmRemarks $textType,
        ssRecommendationRmName $textType,
        ssRmRecommendation $textType,
        ssRmRemarks $textType,
        ttRecommendationTmName $textType,
        ttTmRecommendation $textType,
        ttTmRemarks $textType,
        ttRecommendationRmName $textType,
        ttRmRecommendation $textType,
        ttRmRemarks $textType,
        truckKCount $textType,
        siteStatusId $intType,
        drawingLayout $textType,
        issuanceOfDrawings $textType,
        changeStatusRemarks $textType,
        constructionStartDate $textType,
        constructionEndDate $textType,
        constructionStatusInPercent $intType,
        constructionDone $intType,
        surveyDealerProfileDone $intType,
        trafficTradeDone $intType,
        feasibilityDone $intType,
        negotiationDone $intType,
        mouSignOffDone $intType,
        joiningFeeDone $intType,
        franchiseAgreementDone $intType,
        feasibilityFinalizationDone $intType,
        explosiveLayoutDone $intType,
        drawingsDone $intType,
        topographyDone $intType,
        issuanceOfDrawingsDone $intType,
        appliedInExplosiveDone $intType,
        dcNocDone $intType,
        capexDone $intType,
        leaseAgreementDone $intType,
        hotoDone $intType,
        inaugurationDone $intType,
        numberOfOperationYear $intType,
        trucPortPotentail $textType,
        salamMartPotential $textType,
        resturantPotential $textType,
        isThisConversionPump $textType,
        currentOMCName $textType,
        isThisDealerInvestedSite $textType,
        isCurrentlyOperational $textType,
        currentLeaseExpried $textType,
        dieselUGTSizeLiter $intType,
        superUGTSizeLiter $intType,
        numberOfDieselDispenser $intType,
        numberOfSuperDispenser $intType,
        currentlyCanopyCondition $textType,
        conditionOfDispensors $textType,
        conditionOfForecourt $textType,
        recommendation $textType,
        recommendationDetail $textType,
        negotiationStatus $textType,
        finalDecisionStatus $textType,
        mouSignOff $textType,
        leaseAgreement $textType,
        franchiseAgreement $textType,
        capex $textType,
        success $intType,
        message $textType,
        recordId $intType,
        accessLevel $intType
      )
    ''';

  static String createStatusIdIndexOnApplicationTable = '''
    CREATE INDEX IF NOT EXISTS idx_application_status ON ${AppDatabase.applicationTable}(statusId);
  ''';

  static String createCityTable = '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.cityTable} (
      id $idType,
      cityId $intType UNIQUE,
      name $textType
    )
  ''';

  static String createTrafficTradeTable = '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.trafficTradeTable} (
      id $idType,
      trafficTradeId $intType UNIQUE,
      applicationId $intType,
      proposedSiteName $textType,
      estimateDailyDieselSale $intType,
      estimateDailySuperSale $intType,
      estimateLubricantSale $intType,
      expectedLeaseRentPerManth $intType,
      nfrFacility $textType,
      nfrName $textType,
      nflFacilityAvailable $textType
    )
  ''';

  static String createMasterListsTable = '''
      CREATE TABLE ${AppDatabase.masterListsTable} (
        id $idType,
        ${MasterListTypeTable.databaseColName} $textType UNIQUE,
        listValues $textType
      )
    ''';

  static String syncMetadataTable = '''
      CREATE TABLE ${AppDatabase.syncMetadataTable} (
        id $idType,
        lastSyncTime $textType
      )
    ''';

  static String createSurveyFormsTable = '''
  CREATE TABLE ${AppDatabase.surveyFormsTable} (
    id $idType,
    applicationId $textType,
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
    createdAt $textType,
    updatedAt $textType
  )
''';

  static String createTrafficTradeFormsTable = '''
  CREATE TABLE ${AppDatabase.trafficTradeFormsTable} (
    id $idType,
    applicationId $textType,
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
    createdAt $textType,
    updatedAt $textType
  )
''';

  static String createUserInfoTable = '''
    CREATE TABLE ${AppDatabase.userInfoTable} (
      userId INTEGER PRIMARY KEY,
      userName TEXT,
      fullName TEXT,
      companyId INTEGER,
      companyDisplayName TEXT,
      companyLogo TEXT,
      positionId INTEGER,
      email TEXT,
      contact TEXT,
      treePath TEXT,
      isSuperAdmin INTEGER,
      message TEXT,
      success INTEGER,
      hasSurveyFormAccess INTEGER,
      hasTrafficTradeFormAccess INTEGER
    )
  ''';

  static String createSiteStatusTable = '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.siteStatusTable} (
      id $idType,
      siteStatusId $intType UNIQUE,
      name $textType
    )
  ''';
}