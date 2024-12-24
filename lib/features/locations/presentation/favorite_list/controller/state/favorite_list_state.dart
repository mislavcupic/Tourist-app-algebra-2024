import 'package:tourist_project_mc/features/locations/domain/model/location.dart';

sealed class FavoriteListState {}

class FilledState extends FavoriteListState {
  final List<Location> favorites;

  FilledState(this.favorites);
}

class EmptyState extends FavoriteListState {}