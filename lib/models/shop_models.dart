import 'package:flutter/src/widgets/image.dart';

class Shop {
  final String name;
  final String imageUrl;
  final List<MenuItem> menu;
  Shop({required this.name, required this.imageUrl, required this.menu});
}

class MenuItem {
  final String name;
  final int price;

   var image;
  MenuItem({required this.name, required this.price, required this.image});
}

class CartItem {
  final MenuItem item;
  int quantity;
  CartItem({required this.item, this.quantity = 1});
}
