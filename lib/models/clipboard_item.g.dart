// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipboardItemAdapter extends TypeAdapter<ClipboardItem> {
  @override
  final int typeId = 0;

  @override
  ClipboardItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClipboardItem(
      id: fields[0] as String?,
      content: fields[1] as String,
      type: fields[3] as ClipboardItemType,
      isFavorite: fields[4] as bool,
      isPrivate: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ClipboardItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.isPrivate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipboardItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClipboardItemTypeAdapter extends TypeAdapter<ClipboardItemType> {
  @override
  final int typeId = 1;

  @override
  ClipboardItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClipboardItemType.text;
      case 1:
        return ClipboardItemType.url;
      case 2:
        return ClipboardItemType.emoji;
      case 3:
        return ClipboardItemType.image;
      case 4:
        return ClipboardItemType.file;
      default:
        return ClipboardItemType.text;
    }
  }

  @override
  void write(BinaryWriter writer, ClipboardItemType obj) {
    switch (obj) {
      case ClipboardItemType.text:
        writer.writeByte(0);
        break;
      case ClipboardItemType.url:
        writer.writeByte(1);
        break;
      case ClipboardItemType.emoji:
        writer.writeByte(2);
        break;
      case ClipboardItemType.image:
        writer.writeByte(3);
        break;
      case ClipboardItemType.file:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipboardItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
