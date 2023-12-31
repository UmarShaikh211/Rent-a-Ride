// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingStatusAdapter extends TypeAdapter<BookingStatus> {
  @override
  final int typeId = 0;

  @override
  BookingStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingStatus(
      carid: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      datetime: fields[3] as String,
      bookingStatus: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookingStatus obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.carid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.datetime)
      ..writeByte(4)
      ..write(obj.bookingStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoriteCarAdapter extends TypeAdapter<FavoriteCar> {
  @override
  final int typeId = 1;

  @override
  FavoriteCar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCar(
      name: fields[0] as String,
      image: fields[1] as String,
      location: fields[2] as String,
      trans: fields[3] as String,
      price: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCar obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.trans)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
