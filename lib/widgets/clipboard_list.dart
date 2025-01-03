// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../providers/clipboard_provider.dart';
// import '../models/clipboard_item.dart';
// import '../services/clipboard_monitor.dart';

// class ClipboardList extends ConsumerWidget {
//   const ClipboardList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(systemClipboardMonitorProvider);
//     final clipboardItems = ref.watch(clipboardStateProvider);

//     return clipboardItems.when(
//       data: (items) => ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ClipboardItemTile(item: item);
//         },
//       ),
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stack) => Center(
//         child: Text('Error: $error'),
//       ),
//     );
//   }
// }

// class ClipboardItemTile extends ConsumerWidget {
//   final ClipboardItem item;

//   const ClipboardItemTile({super.key, required this.item});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListTile(
//       leading: Icon(
//         item.type == ClipboardItemType.url ? Icons.link : Icons.text_fields,
//       ),
//       title: Text(
//         item.content,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       ),
//       subtitle: Text(
//         _formatTimestamp(item.timestamp),
//         style: Theme.of(context).textTheme.bodySmall,
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (item.isFavorite) const Icon(Icons.star, color: Colors.amber),
//           IconButton(
//             icon: Icon(
//               item.isFavorite ? Icons.star : Icons.star_border,
//             ),
//             onPressed: () {
//               ref.read(clipboardStateProvider.notifier).toggleFavorite(item.id);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete_outline),
//             onPressed: () {
//               ref
//                   .read(clipboardStateProvider.notifier)
//                   .deleteClipboardItem(item.id);
//             },
//           ),
//         ],
//       ),
//       onTap: () async {
//         if (item.type == ClipboardItemType.url) {
//           final url = Uri.parse(item.content);
//           if (await canLaunchUrl(url)) {
//             await launchUrl(url);
//           }
//         }
//         // Copy to clipboard
//         await Clipboard.setData(ClipboardData(text: item.content));
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Copied to clipboard'),
//             duration: Duration(seconds: 1),
//           ),
//         );
//       },
//     );
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/clipboard_provider.dart';
import '../models/clipboard_item.dart';
import '../services/clipboard_monitor.dart';

class ClipboardList extends ConsumerWidget {
  const ClipboardList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize clipboard monitor
    ref.watch(systemClipboardMonitorProvider);
    final clipboardItems = ref.watch(clipboardStateProvider);

    return clipboardItems.when(
      data: (items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ClipboardItemTile(item: item);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}

class ClipboardItemTile extends ConsumerWidget {
  final ClipboardItem item;

  const ClipboardItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(
        item.type == ClipboardItemType.url ? Icons.link : Icons.text_fields,
      ),
      title: Text(
        item.content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _formatTimestamp(item.timestamp),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.isFavorite) const Icon(Icons.star, color: Colors.amber),
          IconButton(
            icon: Icon(
              item.isFavorite ? Icons.star : Icons.star_border,
            ),
            onPressed: () {
              ref.read(clipboardStateProvider.notifier).toggleFavorite(item.id);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              ref
                  .read(clipboardStateProvider.notifier)
                  .deleteClipboardItem(item.id);
            },
          ),
        ],
      ),
      onTap: () async {
        if (item.type == ClipboardItemType.url) {
          final url = Uri.parse(item.content);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        }
        // Copy to clipboard
        await Clipboard.setData(ClipboardData(text: item.content));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard'),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
