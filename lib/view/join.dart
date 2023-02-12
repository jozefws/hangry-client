import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangryclient/api/hangry_api.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/food_categories_page.dart';
import 'package:hangryclient/view/take_selfie.dart';
import 'package:provider/provider.dart';

class JoinSession extends StatefulWidget {
  JoinSession({super.key, required this.imagePath, required this.onNext, required this.onBack});
  String imagePath = "";

  void Function(Widget? next) onNext;
  void Function() onBack;
  @override
  State<StatefulWidget> createState() => _JoinSessionState();
}

class _JoinSessionState extends State<JoinSession> {
  XFile selfie = XFile("");
  TextEditingController _codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      selfie = XFile(widget.imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              height: 140,
              margin: const EdgeInsets.all(40),
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
            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text("Join your group!",
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                      child: TextFormField(
                        controller: _codeController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Group code',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: FloatingActionButton.extended(
                        onPressed: () async {
                          final available = await availableCameras();
                          final result = await Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CameraPage(cameras: available)));
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
                    const SizedBox(height: 160),
                    Consumer<SessionProvider>(
                        builder: (context, session, child) => FloatingActionButton.extended(
                              //backgroundColor: Theme.of(context).primaryColor,
                              onPressed: () async {
                                final response = await HangryApi().joinLobby(
                                    _codeController.text,
                                    selfie.path == ""
                                        ? ""
                                        : base64Encode(await selfie.readAsBytes()));

                                if (response != null) {
                                  session.setUUID(response[1] as String, response[0] as bool);
                                  widget.onNext(FoodCategoriesPage(
                                      onNext: (next) => widget.onNext(next),
                                      onBack: widget.onBack));
                                }
                              },
                              heroTag: "join",
                              label: Text("Join"),
                            ))
                  ],
                ),
              ),
            )
          ])),
    ]);
  }
}
