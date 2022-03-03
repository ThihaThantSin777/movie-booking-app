import 'package:json_annotation/json_annotation.dart';

part 'checkout_snack_vo.g.dart';

@JsonSerializable()
class CheckoutSnackVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'price')
  int? price;

  @JsonKey(name: 'unit_price')
  int? unitPrice;

  @JsonKey(name: 'quantity')
  int? quantity;

  @JsonKey(name: 'total_price')
  int? totalPrice;

  CheckoutSnackVO(this.id, this.name, this.description, this.image, this.price,
      this.unitPrice, this.quantity, this.totalPrice);

  factory CheckoutSnackVO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSnackVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutSnackVOToJson(this);
}
