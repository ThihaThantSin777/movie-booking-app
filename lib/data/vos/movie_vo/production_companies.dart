import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../persistance/hive_constant.dart';

part 'production_companies.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_PRODUCTION_COMPANIES)
class ProductionCompanies {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'logo_path')
  @HiveField(1)
  String? logoPath;

  @JsonKey(name: 'name')
  @HiveField(2)
  String? name;

  @JsonKey(name: 'original_country')
  @HiveField(3)
  String? originalCountry;

  ProductionCompanies(this.id, this.logoPath, this.name, this.originalCountry);

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}
