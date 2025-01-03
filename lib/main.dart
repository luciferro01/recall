import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:recall/screens/home_screen.dart';
import 'package:yaru/yaru.dart';
import 'models/clipboard_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(ClipboardItemAdapter());
  Hive.registerAdapter(ClipboardItemTypeAdapter());

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    skipTaskbar: false,
    title: 'Clipboard Manager',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await hotKeyManager.unregisterAll();
  // await hotKeyManager.register(
  //   HotKey(
  //     KeyCode.keyV,
  //     modifiers: [KeyModifier.meta],
  //   ),
  //   keyDownHandler: (hotKey) {
  //     // Show the app window when Win+V is pressed
  //     windowManager.show();
  //   },
  // )
  await hotKeyManager.register(
    HotKey(
      key: PhysicalKeyboardKey.keyV,
      modifiers: [HotKeyModifier.meta],
    ),
    keyDownHandler: (hotKey) {
      // Show the app window when Win+V is pressed
      windowManager.show();
    },
  );

  runApp(
    const ProviderScope(
      child: ClipboardManagerApp(),
    ),
  );

  // Initialize tray manager
  await trayManager.setIcon('assets/icon.png');
  await trayManager.setContextMenu(Menu(
    items: [
      MenuItem(
        key: 'show',
        label: 'Show',
      ),
      MenuItem(
        key: 'exit',
        label: 'Exit',
      ),
    ],
  ));

  trayManager.addListener(TrayListenerClass());
}

class ClipboardManagerApp extends StatelessWidget {
  const ClipboardManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: yaruLight,
      darkTheme: yaruDark,
      home: const HomeScreen(),
    );
  }
}

class TrayListenerClass extends TrayListener {
  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'show':
        windowManager.show();
        break;
      case 'exit':
        windowManager.close();
        break;
    }
  }
}
