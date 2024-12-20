import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/widget/location_card.dart';

class FavoriteListScreen extends ConsumerWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteListNotifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Favorites", style: context.textTitle),
              const SizedBox(height: 20),
              switch (state) {
                FilledState(favorites: var list) => Expanded(
                  child: ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => LocationCard(list[index]),
                  ),
                ),
                EmptyState() => Text("Empty :(")
              }
            ],
          ),
        ),
      ),
    );
  }
}
