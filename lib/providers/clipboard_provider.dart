import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/clipboard_item.dart';
import '../services/clipboard_service.dart';

part 'clipboard_provider.g.dart';

@riverpod
class ClipboardState extends _$ClipboardState {
  late final ClipboardService _clipboardService;

  @override
  Future<List<ClipboardItem>> build() async {
    _clipboardService = await ClipboardService().build();
    return _clipboardService.fetchClipboardItems();
  }

  Future<void> addClipboardItem(ClipboardItem item) async {
    await _clipboardService.addClipboardItem(item);
    state = AsyncValue.data(await _clipboardService.fetchClipboardItems());
  }

  Future<void> deleteClipboardItem(String id) async {
    await _clipboardService.deleteClipboardItem(id);
    state = AsyncValue.data(await _clipboardService.fetchClipboardItems());
  }

  Future<void> deleteAllClipboardItems() async {
    await _clipboardService.deleteAllClipboardItems();
    state = AsyncValue.data(await _clipboardService.fetchClipboardItems());
  }

  Future<void> toggleFavorite(String id) async {
    await _clipboardService.toggleFavorite(id);
    state = AsyncValue.data(await _clipboardService.fetchClipboardItems());
  }
}
