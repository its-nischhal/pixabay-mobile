import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pixabay_mobile/app/models/pixbay_api_response_model.dart';
import 'package:pixabay_mobile/app/utils/constants/api_constants.dart';

class ApiController {
  ApiController._() {
    prepareRequest();
  }

  factory ApiController.instance() => ApiController._();

  late final Dio _dio;
  late final BaseOptions _baseOptions;
  late final InterceptorsWrapper _interceptor;

  void prepareRequest() {
    _interceptor = InterceptorsWrapper(
      onError: (e, handler) {
        log(e.message ?? 'Some thing went Wrong');
        getx.Get.showSnackbar(getx.GetSnackBar(
          title: 'Error',
          message: e.message ?? ' No Internet',
          backgroundColor: Colors.red,
          borderRadius: 25,
          snackStyle: getx.SnackStyle.FLOATING,
          snackPosition: getx.SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        ));
        handler.next(e);
      },
      onRequest: (options, handler) {
        log('Api Call on ${options.uri}');
        log('Param : ${options.queryParameters}');
        handler.next(options);
      },
      onResponse: (e, handler) {
        log('Api Response Status: ${e.statusCode}');
        log('Api Response Status Message: ${e.statusMessage}');
        log('Api Response Data: ${e.data}');
        handler.next(e);
      },
    );
    _baseOptions = BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 5),
        queryParameters: {
          'key': ApiConstants.apiKey,
          'image_type': 'photo',
          'per_page': 10
        });

    _dio = Dio(_baseOptions);
    _dio.interceptors.add(_interceptor);
  }

  Future<Response?> request(
      {required Map<String, dynamic> params,
      required String url,
      Options? options}) async {
    try {
      Response response =
          await _dio.get(url, queryParameters: params, options: options);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<PixbayApiResponseModel?> getImages(
      {required Map<String, dynamic> params}) async {
    try {
      final response = await request(params: params, url: '');
      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        return PixbayApiResponseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      log(e.type.name);
    }
    return null;
  }

  Future<bool> saveNetworkImage(String imageUrl) async {
    var response = await _dio.request(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
    );
    bool isSuccess = result['isSuccess'];

    getx.Get.showSnackbar(getx.GetSnackBar(
      title: isSuccess ? 'Image Saved' : 'Error',
      message: isSuccess
          ? 'Location: ${result['filePath']}'
          : result['errorMessage'],
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      borderRadius: 25,
      snackStyle: getx.SnackStyle.FLOATING,
      snackPosition: getx.SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    ));
    return isSuccess;
  }
}
