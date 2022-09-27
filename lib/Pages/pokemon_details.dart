import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
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
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bulbasaur',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                'Grass, Poison',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                '#001',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              top: 15,
              left: 20,
              right: MediaQuery.of(context).size.width / 3,
              bottom: 15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    ' 69',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    '7',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BMI',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    '14.7',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                'Base stats',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Wrap(
                children: [
                  statBar('Hp ', 20),
                  statBar('Attack ', 30),
                  statBar('Defense ', 30),
                  statBar('Special Attack ', 40),
                  statBar('Special Defense ', 40),
                  statBar('Speed ', 10),
                  statBar('Avg. Power ', 30),
                ],
              ),
            ),
          ]),
        )
      ]),
    );
  }

  Widget statBar(String statName, int statVal) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              statName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              statVal.toString(),
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: statVal / 100,
            color: Color(0xffCD2873),
            backgroundColor: Color(0xffE8E8E8),
          ),
        )
      ],
    );
  }
}
