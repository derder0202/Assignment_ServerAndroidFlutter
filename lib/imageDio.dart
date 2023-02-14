
import 'package:http/http.dart' as http;
import 'package:assignment/image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ImageAPI{
  var dio = Dio(BaseOptions(
      receiveTimeout: 3000,
      sendTimeout: 5000,
      baseUrl: "http://192.168.0.215:3000"
  ));

  Future<List<ImageModel>> getImagesByPage(String page) async{
    Response response = await dio.get("/listImage/page/$page");
    var list = List<ImageModel>.generate(response.data.length, (index) => ImageModel.fromJson(response.data[index]));
    return list;
  }
  Future<int> getimgLength() async{
    Response response = await dio.get("/listImage/length");
    int result = int.parse(response.data.toString());
    return result;
  }

  Future<void> insertImage(ImageModel imageModel,XFile file) async{
    var request = http.MultipartRequest("POST", Uri.parse("http://192.168.0.215:3000/addImage"));
    request.fields['title'] = imageModel.title.toString();
    request.fields['description'] = imageModel.description.toString();
    var multipartFile = await http.MultipartFile.fromPath("image", file.path,contentType: MediaType("image", file.path.split(".").last));
    request.files.add(multipartFile);
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

}