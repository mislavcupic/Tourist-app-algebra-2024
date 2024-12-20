import 'package:dartz/dartz.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();
  List<Location> getFavoriteLocations();
  void setAsFavorite(Location location);
  void removeAsFavorite(Location location);
}
