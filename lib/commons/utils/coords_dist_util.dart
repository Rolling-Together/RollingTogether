import 'dart:math';

double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371e3; // Earth's radius in meters

  double toRadians(double degree) {
    return degree * pi / 180;
  }

  double deltaLat = toRadians(lat2 - lat1);
  double deltaLon = toRadians(lon2 - lon1);
  lat1 = toRadians(lat1);
  lat2 = toRadians(lat2);

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      sin(deltaLon / 2) * sin(deltaLon / 2) * cos(lat1) * cos(lat2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}
