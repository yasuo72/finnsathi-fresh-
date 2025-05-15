import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';
import 'home_actions.dart';
import 'notification_screen.dart';
import 'shop/shops_screen.dart';
import 'profile_screen.dart';
import 'statistics_screen.dart';
import 'wallet_screen.dart';
import '../widgets/animated_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _balanceVisible = false;

  final double totalBalance = 25000.50;
  final double income = 25000;
  final double outcome = 23500;
  final double febBudgetOutcome = 3480;
  final double febBudgetProgress = 0.8;
  final int febBudgetDaysLeft = 10;

  final List<Map<String, dynamic>> savings = [
    {"title": "iPhone 15 Pro", "amount": 116999.0, "progress": 0.7},
    {"title": "Macbook Air M2", "amount": 71499.0, "progress": 0.4},
  ];

  final List<Map<String, dynamic>> transactions = [
    {
      "title": "Netflix",
      "subtitle": "Subscription fee",
      "amount": "-₹149.00",
      "color": Colors.redAccent,
      "icon": Icons.play_circle_outline
    },
    {
      "title": "Jio",
      "subtitle": "Mobile Recharge",
      "amount": "-₹350.00",
      "color": Colors.redAccent,
      "icon": Icons.phone_android
    },
    {
      "title": "H&M",
      "subtitle": "Shopping fee",
      "amount": "-₹2,500.00",
      "color": Colors.redAccent,
      "icon": Icons.shopping_bag_outlined
    },
    {
      "title": "Parul University",
      "subtitle": "Salary",
      "amount": "+₹10,000.00",
      "color": Colors.green,
      "icon": Icons.account_balance
    },
  ];

  void _toggleBalance() => setState(() => _balanceVisible = !_balanceVisible);

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: null,
      body: _getSelectedPage(),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: (_selectedIndex == 0 || _selectedIndex == 1)
          ? AnimatedFAB(
        onAddExpense: () {}, // Add expense logic
        onAddIncome: () {}, // Add income logic
        onReceiptScanner: () {}, // Scanner logic
      )
          : null,
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return StatisticsScreen(
          onAddExpense: () {},
          onAddIncome: () {},
          onReceiptScanner: () {},
        );
      case 2:
        return const WalletScreen();
      case 3:
        return const ShopsScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const Center(child: Text('Page coming soon...'));
    }
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 18),
            _buildBalanceCard(),
            const SizedBox(height: 18),
            _buildIncomeOutcome(),
            const SizedBox(height: 18),
            _buildImageCard(),
            const SizedBox(height: 18),
            _buildBudgetCard(),
            const SizedBox(height: 18),
            _buildSavings(),
            const SizedBox(height: 18),
            _buildTransactions(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _onItemTapped(4),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning!', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  const Text('Rohit Singh', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF22223B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
              GestureDetector(
                onTap: () => HomeActions.onBalanceEyeTap(context, _toggleBalance),
                child: Icon(
                  _balanceVisible ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _balanceVisible ? '₹ ${totalBalance.toStringAsFixed(2)}' : '••••••••',
              key: ValueKey(_balanceVisible),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => HomeActions.onWalletTap(context),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: const [
                Icon(Icons.account_balance_wallet, color: Colors.white70, size: 18),
                SizedBox(width: 6),
                Text('My Wallet', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeOutcome() {
    return Row(
      children: [
        _buildFinanceCard(
          icon: Icons.arrow_downward,
          color: Colors.green,
          label: 'Income',
          value: income,
          onTap: () => HomeActions.onIncomeTap(context),
        ),
        const SizedBox(width: 12),
        _buildFinanceCard(
          icon: Icons.arrow_upward,
          color: Colors.redAccent,
          label: 'Outcome',
          value: outcome,
          onTap: () => HomeActions.onOutcomeTap(context),
        ),
      ],
    );
  }

  Widget _buildFinanceCard({required IconData icon, required Color color, required String label, required double value, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  Text('₹ ${value.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = constraints.maxWidth > 400 ? 140.0 : 110.0;
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
            height: imageHeight,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildBudgetCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('February budget', style: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.w500)),
              GestureDetector(
                onTap: () => HomeActions.onBudgetMoreTap(context),
                child: Text('More >', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('₹ ${febBudgetOutcome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text('outcome', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(value: febBudgetProgress, color: Colors.redAccent, backgroundColor: Colors.grey[300]),
              ),
              const SizedBox(width: 10),
              Text('$febBudgetDaysLeft days left', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSavings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Savings', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(savings.length, (i) {
            final item = savings[i];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < savings.length - 1 ? 12 : 0),
                child: InkWell(
                  onTap: () => HomeActions.onSavingsTap(context, item['title']),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('₹ ${item['amount'].toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(value: item['progress'], color: Colors.green, backgroundColor: Colors.grey[300]),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Transactions', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => HomeActions.onTransactionsMoreTap(context),
              child: Text('More >', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: transactions.map((t) => _transactionTile(t)).toList(),
        ),
      ],
    );
  }

  Widget _transactionTile(Map<String, dynamic> t) {
    return GestureDetector(
      onTap: () => HomeActions.onTransactionTap(context, t['title']),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 2),
        leading: CircleAvatar(
          backgroundColor: t['color'].withOpacity(0.1),
          child: Icon(t['icon'], color: t['color']),
        ),
        title: Text(t['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(t['subtitle']),
        trailing: Text(t['amount'], style: TextStyle(fontWeight: FontWeight.bold, color: t['color'])),
      ),
    );
  }
}
