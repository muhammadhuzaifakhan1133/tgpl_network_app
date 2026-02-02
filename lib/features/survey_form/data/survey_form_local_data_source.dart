// lib/features/survey_form/data/datasources/survey_form_local_data_source.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';

abstract class SurveyFormLocalDataSource {
  Future<int> saveSurveyForm(SurveyFormModel form);
  Future<SurveyFormModel?> getSingleSurveyForm(String applicationId);
  Future<void> markSurveyFormAsSynced(String id);
  Future<void> updateSurveyFormErrorMessage(String id, String errorMessage);
  Future<void> deleteSurveyForm(String id);
}

class SurveyFormLocalDataSourceImpl implements SurveyFormLocalDataSource {
  final DatabaseHelper _databaseHelper;

  SurveyFormLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<int> saveSurveyForm(SurveyFormModel form) async {
    final db = await _databaseHelper.database;
    final now = DateTime.now().toIso8601String();

    return await db.insert(AppDatabase.surveyFormsTable, {
      ...form.toDatabaseMap(),
      'isSynced': 0,
      'createdAt': now,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<SurveyFormModel?> getSingleSurveyForm(String applicationId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.surveyFormsTable,
      where: 'applicationId = ?',
      whereArgs: [applicationId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return SurveyFormModel.fromDatabaseMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<void> markSurveyFormAsSynced(String id) async {
    final db = await _databaseHelper.database;
    await db.update(
      AppDatabase.surveyFormsTable,
      {'isSynced': 1, 'updatedAt': DateTime.now().toIso8601String()},
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateSurveyFormErrorMessage(
    String id,
    String errorMessage,
  ) async {
    final db = await _databaseHelper.database;
    await db.update(
      AppDatabase.surveyFormsTable,
      {
        'errorMessage': errorMessage,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteSurveyForm(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      AppDatabase.surveyFormsTable,
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }
}

// Provider
final surveyFormLocalDataSourceProvider = Provider<SurveyFormLocalDataSource>((
  ref,
) {
  return SurveyFormLocalDataSourceImpl(DatabaseHelper.instance);
});
