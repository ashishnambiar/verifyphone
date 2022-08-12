import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verifyphone/Screens/home_page.dart';
import 'package:verifyphone/Screens/user_location_page.dart';
import 'package:verifyphone/Screens/verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Phone Verification',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey[700],
            )),
        routes: {
          '/': (context) => HomePage(),
          VerificationPage.route: (context) => VerificationPage(),
          UserLocationPage.route: (context) => UserLocationPage(),
        },
      ),
    );
  }
}
