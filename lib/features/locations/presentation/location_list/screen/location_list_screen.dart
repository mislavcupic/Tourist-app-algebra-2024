import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/controller/state/location_list_state.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/widget/empty_state_widget.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/widget/error_state_widget.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/widget/location_card.dart';

class LocationListScreen extends ConsumerWidget {
  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationListNotifier);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Places", style: context.textTitle),
          switch (state) {
            LoadingState() => Expanded(
                child: Center(child: Lottie.asset('assets/animations/loading_sights.json', height: 50)),
              ),
            EmptyState() => Expanded(child: EmptyStateWidget()),
            ErrorState(failure: var failure) => ErrorStateWidget(failure),
            FilledState(locations: var list) => Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => LocationCard(list[index]),
                ),
              ),
          }
        ],
      ),
    );
  }
}
