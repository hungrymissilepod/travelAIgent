import 'package:enum_to_string/enum_to_string.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';

enum DuckWebImageSize {
  cached,
  small,
  medium,
  large,
  wallpaper,
}

enum DuckWebImageLayout {
  all,
  square,
  tall,
  wide,
}

enum DuckWebImageType {
  all,
  photo,
  clipart,
  gif,
  transparent,
}

const int maxImagesToReturn = 5;

class DuckDuckGoUtils {
  final String baseUrl = 'https://duckduckgo.com/';

  /// Headers to be sent with image request
  Map<String, dynamic> headers = <String, dynamic>{
    'authority': 'duckduckgo.com',
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'sec-fetch-dest': 'empty',
    'x-requested-with': 'XMLHttpRequest',
    'user-agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'referer': 'https://duckduckgo.com/',
    'accept-language': 'en-US,en;q=0.9',
  };

  String getImageSizeFilter(DuckWebImageSize size) {
    if (size == DuckWebImageSize.cached) {
      return '';
    }
    return EnumToString.convertToString(size);
  }

  String getImageLayoutFilter(DuckWebImageLayout layout) {
    if (layout == DuckWebImageLayout.all) {
      return '';
    }
    return EnumToString.convertToString(layout);
  }

  String getImageTypeFilter(DuckWebImageType type) {
    if (type == DuckWebImageType.all) {
      return '';
    }
    return EnumToString.convertToString(type);
  }

  /// We need this to query DuckDuckGo initially to get a search token
  Map<String, dynamic> parameters(String query) {
    return <String, dynamic>{'q': query};
  }

  /// Takes a list of [results] (json objects of images)
  /// and returns the images for [imagesToReturn] of them
  List<String> getImagesFromResponse(
      List<dynamic> results, int imagesToReturn) {
    final List<String> images = <String>[];

    /// Only return [imagesToReturn]
    results = results.take(imagesToReturn).toList();

    for (dynamic d in results) {
      final DuckWebImage duckWebImage = DuckWebImage.fromJson(d);

      /// We can either return thumbnail urls or full image urls
      images.add(duckWebImage.image);
    }
    return images;
  }
}
