import 'package:flutter/material.dart';

class ModuleModel {
  final String title;
  final int count;
  final Color color;
  final String icon;
  final List<SubModuleModel> subModules;

  ModuleModel({required this.title, required this.count, required this.color, required this.icon, required this.subModules});
}

class SubModuleModel {
  final String title;
  final int count;
  final String moduleName;
  final Color moduleColor;
  final String moduleIcon;
  final String dbCondition;

  SubModuleModel({required this.title, required this.count, required this.moduleName, required this.moduleColor, required this.moduleIcon, required this.dbCondition});
}