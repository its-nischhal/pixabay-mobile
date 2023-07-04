import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_mobile/app/modules/splash_page/splash_page_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixabay_mobile/app/utils/constants/asset_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SvgPicture.asset(
            AssetConstants.pixbayLogo,
            width: 200,
            height: 200,
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
