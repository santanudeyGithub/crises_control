import 'package:crises_control/src/home/models/home_icon_model.dart';
import 'package:hive/hive.dart';
part 'home_page_cache.g.dart';

@HiveType(typeId: 3)
class HomePageCache {
  HomePageCache(this.homeIcons, this.incidentCount, this.pingCount);
  @HiveField(1)
  final List<HomeIconModel> homeIcons;
  @HiveField(2)
  final int incidentCount;
  @HiveField(3)
  final int pingCount;
}
