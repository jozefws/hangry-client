import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:hangryclient/view/take_selfie.dart';
import 'package:hangryclient/view/toggler_button.dart';
import 'package:location/location.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';

class CreateSession extends StatefulWidget {
  CreateSession({super.key, required this.imagePath, required this.onNext, required this.onBack});
  String imagePath = "";

  void Function(Widget? next) onNext;
  void Function() onBack;

  @override
  State<StatefulWidget> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  XFile selfie = XFile("");
  @override
  void initState() {
    super.initState();
    setState(() {
      selfie = XFile(widget.imagePath);
    });
  }

  TextEditingController _locationNameController = TextEditingController();
  double? lat;
  double? long;
  double radius = 1;
  int eatOut = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
      builder: (context, session, child) => ListView(children: [
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
              Container(
                height: 140,
                margin: const EdgeInsets.all(60),
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 300,
                    child: selfie.path != ""
                        ? CircleAvatar(
                            backgroundImage: Image.file(File(selfie.path), fit: BoxFit.fill).image,
                            radius: 100,
                          )
                        : SvgPicture.asset(
                            "images/selfie.svg",
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              Container(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    final available = await availableCameras();
                    final result = await Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CameraPage(cameras: available)));
                    setState(() {
                      if (result.path != "") {
                        selfie = result;
                      }
                    });
                  },
                  label: Text("Selfie of you!"),
                  icon: Icon(Icons.camera_alt),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: Text(
                          "Start a new session!",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TogglerButton(
                          items: ["Eat Out", "Eat In"],
                          width: 200,
                          backgroundColour: Theme.of(context).colorScheme.primaryContainer,
                          selectedColour: Theme.of(context).colorScheme.primary,
                          toggleStateFunction: () {
                            if (eatOut == 0) {
                              setState(() {
                                eatOut = 1;
                              });
                            } else {
                              setState(() {
                                eatOut = 0;
                              });
                            }
                          },
                          state: eatOut),
                      const SizedBox(height: 40),
                      Container(
                          width: 300,
                          child: Row(children: [
                            Expanded(
                                child: TextField(
                                    controller: _locationNameController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Pick a Location",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    ),
                                    onTap: () async {
                                      final _location = await showPlacePicker();
                                      _locationNameController.text = _location.name!;
                                      setState(() {
                                        lat = _location.latLng!.latitude;
                                        long = _location.latLng!.longitude;
                                      });
                                      print("Lat: $lat, Lng: $long");
                                    })),
                            SizedBox(
                              width: 40,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final _location = await Location().getLocation();
                                  _locationNameController.text = "Current Location";
                                  setState(() {
                                    lat = _location.latitude;
                                    long = _location.longitude;
                                  });
                                  print("Lat: $lat, Lng: $long");
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                    child: Icon(
                                      Icons.place,
                                      size: 28,
                                    )))
                          ])),
                      const SizedBox(height: 20),
                      Container(
                          width: 300,
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Text("Radius"),
                            Expanded(
                              child: Slider(
                                  value: radius,
                                  onChanged: (value) => setState(() {
                                        radius = value;
                                      }),
                                  max: 20,
                                  min: 1,
                                  divisions: 19,
                                  label: "${radius.toInt()}km"),
                            )
                          ])),
                      const SizedBox(height: 40),
                      FloatingActionButton.extended(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).colorScheme.primaryContainer,
                        onPressed: lat == null || long == null
                            ? null
                            : () async {
                                final api = HangryApi();
                                final code = await api.createLobby(
                                    eatOut == 0 ? "DELIVERY" : "EAT_IN",
                                    lat!,
                                    long!,
                                    radius.toInt() * 1000);
                                if (code != null) {
                                  session.setCode(code);
                                  final response = await api.joinLobby(
                                      code,
                                      selfie.path == ""
                                          ? ""
                                          : base64Encode(await selfie.readAsBytes()));
                                  if (response != null) {
                                    session.setUUID(response[1] as String, response[0] as bool);
                                    widget.onNext(FoodCategoriesPage(
                                        onNext: (next) => widget.onNext(next),
                                        onBack: widget.onBack));
                                  }
                                }
                              },
                        heroTag: "create",
                        label: Text("Next"),
                      )
                    ],
                  ),
                ),
              )
            ])),
      ]),
    );
  }

  Future<LocationResult> showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyABjyegR7knQB_7JiMM3FUXsz7hkuMcW0A",
              // displayLocation: ,
            )));

    // Handle the result in your way
    return result;
  }
}
