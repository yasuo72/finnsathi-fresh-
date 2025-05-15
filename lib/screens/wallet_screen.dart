import 'package:flutter/material.dart';
// import '../widgets/animated_fab.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int selectedCard = 0;
  bool showRemoveDialog = false;
  bool showAddCard = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  List<Map<String, dynamic>> cards = [
    {
      'balance': '₹10,000.00',
      'number': '1234',
      'expiry': '12/25',
      'cvv': '348',
      'name': 'Priyanshu Singh',
      'type': 'debit',
    },
    {
      'balance': '₹15,000.50',
      'number': '6545',
      'expiry': '04/21',
      'cvv': '521',
      'name': 'Priyanshu Singh',
      'type': 'credit',
    },
  ];

  void removeCard() {
    setState(() {
      cards.removeAt(selectedCard);
      selectedCard = 0;
      showRemoveDialog = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Card removed!')),
    );
  }

  void addCard() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        cards.add({
          'balance': '₹${_balanceController.text}',
          'number': _numberController.text,
          'expiry': _expiryController.text,
          'cvv': _cvvController.text,
          'name': _nameController.text,
          'type': 'debit',
        });
        showAddCard = false;
        _balanceController.clear();
        _numberController.clear();
        _expiryController.clear();
        _cvvController.clear();
        _nameController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card added!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.black54),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // Add Card Button
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => setState(() => showAddCard = true),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, style: BorderStyle.solid, width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          child: Row(
                            children: const [
                              Icon(Icons.add, color: Colors.black),
                              SizedBox(width: 6),
                              Text('Add Card', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Cards list
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = constraints.maxWidth < 350 ? constraints.maxWidth * 0.9 : 300.0;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 16),
                        itemCount: cards.length,
                        itemBuilder: (context, i) {
                          final card = cards[i];
                          final isSelected = i == selectedCard;
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => setState(() => selectedCard = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(right: 16),
                              width: cardWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16),
                                border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).brightness == Brightness.dark ? Colors.black45 : Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0,2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Total Balance', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                        const SizedBox(height: 4),
                                        Text(card['balance'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(card['number'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8), fontSize: 12)),
                                            const Spacer(),
                                            Text(card['expiry'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8), fontSize: 12)),
                                            const Spacer(),
                                            Text(card['cvv'], style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12)),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(card['name'], style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
                                            const Spacer(),
                                            Text(card['type'] == 'debit' ? 'Debit' : 'Credit', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Remove icon
                                  if (isSelected)
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {
                                          setState(() => showRemoveDialog = true);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Ready to remove card!')),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(Icons.delete_outline, color: Colors.black, size: 20),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Remove card button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: cards.isNotEmpty ? () {
                      setState(() => showRemoveDialog = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Select a card to remove.')),
                      );
                    } : null,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: const Center(
                        child: Text('Remove a Card', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            // Remove dialog
            if (showRemoveDialog)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Container(
                      width: 310,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.delete, color: Colors.black, size: 48),
                          const SizedBox(height: 20),
                          const Text('Are you sure you want to remove this card? This action cannot be undone.',
                              style: TextStyle(fontSize: 15, color: Colors.black), textAlign: TextAlign.center),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: removeCard,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                ),
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () => setState(() => showRemoveDialog = false),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                ),
                                child: const Text('No'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            // Add Card dialog
            if (showAddCard)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => showAddCard = false),
                  child: Container(
                    color: Colors.black.withValues(alpha: 102),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          width: 340,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 24, offset: Offset(0, 8)),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F3FF),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(Icons.credit_card, color: Color(0xFF6C63FF), size: 40),
                                ),
                                const SizedBox(height: 18),
                                const Text('Add a new card',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                                const SizedBox(height: 18),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _balanceController,
                                        decoration: InputDecoration(
                                          labelText: 'Balance',
                                          prefixIcon: const Icon(Icons.wallet),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          filled: true,
                                          fillColor: const Color(0xFFF8F7FA),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter balance';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: _numberController,
                                        decoration: InputDecoration(
                                          labelText: 'Card Number',
                                          prefixIcon: const Icon(Icons.numbers),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          filled: true,
                                          fillColor: const Color(0xFFF8F7FA),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter card number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: _expiryController,
                                        decoration: InputDecoration(
                                          labelText: 'Expiry',
                                          prefixIcon: const Icon(Icons.calendar_today, size: 16),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          filled: true,
                                          fillColor: const Color(0xFFF8F7FA),
                                        ),
                                        keyboardType: TextInputType.datetime,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'MM/YY';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: _cvvController,
                                        decoration: InputDecoration(
                                          labelText: 'CVV',
                                          prefixIcon: const Icon(Icons.lock, size: 16),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                          filled: true,
                                          fillColor: const Color(0xFFF8F7FA),
                                        ),
                                        keyboardType: TextInputType.number,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'CVV';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Cardholder Name',
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                    filled: true,
                                    fillColor: const Color(0xFFF8F7FA),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: addCard,
                                      icon: const Icon(Icons.check),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF6C63FF),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                        elevation: 0,
                                      ),
                                      label: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () => setState(() => showAddCard = false),
                                      icon: const Icon(Icons.close, color: Colors.black),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                        elevation: 0,
                                      ),
                                      label: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
      // floatingActionButton: AnimatedFAB(
      //   onAddExpense: () {},
      //   onAddIncome: () {},
      //   onReceiptScanner: () {},
      // ),
    );
  }
}
