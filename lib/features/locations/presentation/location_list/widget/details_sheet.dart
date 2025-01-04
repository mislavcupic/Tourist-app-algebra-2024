
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_project_mc/features/locations/domain/model/location.dart';
import 'package:tourist_project_mc/features/locations/presentation/widget/star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsSheet extends StatelessWidget {
  final Location location;

  const DetailsSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.light
        ? context.colorText
        : context.colorBackground;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: screenSize.height / 2.7),
      padding: const EdgeInsets.all(20),
      width: double.maxFinite,
      //height: screenSize.height,
      decoration: BoxDecoration(
        color: context.colorBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.title,
            style: TextStyle(color: textColor),
          ),
          Text(location.address, style: TextStyle(color: textColor)),
          const SizedBox(height: 20),
          Text("Rating", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          StarRating(
            rating: location.rating,
            activeStar: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [context.colorGradientBegin, context.colorGradientEnd],
              ).createShader(bounds),
              child: Icon(Icons.star, color: context.colorGradientBegin, size: 28),
            ),
            inactiveStar: Icon(Icons.star, color: Colors.grey, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            location.description,
            style: TextStyle(color: textColor,fontWeight: FontWeight.w500, fontSize: 14),
          ),
          Spacer(),
          CustomPrimaryButton(
            onPressed: () => Platform.isAndroid
                ? _launchAndroidMaps(context, location.lat, location.lng, location.title)
                : _launchIOSMaps(context, location.lat, location.lng),
            child: Text(
              'Show on maps',
              style: context.textButton.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchIOSMaps(BuildContext context, final double latitude, final double longitude) async {
    try {
      final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (error) {
      if (context.mounted) {
        final snackBar = SnackBar(content: Text("Cannot open maps app."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _launchAndroidMaps(BuildContext context, final double latitude, final double longitude, final String title)
  async {
    try {
      final url = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($title)');
      await launchUrl(url);
    } catch (error) {
      if (context.mounted) {
        final snackBar = SnackBar(content: Text("Cannot open maps app."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
// TODO Implement this library.