import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recall/models/clipboard_item.dart';
import 'package:recall/providers/clipboard_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class ClipboardSearchBar extends ConsumerWidget {
  const ClipboardSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

// Add this to the top of clipboard_provider.dart
final filteredClipboardItemsProvider =
    Provider<AsyncValue<List<ClipboardItem>>>((ref) {
  final items = ref.watch(clipboardStateProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return items.whenData((items) {
    if (searchQuery.isEmpty) return items;
    return items
        .where((item) => item.content.toLowerCase().contains(searchQuery))
        .toList();
  });
});
