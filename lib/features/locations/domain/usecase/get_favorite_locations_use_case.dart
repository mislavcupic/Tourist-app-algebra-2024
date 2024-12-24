import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/domain/repository/location_repository.dart';

class GetAllFavoriteLocationsUseCase {
  final LocationRepository _repository;

  const GetAllFavoriteLocationsUseCase(this._repository);

  List<Location> call() => _repository.getFavoriteLocations();
}