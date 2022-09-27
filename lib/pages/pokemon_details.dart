import 'package:flutter/material.dart';
import '../models/helper.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import '../widgets/favourite_button.dart';

class DetailsPage extends StatefulWidget {
  final Pokemon pokemon;
  @override
  DetailsPage(this.pokemon);
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.pokemon.name}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '${typesJoin(widget.pokemon.types)}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '#${widget.pokemon.id}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      FadeInImage.assetNetwork(
                          placeholder: "assets/pokeball.png",
                          placeholderFit: BoxFit.fitWidth,
                          image: widget.pokemon.imageURL!,
                          fit: BoxFit.fitWidth,
                          imageCacheHeight: 200,
                          imageCacheWidth: 200,
                          imageErrorBuilder: (context, obj, trace)
                          => Image.asset("assets/pokeball.png", fit: BoxFit.fitWidth),
                          placeholderErrorBuilder: (context, obj, trace)
                          => SizedBox(width: 100, height: 100)
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 20,
                  right: MediaQuery.of(context).size.width / 3, bottom: 15),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Height', style: Theme.of(context).textTheme.bodyText2,),
                      Text('${widget.pokemon.height}', style: Theme.of(context).textTheme.headline3,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Weight', style: Theme.of(context).textTheme.bodyText2,),
                      Text('${widget.pokemon.weight}', style: Theme.of(context).textTheme.headline3,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BMI', style: Theme.of(context).textTheme.bodyText2,),
                      if (widget.pokemon.weight != null && widget.pokemon.height != null)
                      Text(
                        '${widget.pokemon.weight! / widget.pokemon.height! * widget.pokemon.height!}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text('Base stats',
                      style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Divider(color: Colors.grey,),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    itemBuilder: (context, index){
                      return statBar(widget.pokemon.stats[index].name, widget.pokemon.stats[index].value);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 25,),
                    itemCount: widget.pokemon.stats.length
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                    child: statBar("Avg. Power", getStatsAverage(widget.pokemon.stats)),
                  )
                ]),
              ),
            SizedBox(height: 15,)
          ]),
      ),
        floatingActionButton: FavouriteButton(widget.pokemon.id),
    );
  }

  Widget statBar(String? statName, int? statVal) {
    if (statVal != null)
    return Column(
      children: [
        Row(
          children: [
            Text("${statName?.capitalize()} ", style: Theme.of(context).textTheme.bodyText1,),
            Text("$statVal", style: Theme.of(context).textTheme.headline5,)
          ],
        ),
        SizedBox(height: 10,),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: statVal / 100,
            color: statVal < 30 ? Color(0xffCD2873) : statVal < 70 ? Color(0xffEEC218) : Colors.green,
            backgroundColor: Color(0xffE8E8E8),
          ),
        )
      ],
    );
    return SizedBox.shrink();
  }
}

