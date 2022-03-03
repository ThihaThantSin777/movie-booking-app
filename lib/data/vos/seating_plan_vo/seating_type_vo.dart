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
}
