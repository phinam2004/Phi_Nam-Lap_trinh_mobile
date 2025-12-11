import 'package:app_phi_nam/bai8/api.dart';
import 'package:app_phi_nam/bai8/model/product.dart';
import 'package:app_phi_nam/home_screen.dart';
import 'package:flutter/material.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts>
    with SingleTickerProviderStateMixin {
  late API api;
  late Future<List<Product>?> products;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    api = API();
    products = api.getAllProduct();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  getAllProducts() {
    setState(() {
      products = api.getAllProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text('Bài 8'),
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
        drawer: MenuDrawer.buildDrawer(context),
        body: ProductList(),
      ),
    );
  }

  Widget ProductList() {
    return Column(children: [Statusbar(), SearchBar(), Toolbar(), ListBody()]);
  }

  Widget Statusbar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90E2), Color(0xFF50C878)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4A90E2).withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PNSHOP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Shopping made easy',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => {},
              icon: Stack(
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Color(0xFF4A90E2), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tìm kiếm sản phẩm...',
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFF4A90E2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.tune_rounded, color: Color(0xFF4A90E2), size: 20),
          ),
        ],
      ),
    );
  }

  Widget Toolbar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildToolbarButton(
            icon: Icons.filter_list_rounded,
            label: 'Lọc',
            onPressed: () => {},
            color: Color(0xFF50C878),
          ),
          _buildToolbarButton(
            icon: Icons.refresh_rounded,
            label: 'Làm mới',
            onPressed: getAllProducts,
            color: Color(0xFF4A90E2),
            isPrimary: true,
          ),
          _buildToolbarButton(
            icon: Icons.sort_rounded,
            label: 'Sắp xếp',
            onPressed: () => {},
            color: Color(0xFFFF6B6B),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? null
              : Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isPrimary ? Colors.white : color, size: 18),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProductCard(Product product) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                    // Category badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF4A90E2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF4A90E2).withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    // Favorite button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: Color(0xFFFF6B6B),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                // Content section
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              height: 1.2,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Giá',
                                    style: TextStyle(
                                      fontSize: 7,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 1),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF4A90E2),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFF4E6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFFFB800),
                                      size: 11,
                                    ),
                                    SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        product.rating.rate.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Color(0xFF8B6914),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        '(${product.rating.count})',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey[600],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4A90E2), Color(0xFF50C878)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Thêm vào giỏ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProductGridView(List<Product>? products) {
    return RefreshIndicator(
      onRefresh: () async {
        getAllProducts();
        await Future.delayed(Duration(milliseconds: 500));
      },
      color: Color(0xFF4A90E2),
      child: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.58,
          ),
          itemCount: products!.length,
          itemBuilder: (context, index) {
            return ProductCard(products[index]);
          },
        ),
      ),
    );
  }

  Widget ShimmerLoading() {
    return Container(
      padding: EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 16,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Container(
                        height: 28,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ListBody() {
    return FutureBuilder(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: getAllProducts,
                      icon: Icon(Icons.refresh),
                      label: Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A90E2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.data == null) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 64,
                      color: Colors.orange[300],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Error: Get all products unsuccessfully',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No products exist',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
          return Expanded(child: ProductGridView(snapshot.data));
        } else {
          return Expanded(child: ShimmerLoading());
        }
      },
    );
  }
}
