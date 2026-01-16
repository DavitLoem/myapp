class FashionProductModel {
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String thumbnail;
  final String availabilityStatus;
  final String shippingInformation;
  final String returnPolicy;
  const FashionProductModel({
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.thumbnail,
    required this.availabilityStatus,
    required this.shippingInformation,
    required this.returnPolicy,
  });

  factory FashionProductModel.fromMap(Map<String, dynamic> data) {
    return FashionProductModel(
      title: data['title'],
      description: data['description'],
      category: data['category'],
      price: data['price'],
      discountPercentage: data['discountPercentage'],
      rating: data['rating'],
      stock: data['stock'],
      tags: List<String>.from(data['tags']),
      brand: data['brand'],
      thumbnail: data['thumbnail'],
      availabilityStatus: data['availabilityStatus'],
      shippingInformation: data['shippingInformation'],
      returnPolicy: data['returnPolicy'],
    );
  }

  Map<String, dynamic> todata() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'thumbnail': thumbnail,
      'availabilityStatus': availabilityStatus,
      'shippingInformation': shippingInformation,
      'returnPolicy': returnPolicy,
    };
  }
}
