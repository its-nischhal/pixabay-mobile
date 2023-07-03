import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pixabay_mobile/app/modules/splash_page/home_page_binding.dart';
import 'package:pixabay_mobile/app/modules/splash_page/splash_page.dart';
import 'package:pixabay_mobile/app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Pixbay Mobile',
      initialBinding: SplashPageBinding(),
      home: const SplashPage(),
      getPages: AppPages.pages,
    );
  }
}