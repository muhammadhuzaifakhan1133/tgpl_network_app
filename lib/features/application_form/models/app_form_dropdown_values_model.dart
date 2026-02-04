import 'package:tgpl_network/features/master_data/models/city_model.dart';
import 'package:tgpl_network/features/master_data/models/hml_model.dart';
import 'package:tgpl_network/features/application_form/models/site_status_model.dart';

class AppFormDropdownsValuesModel {
  final List<CityModel> cities;
  final List<SiteStatusModel> siteStatuses;
  final List<HMLModel> hmlList;

  AppFormDropdownsValuesModel({
    required this.cities,
    required this.siteStatuses,
    required this.hmlList,
  });

  factory AppFormDropdownsValuesModel.fromAPIResponse(Map<String, dynamic> json) {
    return AppFormDropdownsValuesModel(
      cities: (json['CityList'] as List)
          .map((city) => CityModel.fromAPIResponseMap(city))
          .toList(),
      siteStatuses: (json['SiteStatusList'] as List)
          .map((status) => SiteStatusModel.fromAPIResponseMap(status))
          .toList(),
      hmlList: (json['PriorityList'] as List)
          .map((hml) => HMLModel(hml["Name"]))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'AppFormDropdownsValuesModel(cities: $cities, siteStatuses: $siteStatuses, hmlList: $hmlList)';
  }
}