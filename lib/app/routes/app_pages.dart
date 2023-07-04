import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pixabay_mobile/app/modules/home_page/home_page.dart';
import 'package:pixabay_mobile/app/modules/home_page/home_page_binding.dart';
import 'package:pixabay_mobile/app/modules/splash_page/splash_page_binding.dart';
import 'package:pixabay_mobile/app/modules/splash_page/splash_page.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splashPage,
      page: () => const SplashPage(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      binding: HomePageBinding(),
    ),
  ];
}
