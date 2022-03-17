import 'package:json_annotation/json_annotation.dart';

part 'seating_type_vo.g.dart';

@JsonSerializable()
class SeatinTypeVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'seat_name')
  String? seatName;

  @JsonKey(name: 'symbol')
  String? symbol;

  @JsonKey(name: 'price')
  int? price;

  bool isSelect;

  SeatinTypeVO(this.id, this.type, this.seatName, this.symbol, this.price,
      {this.isSelect = false});

  factory SeatinTypeVO.fromJson(Map<String, dynamic> json) =>
      _$SeatinTypeVOFromJson(json);

  Map<String, dynamic> toJson() => _$SeatinTypeVOToJson(this);

  @override
  String toString() {
    return 'SeatinTypeVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price, isSelect: $isSelect}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatinTypeVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          seatName == other.seatName &&
          symbol == other.symbol &&
          price == other.price &&
          isSelect == other.isSelect;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      seatName.hashCode ^
      symbol.hashCode ^
      price.hashCode ^
      isSelect.hashCode;
}
