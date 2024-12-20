import 'package:dartz/dartz.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';
import 'package:practical_class_01/features/locations/domain/repository/location_repository.dart';

class GetAllLocationsUseCase {
  final LocationRepository _repository;

  const GetAllLocationsUseCase(this._repository);

  Future<Either<Failure, List<Location>>> call() => _repository.getAllLocations();
}