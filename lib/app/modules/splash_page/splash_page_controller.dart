import 'package:get/get.dart';
import 'package:pixabay_mobile/app/routes/app_routes.dart';

class SplashPageController extends GetxController{
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then((value) => Get.offAndToNamed(AppRoutes.homePage));
    super.onInit();
  }
  
}