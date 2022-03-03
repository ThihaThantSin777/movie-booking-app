import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'production_countries.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_PRODUCTION_COUNTRIES)
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  @HiveField(0)
  String? iso31661;

  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;

  ProductionCountries(this.iso31661, this.name);

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}
