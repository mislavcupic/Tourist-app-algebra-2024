import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';

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