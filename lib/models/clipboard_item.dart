// import 'package:uuid/uuid.dart';

// class ClipboardItem {
//   final String id;
//   final String content;
//   final DateTime timestamp;
//   final ClipboardItemType type;
//   final bool isFavorite;
//   final bool isPrivate;

//   ClipboardItem({
//     String? id,
//     required this.content,
//     required this.type,
//     this.isFavorite = false,
//     this.isPrivate = false,
//   })  : id = id ?? const Uuid().v4(),
//         timestamp = DateTime.now();

//   ClipboardItem copyWith({
//     String? content,
//     ClipboardItemType? type,
//     bool? isFavorite,
//     bool? isPrivate,
//   }) {
//     return ClipboardItem(
//       id: id,
//       content: content ?? this.content,
//       type: type ?? this.type,
//       isFavorite: isFavorite ?? this.isFavorite,
//       isPrivate: isPrivate ?? this.isPrivate,
//     );
//   }
// }

// enum ClipboardItemType {
//   text,
//   url,
//   emoji,
//   image,
//   file,
// }

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'clipboard_item.g.dart';

@HiveType(typeId: 0)
class ClipboardItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final ClipboardItemType type;

  @HiveField(4)
  final bool isFavorite;

  @HiveField(5)
  final bool isPrivate;

  ClipboardItem({
    String? id,
    required this.content,
    required this.type,
    this.isFavorite = false,
    this.isPrivate = false,
  })  : id = id ?? const Uuid().v4(),
        timestamp = DateTime.now();

  ClipboardItem copyWith({
    String? content,
    ClipboardItemType? type,
    bool? isFavorite,
    bool? isPrivate,
  }) {
    return ClipboardItem(
      id: id,
      content: content ?? this.content,
      type: type ?? this.type,
      isFavorite: isFavorite ?? this.isFavorite,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}

@HiveType(typeId: 1)
enum ClipboardItemType {
  @HiveField(0)
  text,

  @HiveField(1)
  url,

  @HiveField(2)
  emoji,

  @HiveField(3)
  image,

  @HiveField(4)
  file,
}
