// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/screens/home-screen.dart';
import 'package:mynotes/screens/login_screen.dart';
import 'package:mynotes/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyNotes());
}

class MyNotes extends StatelessWidget {
  const MyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? HomeScreen.id
          : LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        RegistrationPage.id: (context) => const RegistrationPage(),
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
