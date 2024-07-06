import 'package:hive_flutter/hive_flutter.dart';
part 'home_icon_model.g.dart';

@HiveType(typeId: 2)
class HomeIconModel {
  HomeIconModel(this.homeItem);

  @HiveField(1)
  final String homeItem;
}
