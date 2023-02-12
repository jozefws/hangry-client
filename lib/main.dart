import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hangryclient/provider/session_provider.dart';
import 'package:hangryclient/view/flow_parent.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFDE541E),
      brightness: Brightness.light,
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFDE541E),
      brightness: Brightness.dark,
    );

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SessionProvider(),
          )
        ],
        child: MaterialApp(
          title: 'Hangry',
          theme: lightTheme,
          home: const FlowParent(),
        ));
  }
}
