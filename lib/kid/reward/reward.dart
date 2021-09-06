import 'package:flutter/material.dart';

class Reward {
  const Reward({
    this.color = Colors.black,
    required this.cost,
    required this.name,
    required this.imageUrl,
  });

  final Color color;
  final int cost;
  final String name;
  final String? imageUrl;
}
