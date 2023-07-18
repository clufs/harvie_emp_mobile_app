import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ProductsHive extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int priceToSell;

  ProductsHive({
    required this.id,
    required this.title,
    required this.priceToSell,
  });
}
