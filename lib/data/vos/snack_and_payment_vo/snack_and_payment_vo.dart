import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'snack_and_payment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_SNACK_VO)
class SnackAndPaymentVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;

  @JsonKey(name: 'description')
  @HiveField(2)
  String? description;

  @JsonKey(name: 'price')
  @HiveField(3)
  int? price;

  @JsonKey(name: 'image')
  @HiveField(4)
  String? image;

  int quantity;

  bool isSelect;

  SnackAndPaymentVO(
      this.id, this.name, this.description, this.price, this.image,
      {this.quantity = 0, this.isSelect = false});

  factory SnackAndPaymentVO.fromJson(Map<String, dynamic> json) =>
      _$SnackAndPaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackAndPaymentVOToJson(this);

  @override
  String toString() {
    return 'SnackAndPaymentVO{id: $id, name: $name, description: $description, price: $price, image: $image, quantity: $quantity, isSelect: $isSelect}';
  }


}
