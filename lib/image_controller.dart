

import 'package:assignment/image.dart';
import 'package:assignment/imageDio.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ImageController extends GetxController{

  static ImageController get to => Get.find();

  //List<ImageModel> listImgs = [];


  getListImg(String page) async{
      var listImgs = await ImageAPI().getImagesByPage(page);
      return listImgs;
  }

}