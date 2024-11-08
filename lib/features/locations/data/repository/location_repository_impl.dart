import 'package:dartz/dartz.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/locations/data/api/location_api.dart';
import 'package:practical_class_01/features/locations/domain/repository/location_repository.dart';

import '../../domain/model/location.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationApi _locationApi;

  const LocationRepositoryImpl(this._locationApi);

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
    try {
      final result = await _locationApi.getAllLocations();
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure("There was a network issue."));
    }
  }
}