import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exercise/data/app_routes.dart';
import 'package:exercise/model/fashion_product_model.dart';
import 'package:exercise/routes/fashion_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
  }

  int _currentIndex = 0;
  final List<Map<String, String>> imageList = [
    {'image': 'assets/slilder_1.png'},
    {'image': 'assets/slider_2.png'},
    {'image': 'assets/slider_3.png'},
  ];

  final List<Map<String, String>> categories = [
    {'title': "Men's Shirts"},
    {'title': "Women's Dresses"},
    {'title': 'Women'},
    {'title': 'Kids'},
    {'title': 'Bags'},
    {'title': 'Shoes'},
    {'title': 'Accessories'},
    {'title': 'New Arrivals'},
    {'title': 'Sale'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildTitle(),
              SizedBox(height: 20),
              _buildListView(),
              SizedBox(height: 20),
              _buildCategory(),
              SizedBox(height: 20),
              _buildProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 23,
          backgroundImage: AssetImage('assets/profile_image.jpg'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Davit Loem',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Text(
                'Ready to shopping!',
                style: TextStyle(fontSize: 12, height: 1),
              ),
            ],
          ),
        ),
        _shoppingCartBadge(),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.red),
          onPressed: () {
            logout();
          },
        ),
      ],
    );
  }

  Widget _shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      showBadge: true,
      badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
      badgeContent: Text('3', style: TextStyle(color: Colors.white)),
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, size: 23),
        onPressed: () {},
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GOOD\nAFTERNOON!',
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        Text(
          'Discover your unique style with KHOR AV store!',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageList.length,
          itemBuilder: (context, index, realIndex) {
            final item = imageList[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item['image']!, fit: BoxFit.cover),

                  // Text
                  // const Positioned(
                  //   top: 18,
                  //   right: 13,
                  //   child: Text(
                  //     'CREATE YOUR\nOWN TREND.',
                  //     style: TextStyle(
                  //       height: 1,
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.w900,
                  //       color: Color(0XFFD2FF00),
                  //     ),
                  //   ),
                  // ),

                  // Button
                  Positioned(
                    bottom: 7,
                    right: 13,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'DISCOVER MORE',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 200,

            // 🔥 IMPORTANT PART
            viewportFraction: 0.95, // show left & right
            enlargeCenterPage: true, // center bigger
            enlargeFactor: 0.25, // scale amount
            enlargeStrategy: CenterPageEnlargeStrategy.scale,

            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,

            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),

        const SizedBox(height: 12),

        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: imageList.length,
          effect: WormEffect(
            dotHeight: 9,
            dotWidth: 9,
            activeDotColor: Colors.black,
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 19),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1.3, color: Colors.black),
                ),
                child: Text(
                  categories[index]['title']!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'All Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Spacer(),
            Text(
              'View all',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward_sharp, size: 18, color: Colors.black),
          ],
        ),
        SizedBox(height: 15),
        _buildProductItem(),
      ],
    );
  }

  Widget _buildProductItem() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: fashionProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        mainAxisExtent: 270,
      ),
      itemBuilder: (context, index) {
        final product = FashionProductModel.fromMap(fashionProducts[index]);
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.detailScreen,
              arguments: product,
            );
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFEBEBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            maxWidthDiskCache: 400,
                            maxHeightDiskCache: 400,
                            imageUrl: product.thumbnail,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(color: Colors.grey[300]),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${product.discountPercentage.toInt()}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              Icons.bookmark_border_rounded,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand,
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
