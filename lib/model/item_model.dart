
import 'package:flutter/material.dart';

@immutable
class Item {
  const Item({
    required this.totalPriceCents,
    required this.name,
    required this.uid,
    required this.boxId,
    required this.listNumber,
    required this.imageProvider,
  });
  final int totalPriceCents;
  final String name;
  final String uid;
  final String boxId;
  final int listNumber;
  final ImageProvider imageProvider;
  String get formattedTotalItemPrice =>
      '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
}
