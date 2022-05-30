import 'package:movie_booking_app/data/vos/user_vo/card_vo.dart';

class SelectCardVO{
  bool ?isSelect;
  CardVO ?cardVO;
  SelectCardVO.normal();
  SelectCardVO(this.isSelect, this.cardVO);

  @override
  String toString() {
    return 'SelectCardVO{isSelect: $isSelect, cardVO: $cardVO}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectCardVO &&
          runtimeType == other.runtimeType &&
          isSelect == other.isSelect &&
          cardVO == other.cardVO;

  @override
  int get hashCode => isSelect.hashCode ^ cardVO.hashCode;
}