import 'package:flutter_03/data/blogmodel.dart';
import 'package:flutter_03/screens/home/home_item.dart';
import 'package:flutter_03/screens/home/home_item_detail.dart';
import 'package:flutter_03/utils/database_helper.dart';
import 'package:flutter/material.dart';

class FavBlog extends StatefulWidget {
  const FavBlog({super.key});

  @override
  State<FavBlog> createState() => _FavBlogState();
}

class _FavBlogState extends State<FavBlog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
        future: DatabaseHelper.instance.getBlogList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Something went wrong!',style: TextStyle(fontSize: 18.0,color: Colors.white),);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            
            return const Text('No items available',style: TextStyle(fontSize: 18.0,color: Colors.white),);
          } else {
            return favscreen(snapshot);
          }
        }));
  }

  Scaffold favscreen(AsyncSnapshot<List<Blog>> snapshot) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        elevation: 0.0,
        title: const Text("Favourite"),
      ),
      body: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Blog bloglist = snapshot.data![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            HomeItemDetails(blogitem: bloglist))));
              },
              child: Homeitem(productModel: bloglist),
            );
          }),
    );
  }

  
}
