import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recall/models/clipboard_item.dart';
import 'package:recall/screens/home_screen.dart';
import 'package:yaru/yaru.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(ClipboardItemAdapter());
  Hive.registerAdapter(ClipboardItemTypeAdapter());

  // Initialize window manager
  await windowManager.ensureInitialized();
  await hotKeyManager.unregisterAll();

  // Configure window properties
  await windowManager.setSize(const Size(600, 600));
  await windowManager.setMinimumSize(const Size(30, 400));

  // Register global hotkey (Win + V)
  await hotKeyManager.register(
    HotKey(
      key: LogicalKeyboardKey.keyV,
      // key: PhysicalKeyboardKey.keyV,
      modifiers: [HotKeyModifier.meta],
      scope: HotKeyScope.system,
    ),
    keyDownHandler: (_) async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recall',
      theme: yaruLight,
      darkTheme: yaruDark,
      home: const HomeScreen(),
    );
  }
}
