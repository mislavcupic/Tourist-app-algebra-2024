import 'package:practical_class_01/features/locations/domain/model/location.dart';

abstract interface class DatabaseManager {
  List<Location> getAllLocations();
  void setAsFavorite(Location location);
  void removeAsFavorite(Location location);
}