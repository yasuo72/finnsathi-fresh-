import 'package:flutter/material.dart';
import '../../models/shop_models.dart';
import 'shop_menu_screen.dart';

// Hardcoded data for backend prep
final String defaultShopImageUrl = 'https://img.icons8.com/ios-filled/100/000000/shop.png';
final String defaultProfileImageUrl = 'https://randomuser.me/api/portraits/men/32.jpg';

final List<Shop> shops = [
  Shop(
    name: 'Size Zero',
    imageUrl: 'https://img.icons8.com/ios-filled/100/000000/shop.png',
    menu: [
      MenuItem(name: 'Veg Cheese Sandwich',image: Image.asset('assets/img.png'), price: 80),
      MenuItem(name: 'Grilled Paneer Sandwich',image: Image.asset('assets/img.png'), price: 90),
      MenuItem(name: 'Corn & Cheese Sandwich',image: Image.asset('assets/img.png'), price: 85),
      MenuItem(name: 'Spicy Masala Burger',image: Image.asset('assets/img.png'), price: 95),
      MenuItem(name: 'Power Exercise Burger',image: Image.asset('assets/img.png'), price: 110),
      MenuItem(name: 'Choco Shake',image: Image.asset('assets/img.png'), price: 70),
      MenuItem(name: 'Strawberry Shake',image: Image.asset('assets/img.png'), price: 75),
    ],
  ),
  Shop(
    name: 'Green Leaf',
    imageUrl: 'https://img.icons8.com/ios-filled/100/228B22/leaf.png',
    menu: [
      MenuItem(name: 'Fresh Salad',image: Image.asset('assets/img.png'), price: 60),
      MenuItem(name: 'Fruit Bowl',image: Image.asset('assets/img.png'), price: 70),
    ],
  ),
  // Add more shops as needed
];

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(defaultProfileImageUrl),
            radius: 18,
          ),
        ),
        title: Text('Shops', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8),
            child: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color ?? Colors.grey),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search shops...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                ),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : (constraints.maxWidth > 400 ? 3 : 2);
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      final shop = shops[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped: ${shop.name}')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShopMenuScreen(shop: shop),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.white, // Always white for logo clarity!
                              backgroundImage: NetworkImage(shop.imageUrl.isNotEmpty ? shop.imageUrl : defaultShopImageUrl),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.black.withOpacity(0.08),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(shop.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface, shadows: [Shadow(color: Colors.black26, blurRadius: 2)])),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
