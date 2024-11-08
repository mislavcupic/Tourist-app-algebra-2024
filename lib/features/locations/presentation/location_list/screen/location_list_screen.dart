import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/controller/state/location_list_state.dart';

class LocationListScreen extends ConsumerWidget {
  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationListNotifier);
    return Column(
      children: [
        Text("Places"),
        switch (state) {
          LoadingState() => Expanded(child: Center(child: CircularProgressIndicator.adaptive())),
          EmptyState() => const Text("No list, this is empty..."),
          ErrorState() => const Text("Error happened!"),
          FilledState(locations: var list) => Expanded(
              child: ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => Card(child: Text(list[index].title)),
              ),
            ),
        }
      ],
    );
  }
}
