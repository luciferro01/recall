import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/clipboard_provider.dart';
import '../widgets/clipboard_list.dart';
import '../widgets/emoji_tab.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recall'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Clipboard 📋'),
              Tab(text: 'Emojis 😀'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Clear all items',
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear all items?'),
                    content: const Text(
                      'This will delete all clipboard items except favorites.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(clipboardStateProvider.notifier)
                              .deleteAllClipboardItems();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            ClipboardList(),
            EmojiTab(),
          ],
        ),
      ),
    );
  }
}
