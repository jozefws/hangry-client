import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangryclient/view/take_selfie.dart';

class CreateSession extends StatefulWidget {
  CreateSession({super.key, required this.imagePath});
  String imagePath = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new Session"),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: ListView(children: [
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
                            backgroundImage:
                                Image.file(File(selfie.path), fit: BoxFit.fill)
                                    .image,
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
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: Text(
                          "Your group code is:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Text("5135",
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(height: 100),
                      Container(
                        width: 300,
                        child: FloatingActionButton.extended(
                          onPressed: () async {
                            final available = await availableCameras();
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        CameraPage(cameras: available)));
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
                      const SizedBox(height: 20),
                      Text("(Optional)",
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 100),
                      FloatingActionButton.extended(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        onPressed: null,
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
}
