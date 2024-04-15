import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mynotes/components/reusableTextFormField.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/screens/home-screen.dart';
import 'package:mynotes/screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _passwordVisible = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    // _passwordVisible = true;
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
          title: Text(
            'Login',
            style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
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
                        controller: _email,
                        hintText: 'Enter your email here...',
                        labelText: 'Enter email',
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ReusableTextFormField(
                        controller: _password,
                        hintText: 'Enter your password here...',
                        labelText: 'Enter password',
                        obscureText: _passwordVisible,
                        prefixIcon: Icons.password,
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
                height: 15.0,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.grey.shade200),
                label: Text(
                  'Login',
                  style: TextStyle(color: Colors.grey.shade200),
                ),
                icon: Icon(
                  Icons.upload_rounded,
                  color: Colors.grey.shade200,
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate() == true) {
                    formKey.currentState!.save();
                  }
                  try {
                    final userCredentials = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _email.text, password: _password.text);
                    // if(userCredentials.user?.email != _email.text) {
                    //   return
                    // }
                    if (userCredentials.user != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    print(userCredentials.user);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('User not found');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password');
                    } else if (e.code == 'email-already-in-use') {
                      print('Email already in use');
                    } else if (e.code == 'invalid-password') {
                      print('Invalid password');
                    }
                    print(e.code);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account yet?',
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 15.0),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RegistrationPage.id);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.purple.shade400, fontSize: 15.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
