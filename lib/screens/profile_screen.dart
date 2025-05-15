import 'package:flutter/material.dart';
import 'settings_screen.dart';
import '../main.dart'; // Assuming this contains FinsaathiAppState
import 'home_screen.dart'; // Replace with your actual HomeScreen import

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = 'Priyanshu Singh';
    String userLevel = 'Level 4 Ace Member';
    double progress = 0.85;
    String progressPercent = '85%';
    String nextLevel = 'lv 5';
    String avatarUrl = 'https://randomuser.me/api/portraits/men/32.jpg';
    int transactions = 1200;
    int points = 726;
    int rank = 8;

    List<Map<String, dynamic>> actions = [
      {'icon': Icons.receipt_long, 'title': 'All Transactions'},
      {'icon': Icons.error_outline, 'title': 'Pending Transactions'},
      {'icon': Icons.access_time, 'title': 'Refund status'},
      {'icon': Icons.report_problem_outlined, 'title': 'Raise an issue'},
      {'icon': Icons.favorite_border, 'title': 'Help and Support'},
      {'icon': Icons.info_outline, 'title': 'About Us'},
      {'icon': Icons.description_outlined, 'title': 'Terms and Conditions'},
      {'icon': Icons.feedback_outlined, 'title': 'Feedback'},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Modern Back Button & Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen()), // Replace with your HomeScreen widget
                              (route) => false,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Theme.of(context).colorScheme.primary, size: 20),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black26 : Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundImage: NetworkImage(avatarUrl),
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 6),
                              Text(userLevel, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary)),
                              const SizedBox(height: 6),
                              Stack(
                                children: [
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    width: 120 * progress,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('$progressPercent to $nextLevel', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(transactions.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, fontSize: 18)),
                            SizedBox(height: 2),
                            Text('Transactions', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(points.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary, fontSize: 18)),
                            SizedBox(height: 2),
                            Text('Points', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                          ],
                        ),
                        Column(
                          children: [
                            Text(rank.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface, fontSize: 18)),
                            SizedBox(height: 2),
                            Text('Rank', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F3FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Explore tapped!')),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  Icon(Icons.explore, size: 18, color: Color(0xFF6C63FF)),
                                  SizedBox(width: 2),
                                  Text('Explore', style: TextStyle(fontSize: 13, color: Color(0xFF6C63FF))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Edit Profile tapped!')),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text('Edit Profile', style: TextStyle(fontSize: 11, color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SettingsScreen(
                                    onThemeChanged: (val) {
                                      final state = context.findRootAncestorStateOfType<FinsaathiAppState>();
                                      state?.toggleDarkMode(val);
                                    },
                                    isDarkMode: Theme.of(context).brightness == Brightness.dark,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.settings, size: 16, color: Colors.black54),
                                  SizedBox(width: 4),
                                  Text('Settings', style: TextStyle(fontSize: 11, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Share tapped!')),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share, size: 16, color: Colors.black54),
                                  SizedBox(width: 4),
                                  Text('Share', style: TextStyle(fontSize: 11, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions List
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black26 : Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(actions.length, (i) {
                    final action = actions[i];
                    return ListTile(
                      leading: Icon(action['icon'], color: Theme.of(context).colorScheme.primary),
                      title: Text(action['title'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped: ' + action['title'])),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
