import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/no_locations_found.png', width: 300),
        const SizedBox(height: 30),
        Text('No locations found...', style: context.textSubtitle),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Here is the void in space, no locations found now, but you can try to search later.',
            style: context.textDescription,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
