import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Widget activeStar;
  final Widget inactiveStar;

  const StarRating({
    super.key,
    required this.rating,
    required this.activeStar,
    required this.inactiveStar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => index <= rating - 1 ? activeStar : inactiveStar,
      ),
    );
  }
}
