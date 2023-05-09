import '../../model/article_model.dart';

abstract class AppCahce {
  List<ArticleModel> getArticlesData();
  void setArticlesData(List<ArticleModel> articles);
  void clearCache();
  void removeFromCache(String key);
}

class AppCacheImpl implements AppCahce {
  static const String cacheArticleKey = "Cache Home Key";
  static const int cacheInterval = 5 * 60 * 1000;

  Map<String, CacheItem> cacheMap = {};

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  List<ArticleModel> getArticlesData() {
    CacheItem? cacheItem = cacheMap[cacheArticleKey];
    if (cacheItem != null && cacheItem.isValid(cacheInterval)) {
      return cacheItem.data;
    } else {
      throw Exception("Own Cache Error");
    }
  }

  @override
  void setArticlesData(List<ArticleModel> articles) {
    cacheMap[cacheArticleKey] = CacheItem(articles);
  }
}

class CacheItem {
  dynamic data;
  CacheItem(this.data);

  int cacheTime = DateTime.now().millisecondsSinceEpoch;
}

extension CacheItemExtension on CacheItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTime - cacheTime < expirationTime;
    return isValid;
  }
}
