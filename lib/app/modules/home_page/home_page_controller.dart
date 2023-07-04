import 'package:get/get.dart';
import 'package:pixabay_mobile/app/models/pixbay_api_response_model.dart';
import 'package:pixabay_mobile/app/utils/api_contoller.dart';

class HomePageController extends GetxController {
  @override
  void onInit() async {
    isLoading = true;
    await getImages();
    isLoading = false;
    super.onInit();
  }

  ApiController apiController = ApiController.instance();
  bool isLoading = false;
  int page = 0;
  List<ImageData> imageDataList = [];
  late PixbayApiResponseModel model;
  Future<void> getImages() async {
    page++;
    PixbayApiResponseModel? model =
        await apiController.getImages(params: {'page': page});
    if (model != null) {
      imageDataList.addAll(model.hits);
      imageDataList;
    }
    update();
  }

  Future<dynamic> downloadImage(String imageUrl) async {
    return await apiController.saveNetworkImage(imageUrl);
  }
}
