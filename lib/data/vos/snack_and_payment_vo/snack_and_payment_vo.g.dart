// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_and_payment_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackAndPaymentVOAdapter extends TypeAdapter<SnackAndPaymentVO> {
  @override
  final int typeId = 10;

  @override
  SnackAndPaymentVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnackAndPaymentVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as int?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SnackAndPaymentVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackAndPaymentVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackAndPaymentVO _$SnackAndPaymentVOFromJson(Map<String, dynamic> json) =>
    SnackAndPaymentVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['image'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$SnackAndPaymentVOToJson(SnackAndPaymentVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'quantity': instance.quantity,
      'isSelect': instance.isSelect,
    };
