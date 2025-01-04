import 'package:flutter/material.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';


class EmptyFavoriteStateWidget extends StatelessWidget {
  const EmptyFavoriteStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Dobijanje boje teksta ovisno o trenutno aktivnoj temi
    final Color textColor = Theme.of(context).brightness == Brightness.light
        ? context.colorText
        : context.colorBackground;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_favorites.png", width: 300),
        Text(
          "There are no favorites yet...",
          style: TextStyle(color: textColor),
        ),
        Text(
          "Here you will see all your favorite sights. Mark them as favorite by pressing the heart icon.",
          style: context.textDescription.copyWith(color: textColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
