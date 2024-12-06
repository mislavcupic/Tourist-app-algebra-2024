import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/common/presentation/widget/custom_primary_button.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/placeholder.jpg',
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
                    onPressed: () {},
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
                  Text('Ban Jelacic Square'),
                  Text('10 000 Zagreb'),
                  Text('Rating'),
                  Text('Lorem ipsum dolor sit amet...'),
                  Spacer(),
                  CustomPrimaryButton(
                    onPressed: () {},
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
}
