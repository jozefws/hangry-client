import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              height: 180,
              margin: const EdgeInsets.all(40),
              child: Image.asset("images/Logo.png"),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text("Welcome to Hangry!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text("Do you want to start a group or join one",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/join');
                      },
                      label: const Text(
                        "Join",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushNamed(context, '/create');
                      },
                      label: const Text(
                        "Create",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
