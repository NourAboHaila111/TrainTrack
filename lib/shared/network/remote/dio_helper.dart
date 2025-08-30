
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://e4b2ed778f9d.ngrok-free.app/api',
        receiveDataWhenStatusError: true,
        headers: {'accept': 'application/json'},
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required dynamic data, // 👈 خليها dynamic (تقبل Map أو FormData)
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';
    return await dio.post(url, data: data);
  }

  static Future<Response> postData1({
    required String url,
    required dynamic data,
    String? token,
    Options? options, // 👈 إضافة هذا
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    return await dio.post(
      url,
      data: data,
      options: options,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';
    return await dio.get(url, queryParameters: query);
  }
  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';
    return await dio.delete(url);
  }
  static Future<Response> getFile({
    required String url,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        options: options?.copyWith(
          responseType: ResponseType.bytes,
        ) ??
            Options(responseType: ResponseType.bytes),
      );
    } catch (e) {
      throw Exception("Dio getFile error: $e");
    }
  }

}
