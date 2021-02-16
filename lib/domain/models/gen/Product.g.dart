// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 2;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      productName: fields[0] as String,
      description: fields[1] as String,
      productId: fields[2] as String,
      price: fields[3] as num,
      quantity: fields[4] as int,
      imageUrl: fields[5] as String,
      category: fields[6] as String,
      subcategory: fields[7] as String,
      weight: fields[8] as num,
      measureUnit: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.subcategory)
      ..writeByte(8)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.measureUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
