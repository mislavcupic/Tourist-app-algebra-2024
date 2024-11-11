import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/features/locations/domain/usecase/GetAllLocationsUseCase.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/controller/state/location_list_state.dart';

class LocationListController extends Notifier<LocationListState> {
  late final GetAllLocationsUseCase _useCase;

  @override
  build() {
    _useCase = ref.watch(getAllLocationsUseCaseProvider);
    getAllLocations();
    return LoadingState();
  }

  void getAllLocations() async {
    state = LoadingState();

    final result = await _useCase();
    result.fold(
      (failure) => state = ErrorState(failure),
      (list) => state = list.isEmpty ? EmptyState() : FilledState(list),
    );
  }
}
