import 'package:flutter_03/screens/home/fav_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_03/screens/home/home_item.dart';
import 'package:flutter_03/screens/home/home_item_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              backgroundColor: Color(0xff1B1B1B),
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );

          case HomeLoadedSuccess:
            final successstate = state as HomeLoadedSuccess;

            return _homepage(successstate);

          case HomeErrorState:
            return const Scaffold(
              backgroundColor: Color(0xff1B1B1B),
              body: Center(
                child: Text(
                  "Error!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  Scaffold _homepage(HomeLoadedSuccess successstate) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        elevation: 0.0,
        actions: [
           Container(
            margin: const EdgeInsets.only(right: 8),
            child: SvgPicture.asset(
              'assets/trailing.svg',
              height: 42,
            ))

        ],
        title: Container(
            margin: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              'assets/subspace_hor.svg',
              height: 24,
            )),
      ),
      body: mobileListview(successstate),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>const FavBlog() )));

      }, backgroundColor: Colors.black,child: const Icon(Icons.favorite),),
    );
  }

  ListView mobileListview(HomeLoadedSuccess successstate) {
    return ListView.builder(
        itemCount: successstate.products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => HomeItemDetails(
                          blogitem: successstate.products[index]))));
            },
            child: Homeitem(productModel: successstate.products[index]),
          );
        });
  }
}
