import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tgpl_network/constants/app_database.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/models/master_list_type.dart';
import 'package:tgpl_network/features/master_data/models/traffic_trades_model.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';

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

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Applications Table
    await db.execute(ApplicationModel.createSQLTableQuery);

    // Cities Table
    await db.execute(CityModel.createSQLTableQuery);

    // Traffic Trade Sites Table
    await db.execute(TrafficTradesModel.createSQLTableQuery);

    // Master Lists Table (storing as JSON)
    await db.execute(MasterListTypeTable.createSQLTableQuery);

    // Sync Metadata Table
    await db.execute('''
      CREATE TABLE ${AppDatabase.syncMetadataTable} (
        id $idType,
        lastSyncTime $textType
      )
    ''');

    // Survey Forms Table
    await db.execute(SurveyFormModel.createSQLTableQuery);

    // Traffic Trade Forms Table
    await db.execute(TrafficTradeFormModel.createSQLTableQuery);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clearMasterDataTables() async {
    final db = await instance.database;
    await db.delete(AppDatabase.applicationTable);
    await db.delete(AppDatabase.cityTable);
    await db.delete(AppDatabase.trafficTradeTable);
    await db.delete(AppDatabase.masterListsTable);
  }
}
