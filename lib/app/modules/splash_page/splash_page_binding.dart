import 'package:get/get.dart';
import 'package:pixabay_mobile/app/modules/splash_page/splash_page_controller.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController());
  }
}
