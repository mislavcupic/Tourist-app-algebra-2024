import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();
  List<Location> getFavoriteLocations();
  void setAsFavorite(Location location);
  void removeAsFavorite(Location location);
}
