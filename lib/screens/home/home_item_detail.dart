import 'package:flutter_03/utils/database_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_03/data/blogmodel.dart';


class HomeItemDetails extends StatefulWidget {
  final Blog blogitem;
  const HomeItemDetails({super.key, required this.blogitem});

  @override
  State<HomeItemDetails> createState() => _HomeItemDetailsState();
}

class _HomeItemDetailsState extends State<HomeItemDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        appBar: AppBar(
          backgroundColor: const Color(0xff303030),
          elevation: 0.0,
          title: const Text(
            "Details",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async {
          
              await DatabaseHelper.instance.insertBlog(widget.blogitem);
              showSnackBar1(context);

      
          },
          child: const Icon(Icons.favorite_outline),
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double imageSize = 200;

                  if (constraints.maxWidth > 600) {
                    imageSize = 550;
                  }

                  return SizedBox(
                    height: imageSize,
                    width: double.infinity,
                    child: CachedNetworkImage(
                        imageUrl: widget.blogitem.imageUrl, fit: BoxFit.cover),
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  widget.blogitem.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}

void showSnackBar1(BuildContext context) {
  var snackbar = const SnackBar(content: Text("This blog saved!"));

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}


