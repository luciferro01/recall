// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../models/clipboard_item.dart';
// import '../providers/clipboard_provider.dart';

// part 'clipboard_monitor.g.dart';

// @riverpod
// class SystemClipboardMonitor extends _$SystemClipboardMonitor {
//   Timer? _pollingTimer;
//   String? _lastCopiedText;

//   @override
//   void build() {
//     _startMonitoring();
//     ref.onDispose(() {
//       _pollingTimer?.cancel();
//     });
//   }

//   void _startMonitoring() {
//     _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _checkClipboard();
//     });
//   }

//   Future<void> _checkClipboard() async {
//     final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
//     final text = clipboardData?.text;

//     if (text != null && text != _lastCopiedText) {
//       _lastCopiedText = text;

//       final clipboardItem = ClipboardItem(
//         content: text,
//         type: Uri.tryParse(text)?.hasScheme == true
//             ? ClipboardItemType.url
//             : ClipboardItemType.text,
//       );

//       await ref
//           .read(clipboardStateProvider.notifier)
//           .addClipboardItem(clipboardItem);
//     }
//   }
// }

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/clipboard_item.dart';
import '../providers/clipboard_provider.dart';

part 'clipboard_monitor.g.dart';

@riverpod
class SystemClipboardMonitor extends _$SystemClipboardMonitor {
  Timer? _pollingTimer;
  String? _lastCopiedText;

  @override
  void build() {
    _startMonitoring();
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });
  }

  void _startMonitoring() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _checkClipboard();
    });
  }

  Future<void> _checkClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clipboardData?.text;

    if (text != null && text != _lastCopiedText) {
      _lastCopiedText = text;

      final clipboardItem = ClipboardItem(
        content: text,
        type: Uri.tryParse(text)?.hasScheme == true
            ? ClipboardItemType.url
            : ClipboardItemType.text,
      );

      await ref
          .read(clipboardStateProvider.notifier)
          .addClipboardItem(clipboardItem);
    }
  }
}
