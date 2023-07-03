import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pixabay_mobile/app/models/pixbay_api_response_model.dart';
import 'package:pixabay_mobile/app/utils/constants/api_constants.dart';

class ApiController {

  ApiController._() {
    prepareRequest();
  }
  ApiController controller = ApiController._();
  ApiController instance() => controller;

  late final Dio _dio;
  late final BaseOptions _baseOptions;
  late final InterceptorsWrapper _interceptor;

  void prepareRequest() {
    _interceptor = InterceptorsWrapper(
      onError: (e, handler) {
        log(e.message ?? 'Some thing went Wrong');
      },
      onRequest: (options, handler) {
        log('Api Call on ${options.uri}');
        log('Param : ${options.queryParameters}');
      },
      onResponse: (e, handler) {
        log('Api Response Status: ${e.statusCode}');
        log('Api Response Status Message: ${e.statusMessage}');
        log('Api Response Data: ${e.data}');
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

  Future<Response> request(
      {required Map<String, dynamic> params, required String url}) async {
   
      Response response = await _dio.get(
        url,
        queryParameters: params,
      );
      return response;
  }

  Future<PixbayApiResponseModel?> getImages({required Map<String, dynamic> params})async{
   try{
   final response= await request(params: params, url: '');
   if(response.statusCode==200 && response.data!=null){
       return PixbayApiResponseModel.fromJson(response.data);
   }}
   on DioException catch(e){
    log(e.type.name);
   }
    }
  
}
