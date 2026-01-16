import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise/data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/fashion_product_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late FashionProductModel data;
  bool _showFullDescription = false;
  String _selectedSize = 'S';
  int _quantity = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as FashionProductModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFEBEBEB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
              child: Column(children: [_buildHeader(), _buildProduct()]),
            ),
            _buildDetailProduct(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailProduct() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.brand,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Price : \$${data.price.toString()}USD ',
                  style: TextStyle(fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 27, 27),
                  ),
                  child: Text(
                    '${data.discountPercentage.toInt()}% off',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFullDescription = !_showFullDescription;
                });
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _showFullDescription
                          ? data.description
                          : _getTruncatedDescription(),
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    if (!_showFullDescription)
                      TextSpan(
                        text: ' more...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (_showFullDescription)
                      TextSpan(
                        text: ' less...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'AVAILABLE:',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  data.stock > 0 ? "IN STOCK" : "OUT OF STOCK",
                  style: const TextStyle(fontSize: 13, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'TAG: ',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      data.tags.join(', '),
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Size: $_selectedSize',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              spacing: 15,
              children: [
                _buildSized('S'),
                _buildSized('M'),
                _buildSized('L'),
                _buildSized('ML'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Quantity:',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    spacing: 15,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        child: Icon(Icons.remove, size: 18),
                      ),
                      Text('$_quantity'),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 10,
                      ),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    onPressed: () {},
                    child: Text('Add to Cart - ${data.price.toString()}USD'),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Icon(Icons.bookmark_outline_outlined),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF005055),

                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.checkoutScreen,
                  arguments: {
                    'product': data,
                    'selectedSize': _selectedSize,
                    'quantity': _quantity,
                  },
                );
              },
              child: Center(
                child: Text('BUY NOW', style: TextStyle(fontSize: 15)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.local_shipping_outlined, size: 28),
                Text(data.shippingInformation, style: TextStyle(fontSize: 17)),
              ],
            ),
            SizedBox(height: 15),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.shield_outlined, size: 28),
                Text(data.returnPolicy, style: TextStyle(fontSize: 17)),
              ],
            ),
            SizedBox(height: 25),
            Text(
              'Return Policy',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You may return most new, unopened items within 30 days of delivery for a full refund. We\'ll also pay the return shipping costs if the return is a result of our error (you received an incorrect or defective item, etc.).',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            Text(
              'Shipping',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We can ship to virtually any address in the world. Note that there are restrictions on some products, and some products cannot be shipped to international destinations.',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Icon(Icons.share_outlined, size: 27),
                Text(
                  'Share :',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSized(String text) {
    bool isSelected = _selectedSize == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  String _getTruncatedDescription() {
    final words = data.description.split(' ');
    if (words.length <= 20) return data.description;

    String truncated = '';
    int lineCount = 1;
    int currentLineLength = 0;

    for (int i = 0; i < words.length && lineCount <= 4; i++) {
      final word = words[i];
      if (currentLineLength + word.length + 1 > 40) {
        // Approximate line length
        lineCount++;
        currentLineLength = 0;
        if (lineCount > 4) break;
      }
      truncated += (truncated.isEmpty ? '' : ' ') + word;
      currentLineLength += word.length + 1;
    }

    return truncated;
  }

  Widget _buildProduct() {
    return Container(
      height: 330,
      color: Color(0XFFEBEBEB),
      child: CachedNetworkImage(
        maxWidthDiskCache: 400,
        maxHeightDiskCache: 400,
        imageUrl: data.thumbnail,
        fit: BoxFit.cover,
        width: 330,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.grey[300]),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red, size: 40),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 25),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        Text(
          'Detail',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        Spacer(),
        _shoppingCartBadge(),
      ],
    );
  }

  Widget _shoppingCartBadge() {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 3, end: 7),
      showBadge: true,
      badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
      badgeContent: Text(
        '3',
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, size: 28, color: Colors.black),
        onPressed: () {},
      ),
    );
  }
}
