const String tableProducts = 'products';

class ProductFields {
  static final List<String> values = [
    id,
    title,
    data,
    attachments,
    amount,
    time
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String data = 'data';
  static const String attachments = 'attachments';
  static const String amount = 'amount';
  static const String time = 'time';
}

class Product {
  final String id;
  final String title;
  final String data;
  final String attachments;
  final int amount;
  final DateTime createdTime;

  const Product({
    required this.id,
    required this.title,
    required this.data,
    required this.attachments,
    required this.amount,
    required this.createdTime,
  });

  Product copy({
    String? id,
    String? title,
    String? data,
    String? attachments,
    int? amount,
    DateTime? createdTime,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        data: data ?? this.data,
        attachments: data ?? this.attachments,
        amount: amount ?? this.amount,
        createdTime: createdTime ?? this.createdTime,
      );

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[ProductFields.id] as String,
        title: json[ProductFields.title] as String,
        data: json[ProductFields.data] as String,
        attachments: json[ProductFields.attachments] as String,
        amount: json[ProductFields.amount] as int,
        createdTime: DateTime.parse(json[ProductFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.title: title,
        ProductFields.data: data,
        ProductFields.attachments: attachments,
        ProductFields.amount: amount,
        ProductFields.time: createdTime.toIso8601String(),
      };
}
