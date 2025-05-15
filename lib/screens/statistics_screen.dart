import 'package:flutter/material.dart';
import '../widgets/animated_fab.dart';
import 'ai_chat_screen.dart';
import 'receipt_scanner_screen.dart';

class StatisticsScreen extends StatefulWidget {
  final void Function()? onAddExpense;
  final void Function()? onAddIncome;
  final void Function()? onReceiptScanner;
  const StatisticsScreen({
    super.key,
    this.onAddExpense,
    this.onAddIncome,
    this.onReceiptScanner,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int tabIndex = 0;
  int monthTabIndex = 1; // Feb

  // Dynamic data for logic prep
  double income = 25000.50;
  double outcome = 23500.00;
  double savings = 9100.00;
  double monthlySpent = 3480.00;
  double monthlyBudget = 5000.00;
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  List<Map<String, dynamic>> moneyGoes = [
    {
      'title': 'House Rent',
      'percent': '45%',
      'icon': Icons.home,
      'amount': '-₹1566.00',
      'bg': Color(0xFFB8B6F8),
      'fg': Color(0xFF6051C7),
    },
    {
      'title': 'Transport',
      'percent': '20%',
      'icon': Icons.directions_bus,
      'amount': '-₹696.00',
      'bg': Color(0xFFB8F8E1),
      'fg': Color(0xFF51C7A5),
    },
    {
      'title': 'Food',
      'percent': '19%',
      'icon': Icons.fastfood,
      'amount': '-₹601.20',
      'bg': Color(0xFFF8E1B8),
      'fg': Color(0xFFC7A151),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Statistics',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black54,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // Tabs
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                  child: Row(
                    children: [
                      _tabBtn('Daily', 0),
                      _tabBtn('Monthly', 1),
                      _tabBtn('Yearly', 2),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AiChatScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                        ),
                        label: Text(
                          'AI Chat',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          elevation: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                // Month selector (for monthly tab)
                if (tabIndex == 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(months.length, (i) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            setState(() => monthTabIndex = i);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selected month: ${months[i]}'),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  monthTabIndex == i
                                      ? Colors.black
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              months[i],
                              style: TextStyle(
                                color:
                                    monthTabIndex == i
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                // Chart
                LayoutBuilder(
                  builder: (context, constraints) {
                    final chartHeight =
                        constraints.maxWidth < 400 ? 140.0 : 160.0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: chartHeight,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color:
                                tabIndex == 0
                                    ? const Color(0xFFB8D8FF)
                                    : Colors.transparent,
                            width: tabIndex == 0 ? 2 : 0,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Dummy chart lines
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CustomPaint(
                                  painter: _DummyChartPainter(),
                                ),
                              ),
                            ),
                            // Chart legend
                            Positioned(
                              left: 18,
                              bottom: 10,
                              child: Row(
                                children: [
                                  _ChartLegend(
                                    color: Color(0xFF3DC47E),
                                    label: 'Income',
                                    value: '₹ ${income.toStringAsFixed(2)}',
                                  ),
                                  SizedBox(width: 18),
                                  _ChartLegend(
                                    color: Color(0xFFFF6A6A),
                                    label: 'Outcome',
                                    value: '₹ ${outcome.toStringAsFixed(2)}',
                                  ),
                                  SizedBox(width: 18),
                                  _ChartLegend(
                                    color: Color(0xFFFFB43C),
                                    label: 'Savings',
                                    value: '₹ ${savings.toStringAsFixed(2)}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Monthly budget
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Monthly budget',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '₹ ${monthlySpent.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Color(0xFF3862F8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' / ₹ ${monthlyBudget.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.black54),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${((monthlySpent / monthlyBudget) * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: Color(0xFF3862F8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Daily budget was : (₹150 - 180) Saved ₹${(monthlyBudget - monthlySpent).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Most of money goes to
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Most of money goes to',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(moneyGoes.length, (i) {
                        final item = moneyGoes[i];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: i < moneyGoes.length - 1 ? 10 : 0,
                          ),
                          child: Card(
                            color: Theme.of(context).cardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: item['fg'],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      item['icon'],
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['title'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              item['amount'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFF6A6A),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: item['fg'].withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: FractionallySizedBox(
                                                alignment: Alignment.centerLeft,
                                                widthFactor:
                                                    double.tryParse(
                                                      item['percent']
                                                          .replaceAll('%', ''),
                                                    )! /
                                                    100,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: item['fg'],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              item['percent'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: item['fg'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedFAB(
        onAddExpense: widget.onAddExpense,
        onAddIncome: widget.onAddIncome,
        onReceiptScanner: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ReceiptScannerScreen(),
            ),
          );
        },
        onAiChat: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AiChatScreen()));
        },
      ),
    );
  }

  Widget _tabBtn(String label, int idx) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() => tabIndex = idx);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Tab switched: $label')));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color:
                    tabIndex == idx ? const Color(0xFF3862F8) : Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 2.4,
              width: 28,
              color:
                  tabIndex == idx
                      ? const Color(0xFF3862F8)
                      : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _moneyCard(
    String title,
    String percent,
    IconData icon,
    String amount,
    Color bg,
    Color fg,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: fg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6A6A),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 5,
                      decoration: BoxDecoration(
                        color: fg.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor:
                            double.tryParse(percent.replaceAll('%', ''))! / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: fg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      percent,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _ChartLegend({
    required this.color,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _DummyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintIncome =
        Paint()
          ..color = const Color(0xFF3DC47E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final paintOutcome =
        Paint()
          ..color = const Color(0xFFFF6A6A)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final paintSavings =
        Paint()
          ..color = const Color(0xFFFFB43C)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final pointsIncome = [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width, size.height * 0.2),
    ];
    final pointsOutcome = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.8),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.7),
      Offset(size.width, size.height * 0.4),
    ];
    final pointsSavings = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.7),
      Offset(size.width * 0.8, size.height * 0.6),
      Offset(size.width, size.height * 0.8),
    ];

    _drawLine(canvas, pointsIncome, paintIncome);
    _drawLine(canvas, pointsOutcome, paintOutcome);
    _drawLine(canvas, pointsSavings, paintSavings);
  }

  void _drawLine(Canvas canvas, List<Offset> points, Paint paint) {
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (final p in points.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
