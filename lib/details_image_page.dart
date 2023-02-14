
import 'package:assignment/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImagePage extends StatelessWidget {
  DetailImagePage({Key? key, required this.imageModel,}) : super(key: key);
  final ImageModel imageModel;

 // final TextEditingController _ghichu = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.brown,
          elevation: 0,
          centerTitle: true,
          //title: Text(product.name,style: const TextStyle(color: Colors.white,),),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    //color: Color(0xFFF8F8F8),
                      child: Hero(
                        tag: '${imageModel.id}',
                        child: Image(
                          image: CachedNetworkImageProvider(imageModel.url.toString()),
                          width: constraints.maxWidth/2,
                          height: constraints.maxWidth/2,
                        ),
                      )
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Text('${imageModel.title}',style: Theme.of(context).textTheme.titleLarge,),
                        Padding(padding: EdgeInsets.only(top: 20),
                        child: Text('Mô tả: ${imageModel.description}',style: Theme.of(context).textTheme.bodyMedium,)),
                        Padding(padding: EdgeInsets.all(20),
                            child: Text('url: ${imageModel.url}',style: Theme.of(context).textTheme.bodyMedium,)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('sdUrl: ${imageModel.sdUrl}',style: Theme.of(context).textTheme.bodyMedium,)),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
    );
  }
}
