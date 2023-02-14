import 'package:assignment/details_image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:assignment/image.dart';
import 'package:assignment/imageDio.dart';
import 'package:assignment/image_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:number_paginator/number_paginator.dart';

import 'constants.dart';

void main() {
  runApp(GetMaterialApp(home: MaterialApp.router(routerConfig: _router,),)
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/0',
  routes: <RouteBase>[
    GoRoute(
      path: '/:page',
      builder: (BuildContext context, GoRouterState state) {
        final String page = state.params['page']!;
        return MyHomePage(page: page);
      },

    ),
  ],
);

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.page}) : super(key: key) {
    currentPage = int
        .parse(page)
        .obs;
    page = '0';
    imageController.getListImg(page);
  }

  final imageController = Get.put(ImageController());
  String page;
  XFile? file;
  late final currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(() {
              return FutureBuilder<List<ImageModel>>(
                  future: ImageAPI().getImagesByPage(
                      (currentPage.value + 1).toString()),
                  builder: (context, snapshot) {
                    return Stack(
                      children: [
                        Positioned(
                            top: 50,
                            right: 0,
                            left: 0,
                            height: constraints.maxHeight - 80,
                            child: MasonryGridView.count(crossAxisCount: 2,
                              //childAspectRatio: 2,
                              itemCount: snapshot.data!.length,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) =>
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context, PageRouteBuilder(
                                            transitionDuration: panelTransition,
                                            reverseTransitionDuration: panelTransition,
                                            pageBuilder: (context, animation,
                                                secondAnimation) =>
                                                FadeTransition(
                                                    opacity: animation,
                                                    child: DetailImagePage(
                                                        imageModel: snapshot
                                                            .data![index])
                                                )
                                        ));
                                      },
                                      child: Hero(
                                          tag: '${snapshot.data![index].id}',
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data![index]
                                                .url!, fit: BoxFit.cover,))),
                              // Image.network(snapshot.data![index].url!,
                              //   fit: BoxFit.cover,)
                              // children: List.generate(snapshot.data!.length, (index) => Container(
                              //   child: Image.network(snapshot.data![index].url!,fit: BoxFit.cover,)
                              // )),
                            )

                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 80,
                            child:
                                FutureBuilder(
                                  future: ImageAPI().getimgLength(),
                                  builder: (context, snapshot) {
                                    return NumberPaginator(
                                      numberPages: (snapshot.data!/12).ceil(),
                                      initialPage: currentPage.value,
                                      contentBuilder: (index) =>
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                  "Currently selected page: ${index +
                                                      1}"),
                                            ),
                                          ),
                                      onPageChange: (index) {
                                        //currentPage.value = index;
                                        context.go('/$index');
                                      },);
                                  }
                                )
                        )
                      ],
                    );
                  }
              );
            });
          }
      ),
      //floatingActionButton: FloatingActionButton(onPressed: () {ImageAPI().getimgLength();},child: Icon(Icons.access_alarm),),
      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(onPressed: () async {
      //       // var dio = Dio(BaseOptions(
      //       //     receiveTimeout: 3000,
      //       //     sendTimeout: 5000,
      //       //     baseUrl: "http://192.168.0.215:3000"
      //       // ));
      //       //
      //       // var image = ImageModel.create("tieu de", "mota");
      //       // var multipartFile = await MultipartFile.fromFile(file!.path,filename: 'image.jpg');
      //       // var formData = FormData.fromMap(image.toJson());
      //       // formData.files.add(MapEntry("image", multipartFile));
      //       // await dio.post("/addImage",data: formData).then((value) => debugPrint("thanh cong")).onError((error, stackTrace) => debugPrint(error.toString()));
      //
      //
      //
      //     }, child: Icon(Icons.add),),
      //     FloatingActionButton(onPressed: () async{
      //           ImagePicker imagePicker = ImagePicker();
      //           file = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 100);
      //     }, child: Icon(Icons.access_alarm),)
      //   ],
      // )
    );
  }
}
