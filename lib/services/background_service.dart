import 'dart:async';
import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import '../models/clipboard_item.dart';
import '../providers/clipboard_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_service.g.dart';

@Riverpod(keepAlive: true)
BackgroundService backgroundService(Ref ref) {
  return BackgroundService(ref);
}

class BackgroundService {
  final Ref _ref;
  Timer? _pollingTimer;
  String? _lastCopiedText;
  final bool _isPrivateMode = false;

  BackgroundService(this._ref) {
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkClipboard();
    });
  }

  Future<void> _checkClipboard() async {
    if (_isPrivateMode) return;

    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clipboardData?.text;

    if (text != null && text != _lastCopiedText) {
      _lastCopiedText = text;
      final clipboardItem = ClipboardItem(
        content: text,
        type: ClipboardItemType.text,
      );
      await _ref
          .read(clipboardStateProvider.notifier)
          .addClipboardItem(clipboardItem);
    }
  }

  void dispose() {
    _pollingTimer?.cancel();
  }
}
