import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise/model/fashion_product_model.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late FashionProductModel data;
  String _selectedSize = '';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        data = args['product'] as FashionProductModel;
        _selectedSize = args['selectedSize'] as String;
        _quantity = args['quantity'] as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0XFFFAFAFA),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderSummary(),
                  Divider(height: 1, color: Colors.grey[300], thickness: 3),

                  _buildDeliveryDetails(),
                  Divider(height: 1, color: Colors.grey[300], thickness: 3),
                  _buildDeliveryOptions(),
                  Divider(height: 1, color: Colors.grey[300], thickness: 3),
                  _buildPaymentMethod(),
                  Divider(height: 1, color: Colors.grey[300], thickness: 5),
                ],
              ),
            ),
          ),
          _buildPlaceOrder(),
        ],
      ),
    );
  }

  Widget _buildPlaceOrder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text(
                '(INC-#642542)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                '\$${(data.price * _quantity).toString()}USD',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Row(
            children: [
              Text("Yay! You've saved ", style: TextStyle(fontSize: 10)),
              Text("\$2USD", style: TextStyle(fontSize: 11)),
              Spacer(),
              Text("\$", style: TextStyle(fontSize: 12)),
              Text(
                '${(data.discountPercentage * _quantity).toString()}USD',
                style: TextStyle(
                  fontSize: 11,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF034F56),
              ),
              onPressed: () {},
              child: Text(
                'Place Order',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,

                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Offers',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Have KhorAvGifts to redeem?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Enter your gift code to your surprisel',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Gift code',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 43,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,

                              hintText: 'e.g KK12345678',
                              hintStyle: TextStyle(fontSize: 13),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0XFF034F56),
                  child: Center(
                    child: Image.asset(
                      'assets/dollar_bill_icon.png',
                      fit: BoxFit.cover,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Cash On Delivery',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined, size: 13),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 270,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Methods',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Linked Methods", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0XFF034F56),
                              radius: 14,

                              child: Image.asset(
                                'assets/dollar_bill_icon.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Cash On Delivery",
                              style: TextStyle(fontSize: 13),
                            ),
                            Spacer(),
                            Icon(Icons.check_circle, size: 16),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Add Methods",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0XFF034F56),
                              radius: 14,

                              child: Image.asset(
                                'assets/credit_card.png',
                                width: 18,
                                height: 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("Cards", style: TextStyle(fontSize: 13)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined, size: 13),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0XFF034F56),
                              radius: 14,

                              child: Image.asset(
                                'assets/image 1.png',
                                width: 23,
                                height: 23,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("ABA PAY", style: TextStyle(fontSize: 13)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined, size: 13),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0XFF034F56),
                  child: Center(
                    child: Image.asset(
                      'assets/voucher_icon.png',
                      fit: BoxFit.cover,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Use Offer',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),

                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined, size: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Options',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Priority',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.circle, size: 5, color: Colors.black),
                        SizedBox(width: 8),
                        Text('20 mins', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Text(
                      'Delivery directly to you with no stop in between',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '\$1USD',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.teal[800]!, width: 1.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Standard',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Icon(Icons.circle, size: 5, color: Colors.black),
                SizedBox(width: 8),
                Text('40 mins', style: TextStyle(fontSize: 13)),
                Spacer(),
                Text(
                  'Free',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Delivery Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Change',
                  style: TextStyle(color: Colors.teal[800], fontSize: 14),
                ),
              ),
            ],
          ),
          Text(
            'Mr. Davit Loem',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            '#15B, St.318, S/K Tuol Svaay Prey Muoy, Khan\nChamkaar Mon, Phnom Penh',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 15),
          Text(
            '+855 123456789',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0XFFEBEBEB),
                ),
                child: CachedNetworkImage(
                  imageUrl: data.thumbnail,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      data.brand,
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Size: $_selectedSize',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    '\$${data.price.toString()}USD',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 27, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Text(
                      '$_quantity',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Text(
                "Subtotal: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "\$${data.price.toString()}USD",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(
                'Delivery: ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '\$1USD',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
