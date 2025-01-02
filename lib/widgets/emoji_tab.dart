import 'dart:math';

import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart';
import 'package:recall/widgets/emoji_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmojiTab extends StatefulWidget {
  const EmojiTab({super.key});

  @override
  State<EmojiTab> createState() => _EmojiTabState();
}

class _EmojiTabState extends State<EmojiTab> {
  List<String> recentEmojis = [];
  final int maxRecentEmojis = 20;

  @override
  void initState() {
    super.initState();
    _loadRecentEmojis();
  }

  Future<void> _loadRecentEmojis() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentEmojis = prefs.getStringList('recent_emojis') ?? [];
    });
  }

  Future<void> _saveRecentEmojis() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recent_emojis', recentEmojis);
  }

  void _onEmojiSelected(String emoji) async {
    // Add to recent emojis
    setState(() {
      recentEmojis.remove(emoji);
      recentEmojis.insert(0, emoji);
      if (recentEmojis.length > maxRecentEmojis) {
        recentEmojis = recentEmojis.sublist(0, maxRecentEmojis);
      }
    });
    await _saveRecentEmojis();

    // Copy to clipboard
    await Clipboard.setData(ClipboardData(text: emoji));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emoji copied to clipboard'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (recentEmojis.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recently Used',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: recentEmojis.map((emoji) {
                    return InkWell(
                      onTap: () => _onEmojiSelected(emoji),
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
        Expanded(
          child: EmojiPicker(
            // config: Config(),
            onEmojiSelected: (category, emoji) {
              _onEmojiSelected(emoji.emoji);
            },
            // customWidget: (config, state, showSearchBar) {
            //   // return EmojiPickerWidget(
            //   //   config: Config(),
            //   //   showSearchBar: true,
            //   // );
            // },
          ),
        ),
      ],
    );
  }
}
