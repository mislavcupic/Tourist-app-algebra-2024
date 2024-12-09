import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/common/presentation/widget/custom_primary_button.dart';
import 'package:practical_class_01/features/locations/domain/model/location.dart';
import 'package:practical_class_01/features/locations/presentation/widget/star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final location = ModalRoute.of(context)?.settings.arguments as Location;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Image.network(
              location.imageUrl,
              height: screenSize.height / 2.5,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: context.colorBackground,
                  child: IconButton(
                    color: context.colorGradientEnd,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.chevron_left_rounded, size: 35),
                  ),
                ),
              ),
            ),
            Container(
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
                    style: context.textTitle,
                  ),
                  Text(location.address, style: context.textSubtitle),
                  const SizedBox(height: 20),
                  Text("Rating", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
            ),
          ],
        ),
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
