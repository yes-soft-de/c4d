import 'package:latlong/latlong.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinksService {
  static Future<LatLng> checkForGeoLink() async {
    var uri = await getInitialUri();

    if (uri == null) {
      return null;
    }
    if (uri.queryParameters == null) {
      return null;
    }

    if (uri.queryParameters['q'] == null) {
      return null;
    }

    return LatLng(
      double.parse(uri.queryParameters['q'].split(',')[0]),
      double.parse(uri.queryParameters['q'].split(',')[1]),
    );
  }
}
