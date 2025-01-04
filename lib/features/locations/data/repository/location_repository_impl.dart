import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/locations/data/api/location_api.dart';
import 'package:tourist_project_mc/features/locations/data/database/database_manager.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/domain/repository/location_repository.dart';
import 'package:dartz/dartz.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationApi _locationApi;
  final DatabaseManager _databaseManager;

  const LocationRepositoryImpl(this._locationApi, this._databaseManager);

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
    try {
      final response = await _locationApi.getAllLocations();
      final favorites = _databaseManager.getAllLocations();

      final result = _applyFavoriteFlags(response, favorites);

      return Right(result);
    } catch (e) {
      return Left(NetworkFailure("There was a network issue."));
    }
  }

  List<Location> _applyFavoriteFlags(final List<Location> response, final List<Location> favorites) {
    for (var location in response) {
      if (favorites.contains(location)) {
        location.isFavorite = true;
      }
    }
    return response;
  }

  @override
  List<Location> getFavoriteLocations() => _databaseManager.getAllLocations();

  @override
  void removeAsFavorite(final Location location) => _databaseManager.removeAsFavorite(location);

  @override
  void setAsFavorite(final Location location) => _databaseManager.setAsFavorite(location);
}