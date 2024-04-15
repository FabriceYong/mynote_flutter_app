import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/screens/home-screen.dart';
import 'package:mynotes/screens/login_screen.dart';
// import 'package:mynotes/firebase_options.dart';
import '../components/reusableTextFormField.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static String id = 'register';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Registration',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: formKey,
                      child: Theme(
                        data: ThemeData(
                            inputDecorationTheme:
                                const InputDecorationTheme(isDense: true),
                            primaryColor: Colors.teal,
                            primaryColorDark: Colors.grey.shade200),
                        child: Column(
                          children: [
                            ReusableTextFormField(
                              prefixIcon: Icons.email,
                              hintText: 'Enter your email here...',
                              labelText: 'Enter email',
                              controller: _email,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ReusableTextFormField(
                              obscureText: _passwordVisible,
                              prefixIcon: Icons.password,
                              hintText: 'Enter your password here...',
                              labelText: 'Enter password',
                              controller: _password,
                              suffixIconButton: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.grey[200]),
                      onPressed: () async {
                        if (formKey.currentState!.validate() == true) {
                          formKey.currentState!.save();
                        }
                        try {
                          final userCredentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email.text, password: _password.text);
                          if (userCredentials.user != null) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                          print(FirebaseAuth.instance.currentUser);
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                      },
                      icon: Icon(
                        Icons.upload_rounded,
                        color: Colors.grey.shade200,
                      ),
                      label: Text(
                        'Register',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[200]),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15.0),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.purple.shade400),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              default:
                return const SpinKitThreeBounce(color: Colors.teal, size: 50.0);
            }
          },
        ),
      ),
    );
  }
}
