import 'package:practical_class_01/features/locations/domain/model/location.dart';
import 'package:practical_class_01/features/locations/domain/repository/location_repository.dart';

class RemoveAsFavoriteUseCase {
  final LocationRepository _repository;

  const RemoveAsFavoriteUseCase(this._repository);

  void call(final Location location) => _repository.removeAsFavorite(location);
}
