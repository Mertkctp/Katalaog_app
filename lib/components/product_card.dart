import 'package:flutter/material.dart';
import 'package:mini_katalog_app/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ), // BoxDecoration

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(product.image ?? ""),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                product.tagline ?? "",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                product.price ?? "",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ); // Container
  }
}
