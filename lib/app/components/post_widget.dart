import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_mobile/app/models/pixbay_api_response_model.dart';
import 'package:pixabay_mobile/app/modules/home_page/home_page_controller.dart';

class PostWidget extends StatelessWidget {
  PostWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.imageData});
  final double height, width;
  final ImageData imageData;
  final ValueNotifier<bool> isDownloaded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
          border: Border.all(width: .5, color: Colors.white)),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  foregroundImage: NetworkImage(imageData.userImageUrl),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  imageData.user,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: .5,
            height: 0,
          ),
          Expanded(
              flex: 5,
              child: CachedNetworkImage(
                imageUrl: imageData.webformatUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Image.network(
                  imageData.previewUrl,
                  fit: (imageData.imageHeight > imageData.imageWidth)
                      ? BoxFit.fitHeight
                      : BoxFit.fitWidth,
                ),
              )),
          const Divider(
            color: Colors.white,
            thickness: .5,
            height: 0,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 25,
              ),
              const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${imageData.views} views',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: isDownloaded,
                    builder: (context, value, child) => value
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : IconButton(
                            onPressed: () async {
                              isDownloaded.value =
                                  await Get.find<HomePageController>()
                                      .downloadImage(imageData.largeImageUrl);
                            },
                            icon: const Icon(
                              Icons.download_outlined,
                              color: Colors.white,
                            ))),
              )
            ],
          ))
        ],
      ),
    );
  }
}
