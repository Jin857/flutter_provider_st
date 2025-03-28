import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  test("distanceBetween ", () async {
    // 左边之间距离为米
    double distanceInMeters = Geolocator.distanceBetween(
      // https://api.ssgfgtfy.com/app/api/getGpsCityCode?longitude=&latitude=37.421998333333335,
      -122.084,
      37.421998333333335,
      52.3546274,
      4.8285838,
    );
    print("-----> $distanceInMeters");
    // 144851.67191816124
  });
}
