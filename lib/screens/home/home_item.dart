import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_03/data/blogmodel.dart';

class Homeitem extends StatelessWidget {
  final Blog productModel;

  const Homeitem({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double imageSize = 200;

              if (constraints.maxWidth > 600) {
                imageSize = 600;
              }

              return SizedBox(
                height: imageSize,
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl: productModel.imageUrl, fit: BoxFit.cover,),
              );
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(
              productModel.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
