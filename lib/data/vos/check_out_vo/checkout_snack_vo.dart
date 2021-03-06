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

  @override
  String toString() {
    return 'CheckoutSnackVO{id: $id, name: $name, description: $description, image: $image, price: $price, unitPrice: $unitPrice, quantity: $quantity, totalPrice: $totalPrice}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckoutSnackVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          image == other.image &&
          price == other.price &&
          unitPrice == other.unitPrice &&
          quantity == other.quantity &&
          totalPrice == other.totalPrice;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      price.hashCode ^
      unitPrice.hashCode ^
      quantity.hashCode ^
      totalPrice.hashCode;
}
