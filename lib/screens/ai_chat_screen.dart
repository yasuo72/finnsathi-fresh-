import 'package:flutter/material.dart';

import 'chats/ChatDetailScreen.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({Key? key}) : super(key: key);

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> with TickerProviderStateMixin {
  int selectedTab = 0;

  late final List<List<Map<String, dynamic>>> chatData;

  @override
  void initState() {
    super.initState();

    chatData = [
      [ // AI
        {
          'icon': Icons.notifications_active_outlined,
          'color': Color(0xFFFFB800),
          'title': 'How to bulk faster?',
          'subtitle': '8 new messages from Uplift.ai',
          'badge': '4+'
        },
        {
          'icon': Icons.fitness_center,
          'color': Color(0xFFFF7300),
          'title': 'Optimal Fitness Sch...',
          'subtitle': 'Uplift Score is 87'
        },
      ],
      [ // Archived
        {
          'icon': Icons.bookmark,
          'color': Colors.grey,
          'title': 'Old Saved Chat',
          'subtitle': 'Archived info here'
        },
      ],
      [ // Deleted
        {
          'icon': Icons.delete_outline,
          'color': Colors.redAccent,
          'title': 'Deleted Query',
          'subtitle': 'Removed item preview'
        },
      ],
    ];
  }

  void onTabChange(int index) {
    if (index != selectedTab) {
      setState(() {
        selectedTab = index;
      });
    }
  }

  void onSeeAll() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('See all tapped for ${['AI', 'Archived', 'Deleted'][selectedTab]}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentChats = chatData[selectedTab];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF23232E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 38,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'My AI Chats',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _TabButton(label: 'AI', selected: selectedTab == 0, onTap: () => onTabChange(0)),
                      const SizedBox(width: 20),
                      _TabButton(label: 'Archived', selected: selectedTab == 1, onTap: () => onTabChange(1)),
                      const SizedBox(width: 20),
                      _TabButton(label: 'Deleted', selected: selectedTab == 2, onTap: () => onTabChange(2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(['Earlier Today', 'Archived Chats', 'Deleted Chats'][selectedTab],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text('See all', style: TextStyle(color: Color(0xFFFF7300), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: ListView.builder(
                  key: ValueKey(selectedTab),
                  itemCount: currentChats.length,
                  itemBuilder: (context, index) {
                    final chat = currentChats[index];
                    return _ChatTile(
                      icon: chat['icon'],
                      iconBg: chat['color'],
                      title: chat['title'],
                      subtitle: chat['subtitle'],
                      badge: chat['badge'],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withOpacity(0.10) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(selected ? 1 : 0.7),
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String? badge;

  const _ChatTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(
              title: title,
              subtitle: subtitle,
              icon: icon,
              iconBg: iconBg,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                if (badge != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(badge!, style: const TextStyle(color: Color(0xFFFF7300), fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  )
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
