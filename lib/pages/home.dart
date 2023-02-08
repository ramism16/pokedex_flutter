import 'package:flutter/material.dart';
import '../widgets/pokemon_grid.dart';
import '../rest_client.dart' as rest_client;
import '../controllers/shared_preferences_controller.dart';

class HomePage extends StatefulWidget {

  static void changePage(BuildContext context, bool nextPage){
    _HomePageState? state = context.findAncestorStateOfType<_HomePageState>();
    state?.changePage(nextPage);
  }

  static int? getPageNumber(BuildContext context) {
    _HomePageState? state = context.findAncestorStateOfType<_HomePageState>();
    return state?.pageNumber;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNumber = 0;

  void changePage(bool nextPage){
    setState(() {
      if (nextPage)
        ++pageNumber;
      else{
        if (pageNumber > 0)
          --pageNumber;
      }
    });
  }

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
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(99)
              ),
              child: Text("${favouritesCount.value}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
              )
            )
          ]
        )),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: favouritesCount,
      builder: (context, index, widget) => Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    expandedHeight: 100,
                    pinned: false, snap: true, floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/pokeball.png', height: 25, width: 25),
                          Text(" Pokedex", style: Theme.of(context).textTheme.headline2)
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverTabBarDelegate(tabBar()),
                    pinned: true,
                    floating: true,
                  ),
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
                      if (snapshot.connectionState != ConnectionState.done)
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor));
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
                    future: rest_client.getFavouritePokemons(SharedPreferencesController.instance.favouriteIDs),
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
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}