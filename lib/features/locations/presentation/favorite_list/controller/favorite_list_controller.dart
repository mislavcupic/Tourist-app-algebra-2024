import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';
import 'package:practical_class_01/features/locations/domain/usecase/get_favorite_locations_use_case.dart';
import 'package:practical_class_01/features/locations/domain/usecase/remove_location_as_favorite_use_case.dart';
import 'package:practical_class_01/features/locations/domain/usecase/set_location_as_favorite_use_case.dart';
import 'package:practical_class_01/features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';

class FavoriteListController extends Notifier<FavoriteListState> {
  late final GetAllFavoriteLocationsUseCase _getFavoriteList;
  late final SetLocationAsFavoriteUseCase _setAsFavorite;
  late final RemoveAsFavoriteUseCase _removeAsFavorite;

  @override
  FavoriteListState build() {
    _getFavoriteList = ref.watch(getAllFavoriteLocationsUseCaseProvider);
    _setAsFavorite = ref.watch(setAsFavoriteUseCaseProvider);
    _removeAsFavorite = ref.watch(removeAsFavoriteUseCaseProvider);

    return getAllFavorites();
  }

  FavoriteListState getAllFavorites() {
    final favorites =  _getFavoriteList();
    state = favorites.isEmpty ? EmptyState() : FilledState(favorites);
    return state;
  }

  void setAsFavorite(final Location location) {
    _setAsFavorite(location);
    getAllFavorites();
  }

  void removeAsFavorite(final Location location) {
    _removeAsFavorite(location);
    getAllFavorites();
  }
}
