import 'package:flutter/material.dart';
import 'package:mini_katalog_app/components/product_card.dart';
import 'package:mini_katalog_app/models/product_model.dart';
import 'package:mini_katalog_app/services/api_service.dart';
import 'package:mini_katalog_app/views/cart_screen.dart';
import 'package:mini_katalog_app/views/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<Data> allProducts = [];
  ApiService apiService = ApiService();
  String errorMessage = '';
  Set<int> cartIds = {};

  Future<void> loadProducts() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final ProductModel = await apiService.fetchProducts();

      setState(() {
        allProducts = ProductModel.data ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Bir hata oluştu";
      });
    }
  }

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ), // Text

                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    iconSize: 32,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            products: allProducts,
                            cartIds: cartIds,
                          ),
                        ),
                      );
                    },
                  ), // IconButton
                ],
              ), // Row

              const SizedBox(height: 8),

              const Text(
                'Find your perfect device.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ), // Text

              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(12),
                ), // BoxDecoration
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search products',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ), // InputDecoration
                  onChanged: (value) {},
                ), // TextField
              ), // Container

              const SizedBox(height: 16),

              // Güncellenmiş Gift Store Banner Alanı
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 80,
                      child: Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ), // SliverGridDelegateWithFixedCrossAxisCount
                        itemCount: allProducts.length,
                        itemBuilder: (context, index) {
                          final product = allProducts[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    product: product,
                                    cartIds: cartIds,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(product: product),
                          );
                        },
                      ), // GridView.builder
              ), // Expanded
            ],
          ), // Column
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}
