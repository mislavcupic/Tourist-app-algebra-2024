import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/presentation/location_detail/screen/location_detail_screen.dart';
import 'package:tourist_project_mc/features/locations/presentation/widget/star_rating.dart';


class LocationCard extends ConsumerWidget {
  final Location location;

  const LocationCard(this.location, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LocationDetailScreen(),
          settings: RouteSettings(arguments: location),
        ),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [context.colorGradientBegin, context.colorGradientEnd]),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Hero(
                tag: 'location${location.id}',
                child: Image.network(
                  location.imageUrl,
                  width: 110,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.title, style: context.textCardTitle),
                  Text(location.address, style: context.textCardSubtitle),
                  Text("${location.lat}, ${location.lng}", style: context.textCardText),
                  Spacer(),
                  StarRating(
                   rating: location.rating,
                   activeStar: Icon(Icons.star, color: Colors.yellow),
                   inactiveStar: Icon(Icons.star, color: Colors.grey),
                 ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _toggleFavoriteState(ref, location),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(location.isFavorite ? Icons.favorite : Icons.favorite_outline, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavoriteState(final WidgetRef ref, final Location location) {
    location.isFavorite
        ? ref.read(favoriteListNotifier.notifier).removeAsFavorite(location)
        : ref.read(favoriteListNotifier.notifier).setAsFavorite(location);
  }
}