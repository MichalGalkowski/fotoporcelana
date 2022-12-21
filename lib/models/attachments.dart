const String tableAttachments = 'attachments';

class AttachmentsFields {
  static final List<String> values = [id, path, time];

  static const String id = '_id';
  static const String path = 'path';
  static const String product = 'product';
  static const String time = 'time';
}

class Attachments {
  final int? id;
  final String path;
  final String product;
  final DateTime createdTime;

  const Attachments({
    this.id,
    required this.path,
    required this.product,
    required this.createdTime,
  });

  Attachments copy({
    int? id,
    String? path,
    String? product,
    DateTime? createdTime,
  }) =>
      Attachments(
        id: id ?? this.id,
        path: path ?? this.path,
        product: path ?? this.product,
        createdTime: createdTime ?? this.createdTime,
      );

  static Attachments fromJson(Map<String, Object?> json) => Attachments(
        id: json[AttachmentsFields.id] as int?,
        path: json[AttachmentsFields.path] as String,
        product: json[AttachmentsFields.product] as String,
        createdTime: DateTime.parse(json[AttachmentsFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        AttachmentsFields.id: id,
        AttachmentsFields.path: path,
        AttachmentsFields.product: product,
        AttachmentsFields.time: createdTime.toIso8601String(),
      };
}
