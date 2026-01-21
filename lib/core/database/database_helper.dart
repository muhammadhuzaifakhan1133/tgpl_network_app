import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tgpl_master_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const realType = 'REAL';

    // Applications Table
    await db.execute('''
      CREATE TABLE applications (
        id $idType,
        applicationId $intType,
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
        isDealerSite $textType,
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
        drawingLayout $textType,
        issuanceOfDrawings $textType,
        changeStatusRemarks $textType,
        constructionStartDate $textType,
        constructionEndDate $textType,
        constructionStatusInPercent $textType,
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
        recommendation $textType,
        recommendationDetail $textType,
        negotiationStatus $textType,
        finalDecisionStatus $textType,
        mouSignOff $textType,
        leaseAgreement $textType,
        franchiseAgreement $textType,
        capex $textType
      )
    ''');

    // Cities Table
    await db.execute('''
      CREATE TABLE cities (
        id $idType,
        cityId $intType,
        name $textType
      )
    ''');

    // Traffic Trade Sites Table
    await db.execute('''
      CREATE TABLE traffic_trades (
        id $idType,
        trafficTradeId $intType,
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
    ''');

    // Master Lists Table (storing as JSON)
    await db.execute('''
      CREATE TABLE master_lists (
        id $idType,
        listType $textType,
        values $textType
      )
    ''');

    // Sync Metadata Table
    await db.execute('''
      CREATE TABLE sync_metadata (
        id $idType,
        lastSyncTime $textType
      )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearAllTables() async {
    final db = await instance.database;
    await db.delete('applications');
    await db.delete('cities');
    await db.delete('traffic_trades');
    await db.delete('master_lists');
  }
}