import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_mobile/app/components/post_widget.dart';
import 'package:pixabay_mobile/app/modules/home_page/home_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<HomePageController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PIXABAY MOBILE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.imageDataList.length + 1,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) =>
                            (index < controller.imageDataList.length
                                ? PostWidget(
                                    height: width * 1.1,
                                    width: width - 40,
                                    imageData: controller.imageDataList[index])
                                : ElevatedButton(
                                    onPressed: () => controller.getImages(),
                                    child: const Text('Get More Images'))),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
