
import 'package:flutter/material.dart';

import 'item_model.dart';

class Customer {
  Customer({
    required this.name,
    required this.bucketIndex,
    required this.imageProvider,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final String bucketIndex;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents =
    items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}