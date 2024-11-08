import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';

sealed class LocationListState {}

class LoadingState extends LocationListState {}

class FilledState extends LocationListState {
  final List<Location> locations;

  FilledState(this.locations);
}

class EmptyState extends LocationListState {}

class ErrorState extends LocationListState {
  final Failure failure;

  ErrorState(this.failure);
}