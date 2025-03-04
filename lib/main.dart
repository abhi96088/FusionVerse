import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusionverse/home_screen.dart';
import 'package:fusionverse/language_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]
  );
  runApp(
      ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        child: MyApp()),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade500),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
