import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/locations/data/api/location_api.dart';
import 'package:tourist_project_mc/features/locations/data/database/database_manager.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationApi _locationApi;
  final DatabaseManager _databaseManager;

  const LocationRepositoryImpl(this._locationApi, this._databaseManager);

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
    try {
      final result = await _locationApi.getAllLocations();
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure("There was a network issue."));
    }
  }

  @override
  List<Location> getFavoriteLocations() => _databaseManager.getAllLocations();

  @override
  void removeAsFavorite(final Location location) => _databaseManager.removeAsFavorite(location);

  @override
  void setAsFavorite(final Location location) => _databaseManager.setAsFavorite(location);
}
