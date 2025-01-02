import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import '../models/clipboard_item.dart';

part 'clipboard_service.g.dart';

@Riverpod(keepAlive: true)
class ClipboardService extends _$ClipboardService {
  late Box<ClipboardItem> _clipboardBox;

  @override
  Future<ClipboardService> build() async {
    _clipboardBox = await Hive.openBox<ClipboardItem>('clipboard_items');
    return this;
  }

  Future<void> addClipboardItem(ClipboardItem item) async {
    await _clipboardBox.put(item.id, item);
  }

  Future<List<ClipboardItem>> fetchClipboardItems() async {
    return _clipboardBox.values.toList();
  }

  Future<void> deleteClipboardItem(String id) async {
    await _clipboardBox.delete(id);
  }

  Future<void> deleteAllClipboardItems() async {
    await _clipboardBox.clear();
  }

  Future<void> toggleFavorite(String id) async {
    final item = _clipboardBox.get(id);
    if (item != null) {
      final updatedItem = item.copyWith(isFavorite: !item.isFavorite);
      await _clipboardBox.put(id, updatedItem);
    }
  }
}
