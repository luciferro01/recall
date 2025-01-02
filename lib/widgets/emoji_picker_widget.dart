// import 'package:flutter/material.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EmojiPickerWidget extends ConsumerStatefulWidget {
//   final Config config;
//   final EmojiPickerState state;
//   final bool showSearchBar;
//   final TextEditingController searchController;
//   final int? categoryIndex;

//   const EmojiPickerWidget(
//     this.categoryIndex, {
//     Key? key,
//     required this.config,
//     required this.state,
//     required this.showSearchBar,
//     required this.searchController,
//   }) : super(key: key);

//   @override
//   ConsumerState<EmojiPickerWidget> createState() => _EmojiPickerWidgetState();
// }

// class _EmojiPickerWidgetState extends ConsumerState<EmojiPickerWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<String> recentEmojis = [];
//   final int maxRecentEmojis = 20;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: Category.values.length,
//       vsync: this,
//       // initialIndex: widget.state.categoryIndex ?? 0,
//       initialIndex: widget.categoryIndex ?? 0,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (widget.showSearchBar)
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SearchBar(
//               controller: widget.searchController,
//               hintText: 'Search emojis...',
//               leading: const Icon(Icons.search),
//             ),
//           ),
//         TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           tabs: Category.values.map((category) {
//             return Tab(
//               icon: Icon(_getCategoryIcon(category)),
//               text: _getCategoryName(category),
//             );
//           }).toList(),
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: Category.values.map((category) {
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 8,
//                   childAspectRatio: 1.0,
//                 ),
//                 itemCount: widget.state.getEmojis(category).length,
//                 itemBuilder: (context, index) {
//                   final emoji = widget.state.getEmojis(category)[index];
//                   return InkWell(
//                     onTap: () => _onEmojiSelected(emoji),
//                     child: Center(
//                       child: Text(
//                         emoji.emoji,
//                         style: const TextStyle(fontSize: 24),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }

//   IconData _getCategoryIcon(Category category) {
//     switch (category) {
//       case Category.RECENT:
//         return Icons.access_time;
//       case Category.SMILEYS:
//         return Icons.emoji_emotions;
//       case Category.ANIMALS:
//         return Icons.pets;
//       case Category.FOODS:
//         return Icons.fastfood;
//       case Category.ACTIVITIES:
//         return Icons.sports_basketball;
//       case Category.TRAVEL:
//         return Icons.flight;
//       case Category.OBJECTS:
//         return Icons.lightbulb;
//       case Category.SYMBOLS:
//         return Icons.euro_symbol;
//       case Category.FLAGS:
//         return Icons.flag;
//       default:
//         return Icons.emoji_emotions;
//     }
//   }

//   String _getCategoryName(Category category) {
//     return category.toString().split('.').last.capitalize();
//   }

//   void _onEmojiSelected(Emoji emoji) {
//     setState(() {
//       if (!recentEmojis.contains(emoji.emoji)) {
//         if (recentEmojis.length >= maxRecentEmojis) {
//           recentEmojis.removeLast();
//         }
//         recentEmojis.insert(0, emoji.emoji);
//       }
//     });
//     // Handle emoji selection
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
//   }
// }
