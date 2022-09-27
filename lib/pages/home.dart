import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/pokemon_grid.dart';
import '../rest_client.dart' as rest_client;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 0;

  TabBar tabBar() => TabBar(
    isScrollable: false,
    unselectedLabelColor: Color(0xff6B6B6B),
    labelColor: Color(0xff161A33),
    labelStyle: Theme.of(context).textTheme.headline3,
    unselectedLabelStyle: Theme.of(context).textTheme.headline4,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: Theme.of(context).primaryColor,
    tabs: [
      Tab(child: Text("All Pokemons")),
      Tab(child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Favourites "),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(99)
            ),
            child: ValueListenableBuilder(
              valueListenable: favouritesCount,
              builder: (context, index, widget){
                return Text("${favouritesCount.value}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),);
              }
            )
          )
        ]
      ))
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        animationDuration: Duration(milliseconds: 1500),
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 88,
                pinned: false, snap: true, floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icons/pokeball.png', height: 25, width: 25),
                      SizedBox(width: 8),
                      Text("Pokedex", style: Theme.of(context).textTheme.headline2)
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(tabBar()),
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            children: [
              /*
              TAB 1 (All pokemon)
              */
              FutureBuilder(
                future: rest_client.getNextPokemons(9, pageNumber * 9),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return PokemonGrid(snapshot.data, favouritesList: false);
                  }
                  else{
                    if (snapshot.hasError) print(snapshot.error);
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,),
                    );
                  }
                }
              ),
              /*
              TAB 2 (favourites)
              */
              FutureBuilder(
                  future: rest_client.getFavouritePokemons(User.instance.favouriteIDs),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return PokemonGrid(snapshot.data, favouritesList: true);
                    }
                    else{
                      if (snapshot.hasError) print(snapshot.error);
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,),
                      );
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate{
  final TabBar tabBar;
  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 30;

  @override
  double get minExtent => tabBar.preferredSize.height + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}