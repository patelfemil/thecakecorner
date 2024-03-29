import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thecakecorner/splashpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp( TheCakeCorner());
}

class TheCakeCorner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      // useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),

    ),
    debugShowCheckedModeBanner: false,
   home: SplashPage(),
  );
  }


}
