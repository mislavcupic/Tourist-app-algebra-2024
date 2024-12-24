import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/domain/repository/location_repository.dart';

class GetAllLocationsUseCase {
  final LocationRepository _repository;

  const GetAllLocationsUseCase(this._repository);

  Future<Either<Failure, List<Location>>> call() => _repository.getAllLocations();
}