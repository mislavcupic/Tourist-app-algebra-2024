import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.network(
              location.imageUrl,
              width: 110,
              height: 85,
              fit: BoxFit.cover,
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
                StarRating(location.rating),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int numOfStars;

  const StarRating(this.numOfStars, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(Icons.star, color: index <= numOfStars - 1 ? Colors.yellow : Colors.grey),
      ),
    );
  }
}
