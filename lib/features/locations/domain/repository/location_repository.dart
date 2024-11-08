import 'package:dartz/dartz.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();
}
