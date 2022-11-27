import 'package:firebase_auth/firebase_auth.dart';

import 'controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Welcome_Page.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp({super.key});
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        // Once completed, Shoew your app
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: auth.currentUser == null ? LoginPage() : Welcome_Page());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
