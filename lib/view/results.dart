import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/restaurant.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../model/place.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: SvgPicture.asset(
                "images/groupFun.svg",
                height: 100,
              ),
            ),
            Text(
              "The results are in!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Your groups top choices are...",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<SessionProvider>(
                builder: (context, session, child) => FutureBuilder(
                    future: HangryApi().getResults(session.code!, session.uuid!),
                    builder: (context, snapshot) => Container(
                          width: double.infinity,
                          height: 1300,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: !snapshot.hasData
                              ? null
                              : Column(
                                  // children:
                                  // getTopFive(snapshot.data!)),
                                  children:
                                      (snapshot.data!..sort((a, b) => b.match!.compareTo(a.match!)))
                                          .take(5)
                                          .map((e) => Expanded(
                                                  child: RestaurantResultCard(
                                                place: e,
                                                onSelect: () {},
                                                // onSelect: OpenMap(e.location ?? Tuple2(0.0, 0.0),
                                                //     e.name, maps.data!)
                                              )))
                                          .toList()),
                        ))),
            const SizedBox(
              height: 100,
            )
          ])),
    );
  }

  List<Theme> getTopFive(List<Place> places) {
    List<Theme> topFive = [];
    print("AHHHHHHH");
    print(places);

    for (int i = 1; i < 6; i++) {
      print(places[i - 1]);
      topFive.add(Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: EdgeInsets.all(4),
            maintainState: true,
            title: Row(
              children: [
                Text("$i. ", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 10),
                const Image(image: AssetImage("images/Logo.png"), width: 30, height: 30),
                const SizedBox(width: 10),
                // const Image.memory(base64Decode(place[0].photos[0])),
                //     width: 30,
                //     height: 30),
                // const SizedBox(width: 10),
                Text(
                  places[i - 1].name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                )
              ],
            ),
            children: [
              //  Two images, tags, percentage match, distance, health rating, google rating, price range
              Container(
                  height: 150,
                  padding: EdgeInsets.all(10),
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  places[0].match == null ? "None" : "t",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Match",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(children: [
                                  Text(places[i - 1].googleRating?.toString() ?? "None",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.titleLarge),
                                  Icon(Icons.star, color: Colors.yellow, size: 30),
                                ]),
                                Text("Google Rating ", textAlign: TextAlign.left),
                                SizedBox(height: 10),
                                Row(children: [
                                  Text(places[i - 1].healthRating ?? "None",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.titleLarge),
                                  Icon(Icons.star, color: Colors.yellow, size: 30),
                                ]),
                                Text("Food Hygine "),
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              genPriceText(places[i - 1].priceRange ?? "None"),
                              Text("Price Range"),
                              SizedBox(height: 10),
                              // Return a future builder that checks MapLauncher.isMapAvailable
                              // If true, return a button that opens the map
                              // If false, return a button that opens the google maps app
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return FloatingActionButton.small(
                                          onPressed: () => OpenMap(
                                              places[i - 1].location ?? Tuple2(0.0, 0.0),
                                              places[i - 1].name,
                                              snapshot.data!),
                                          child: Icon(Icons.map));
                                    } else {
                                      return FloatingActionButton.small(
                                          onPressed: null, child: Icon(Icons.cancel));
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                                future: MapLauncher.installedMaps,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  height: 100,
                                  width: 280,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: 5,
                                        children: genChips(places[0]),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          child:
                              // Image.memory(base64Decode(places[0].photos[1]), height: 100,
                              //     fit: BoxFit.fitHeight),
                              Image.asset("images/Logo.png", height: 100, fit: BoxFit.fitHeight),
                        ),
                        Container(
                          child:
                              // Image.memory(base64Decode(places[0].photos[2]), height: 100,
                              //     fit: BoxFit.fitHeight),
                              Image.asset("images/Logo.png", height: 100, fit: BoxFit.fitHeight),
                        )
                      ],
                    ),
                  ]))
            ]),
      ));
    }
    return topFive;
  }

  List<Icon> genRatingIcons(int rating) {
    List<Icon> icons = [];
    for (int i = 0; i < rating; i++) {}
    return icons;
  }

  Text genPriceText(String priceString) {
    int i = int.parse(priceString);
    String price = "";
    for (int j = 0; j < i; j++) {
      price += "\£";
    }
    return Text(price, style: Theme.of(context).textTheme.titleLarge);
  }

  List<Chip> genChips(Place place) {
    print(place);
    List<Chip> chips = [];
    if (place.description?.contains("Vegetarian") == true) {
      chips.add(Chip(label: Text("Vegetarian")));
    }
    if (place.wheelchairAccessible == true) {
      chips.add(Chip(label: Text("Wheelchair Acc.")));
    }
    if (place.description?.contains("Halal") == true) {
      chips.add(Chip(label: Text("Halal")));
    }
    if (place.description?.contains("Serves Alcohol") == true) {
      chips.add(Chip(label: Text("Serves Alcohol")));
    }
    return chips;
  }
}

OpenMap(Tuple2<double, double> location, String name, List<AvailableMap> availableMaps) async {
  await availableMaps.first.showMarker(
    coords: Coords(location.item1, location.item2),
    title: name,
  );
}
