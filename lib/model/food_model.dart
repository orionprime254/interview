import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 0)
class Food extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String thumbnailUrl;
  @HiveField(2)
  final String id;
  @HiveField(3)
  String? localImagePath;

  Food({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.localImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'id': id,
      'localImagePath': localImagePath,
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      title: json['title'] ?? 'No title',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      id: json['id'].toString() ?? '',
      localImagePath: json['localImagePath'],
    );
  }

  Food clone() {
    return Food(
      id: this.id,
      title: this.title,
      thumbnailUrl: this.thumbnailUrl,
      localImagePath: this.localImagePath,
    );
  }
}
