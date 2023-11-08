import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../models/result_model.dart';

class FileService {
  static FileService? instence;
  factory FileService() => instence ?? FileService._();
  FileService._();

  Future<ResultModel?> uploadFile(Uint8List bytes, String name,
      {String filePath = ''}) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath, filename: name),
      });
      // var formData = FormData.fromMap({
      //   'files': MultipartFile.fromBytes(bytes,
      //       filename: 'image', contentType: MediaType('image', '')),
      // });

      Dio dio = Dio();

      // var res = await Api().dio.post('/api/process_image/',
      //     options: Options(
      //       contentType: 'multipart/form-data',
      //     ),
      //     data: formData);
      var res = await dio.post("http://178.32.240.74:8000/api/process_image/",
          data: formData);
      if (res.statusCode == 200) {
        var result = ResultModel.fromJson(res.data);
        result.path = filePath;
        return result;
      } else {
        throw Exception(res.data['error']);
      }
    } on DioException catch (err) {
      throw Exception(err.response?.data?['error']);
    } catch (e) {
      rethrow;
    }
  }
}
