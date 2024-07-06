import 'package:crises_control/src/home/models/home_icon_model.dart';
import 'package:crises_control/src/home/models/home_item.dart';
import 'package:crises_control/src/home/models/home_page_cache.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:hive/hive.dart';

class PageCacheDatabase {
  //Home page cache
  late Box<HomePageCache> _homePageCacheBox;
  static const _homePageCacheKey = 'homePageCache';
  late Box<HomeIconModel> _homeIconsBox;
  static const _homeIconsBoxKey = 'homeIcons';

  //Pings page cache
  late Box<PingData> _pingCacheBox;
  static const _pingCacheKey = 'pingCache';

  //The default order of the home icons
  final List<HomeIconModel> defaultList = [
    HomeIconModel(HomeItemType.incidents.name),
    HomeIconModel(HomeItemType.pingMessages.name),
    HomeIconModel(HomeItemType.emergency.name),
    HomeIconModel(HomeItemType.tasks.name),
    // HomeIconModel(HomeItemType.analytics.name),
    // HomeIconModel(HomeItemType.chat.name)
  ];

  Future<void> init() async {
    if (!Hive.isBoxOpen(_homePageCacheKey)) {
      _homePageCacheBox = await Hive.openBox<HomePageCache>(_homePageCacheKey);
    }

    if (!Hive.isBoxOpen(_homeIconsBoxKey)) {
      _homeIconsBox = await Hive.openBox<HomeIconModel>(_homeIconsBoxKey);
    }

    if (!Hive.isBoxOpen(_pingCacheKey)) {
      _pingCacheBox = await Hive.openBox<PingData>(_pingCacheKey);
    }
  }

  //Home page cache functions
  HomePageCache retrieveHomePageCache() {
    var homeIcons = retrieveHomeIcons();
    var homePageCache = _homePageCacheBox.values.toList();
    if (homePageCache.isEmpty) {
      return HomePageCache(homeIcons, 0, 0);
    } else {
      return homePageCache.first;
    }
  }

  insertHomePageCache({required HomePageCache cache}) async {
    _homePageCacheBox.clear();
    await _homePageCacheBox.add(cache);
  }

  addHomeIconsList(List<HomeIconModel> homeIcons) async {
    _homeIconsBox.clear();
    await _homeIconsBox.addAll(homeIcons);
  }

  List<HomeIconModel> retrieveHomeIcons() {
    var homeIcons = _homeIconsBox.values.toList();
    if (homeIcons.isEmpty) {
      return defaultList;
    } else {
      return homeIcons;
    }
  }

  //Pings page cache functions
  List<PingData> retrievePingCache() {
    return _pingCacheBox.values.toList();
  }

  insertPingCache({required List<PingData> cache}) async {
    _pingCacheBox.clear();
    await _pingCacheBox.addAll(cache);
  }

  //Clear all page cache
  clearAllCache() async {
    await _homePageCacheBox.clear();
    await _homeIconsBox.clear();
    await _pingCacheBox.clear();
  }
}
