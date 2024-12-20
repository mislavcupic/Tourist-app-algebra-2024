import 'package:practical_class_01/features/locations/domain/model/location.dart';

sealed class FavoriteListState {}

class FilledState extends FavoriteListState {
  final List<Location> favorites;

  FilledState(this.favorites);
}

class EmptyState extends FavoriteListState {}