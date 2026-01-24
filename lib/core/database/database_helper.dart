import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/queries/create_queries.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const textType = 'TEXT';
  static const intType = 'INTEGER';
  static const realType = 'REAL';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppDatabase.databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        // future-safe
      },
    );
  }

  Future _createDB(Database db, int version) async {
    // await clearAllTables(); // temp

    // Applications Table
    await db.execute(CreateDbQueries.createApplicationTable);

    // Create index on statusId column
    await db.execute(CreateDbQueries.createStatusIdIndexOnApplicationTable);

    // Cities Table
    await db.execute(CreateDbQueries.createCityTable);

    // Traffic Trade Sites Table
    await db.execute(CreateDbQueries.createTrafficTradeTable);

    // Master Lists Table (storing as JSON)
    await db.execute(CreateDbQueries.createMasterListsTable);

    // Sync Metadata Table
    await db.execute(CreateDbQueries.syncMetadataTable);

    // Survey Forms Table
    await db.execute(CreateDbQueries.createSurveyFormsTable);

    // Traffic Trade Forms Table
    await db.execute(CreateDbQueries.createTrafficTradeFormsTable);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearAllTables() async {
    final db = await instance.database;
    await clearMasterDataTables();
    await db.delete(AppDatabase.surveyFormsTable);
    await db.delete(AppDatabase.trafficTradeFormsTable);
    await db.delete(AppDatabase.syncMetadataTable);
  }

  Future<void> clearMasterDataTables() async {
    final db = await instance.database;
    await db.delete(AppDatabase.applicationTable);
    await db.delete(AppDatabase.cityTable);
    await db.delete(AppDatabase.trafficTradeTable);
    await db.delete(AppDatabase.masterListsTable);
  }
}
